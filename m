Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 697631A0B77
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 11:58:28 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B074140187
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2015 11:58:28 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 13 Feb 2015 10:58:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B148B357804C
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2015 11:58:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1D0wFcs45023396
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2015 11:58:23 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D0vn8k023075
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2015 11:57:49 +1100
Message-ID: <54DD4BF6.1070503@au1.ibm.com>
Date: Fri, 13 Feb 2015 11:57:26 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
To: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 "mpe >> Michael Ellerman" <mpe@ellerman.id.au>
Subject: suspicious RCU usage clockevents_lock, tick_broadcast_lock,
 hrtimer_bases.lock
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm receiving this while booting a vanilla 3.19 kernel on a Power 8 machine:

[    2.522179] device-mapper: uevent: version 1.0.3
[    2.522741] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28)
initialised: dm-devel@redhat.com
[    2.543590]
[    2.543630] ===============================
[    2.543709] [ INFO: suspicious RCU usage. ]
[    2.543758] 3.19.0samb #2 Not tainted
[    2.543802] -------------------------------
[    2.543847] include/trace/events/timer.h:186 suspicious
rcu_dereference_check() usage!
[    2.543940]
[    2.543940] other info that might help us debug this:
[    2.543940]
[    2.544035]
[    2.544035] RCU used illegally from idle CPU!
[    2.544035] rcu_scheduler_active = 1, debug_locks = 0
[    2.544154] RCU used illegally from extended quiescent state!
[    2.544234] 3 locks held by swapper/1/0:
[    2.544284]  #0:  (clockevents_lock){-.....}, at:
[<c0000000001a45cc>] .clockevents_notify+0x5c/0x320
[    2.544464]  #1:  (tick_broadcast_lock){-.-...}, at:
[<c0000000001a7ac4>] .tick_broadcast_oneshot_control+0xe4/0x530
[    2.544654]  #2:  (hrtimer_bases.lock#2){-.-...}, at:
[<c000000000192694>] .__hrtimer_start_range_ns+0x124/0x6e0
[    2.544843]
[    2.544843] stack backtrace:
[    2.544904] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.19.0samb #2
[    2.544986] Call Trace:
[    2.545023] [c000000fdf6f7770] [c000000000faf118]
.dump_stack+0x98/0xd4 (unreliable)
[    2.545124] [c000000fdf6f77f0] [c000000000152b78]
.lockdep_rcu_suspicious+0x138/0x180
[    2.545225] [c000000fdf6f7880] [c000000000191374]
.enqueue_hrtimer+0x1c4/0x300
[    2.545325] [c000000fdf6f7910] [c00000000019276c]
.__hrtimer_start_range_ns+0x1fc/0x6e0
[    2.545425] [c000000fdf6f7a10] [c0000000001a8e90] .bc_set_next+0xc0/0xf0
[    2.545510] [c000000fdf6f7aa0] [c0000000001a51f0]
.clockevents_program_event+0x100/0x1f0
[    2.545607] [c000000fdf6f7b40] [c0000000001a6bac]
.tick_broadcast_set_event+0x6c/0x120
[    2.545705] [c000000fdf6f7bd0] [c0000000001a7c94]
.tick_broadcast_oneshot_control+0x2b4/0x530
[    2.545802] [c000000fdf6f7ca0] [c0000000001a4818]
.clockevents_notify+0x2a8/0x320
[    2.545898] [c000000fdf6f7d70] [c0000000001484f4]
.cpu_startup_entry+0x404/0x730
[    2.545995] [c000000fdf6f7ec0] [c000000000044314]
.start_secondary+0x3a4/0x460
[    2.546092] [c000000fdf6f7f90] [c000000000008bfc]
start_secondary_prolog+0x10/0x14
[    2.546555] Registering IBM Power 842 compression driver

Cheers,
Sam.
