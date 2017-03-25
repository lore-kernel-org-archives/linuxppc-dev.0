Return-Path: <srs0=9r9s=3c=linux-powerpc.org=kda@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqzPp3Yj7zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 23:00:30 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vqzPp2Q1dz8vrN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 23:00:30 +1100 (AEDT)
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vqzPn5VyLz9s7j
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2017 23:00:29 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id p189so6508333pfp.1
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2017 05:00:29 -0700 (PDT)
MIME-Version: 1.0
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Sat, 25 Mar 2017 15:00:27 +0300
Message-ID: <CAOJe8K3h2a9QDb0F7cTUUxFNP_i7w4LGy4eedFYSzLOuoJwRbg@mail.gmail.com>
Subject: kvmppc: BUG: using smp_processor_id() in preemptible
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Now with the proper subject]

Hi,

the commit 5a319350a46572d073042a3194676099dd2c135d
has introduces the following warning with CONFIG_DEBUG_PREEMPT enabled:

[  129.314426] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5459
[  129.314580] caller is .kvmppc_book3s_init_hv+0x184/0x350 [kvm_hv]
[  129.314697] CPU: 11 PID: 5459 Comm: modprobe Not tainted
4.11.0-rc3-00022-gc7e790c #1
[  129.314848] Call Trace:
[  129.314915] [c0000007d624b810] [c0000000023eef10]
.dump_stack+0xe4/0x150 (unreliable)
[  129.315065] [c0000007d624b8a0] [c000000001f6ec04]
.check_preemption_disabled+0x134/0x150
[  129.315210] [c0000007d624b940] [d00000000a010274]
.kvmppc_book3s_init_hv+0x184/0x350 [kvm_hv]
[  129.315339] [c0000007d624ba00] [c00000000191d5cc] .do_one_initcall+0x5c/0x1c0
[  129.315416] [c0000007d624bad0] [c0000000023e9494] .do_init_module+0x84/0x240
[  129.315492] [c0000007d624bb70] [c000000001aade18] .load_module+0x1f68/0x2a10
[  129.315568] [c0000007d624bd20] [c000000001aaeb30] .SyS_finit_module+0xc0/0xf0
[  129.315645] [c0000007d624be30] [c00000000191baec] system_call+0x38/0xfc

I think that we have to explicitly add a call to preempt_disable to
the get_paca() macro with the CONFIG_DEBUG_PREEMPT enabled.

Probably we need to create a common accessor function since we already
have a special cases like svcpu_get/svcpu_put

If you agree I'm going send a patch.

Thanks!
