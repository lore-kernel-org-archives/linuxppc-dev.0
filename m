Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 09DD92C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 16:34:01 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 20 Mar 2014 15:33:58 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0DAF3357803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 16:33:56 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2K5DhO54850148
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 16:13:44 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2K5Xr3O025637
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 16:33:54 +1100
Date: Thu, 20 Mar 2014 11:03:50 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
Message-ID: <20140320053350.GB30295@linux.vnet.ibm.com>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140319170829.GD8557@laptop.programming.kicks-ass.net>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 davidlohr@hp.com, paulus@samba.org, tglx@linutronix.de,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, torvalds@linux-foundation.org,
 mingo@kernel.org
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Joy,.. let me look at that with ppc in mind.
> 
> OK; so while pretty much all the comments from that patch are utter
> nonsense (what was I thinking), I cannot actually find a real bug.
> 
> But could you try the below which replaces a control dependency with a
> full barrier. The control flow is plenty convoluted that I think the
> control barrier isn't actually valid anymore and that might indeed
> explain the fail.
> 

Unfortunately the patch didnt help. Still seeing tasks stuck

# ps -Ao pid,tt,user,fname,tmout,f,wchan | grep futex
14680 pts/0    root     java         - 0 futex_wait_queue_me
14797 pts/0    root     java         - 0 futex_wait_queue_me
# :> /var/log/messages
# echo t > /proc/sysrq-trigger 
# grep futex_wait_queue_me /var/log/messages | wc -l 
334
#

[ 6904.211478] Call Trace:
[ 6904.211481] [c000000fa1f1b4d0] [0000000000000020] 0x20 (unreliable)
[ 6904.211486] [c000000fa1f1b6a0] [c000000000015208] .__switch_to+0x1e8/0x330
[ 6904.211491] [c000000fa1f1b750] [c000000000702f00] .__schedule+0x360/0x8b0
[ 6904.211495] [c000000fa1f1b9d0] [c000000000147348] .futex_wait_queue_me+0xf8/0x1a0
[ 6904.211500] [c000000fa1f1ba60] [c0000000001486dc] .futex_wait+0x17c/0x2a0
[ 6904.211505] [c000000fa1f1bc10] [c00000000014a614] .do_futex+0x254/0xd80
[ 6904.211510] [c000000fa1f1bd60] [c00000000014b25c] .SyS_futex+0x11c/0x1d0
[ 6904.238874] [c000000fa1f1be30] [c00000000000a0fc] syscall_exit+0x0/0x7c
[ 6904.238879] java            S 00003fff825f6044     0 14682  14076 0x00000080

Is there any other information that I provide that can help?

-- 
Thanks and Regards
Srikar Dronamraju
