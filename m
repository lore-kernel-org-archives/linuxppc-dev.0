Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 634E4B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2012 09:21:02 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 30 Apr 2012 17:20:58 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9B9AFC9006C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 19:20:52 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3UNKs6G077060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 19:20:54 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3UNKrT3000483
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 17:20:53 -0600
Date: Mon, 30 Apr 2012 16:14:33 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Hugh Dickins <hughd@google.com>
Subject: Re: linux-next ppc64: RCU mods cause __might_sleep BUGs
Message-ID: <20120430231433.GO2429@linux.vnet.ibm.com>
References: <alpine.LSU.2.00.1204301451270.2986@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LSU.2.00.1204301451270.2986@eggly.anvils>
Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2012 at 03:37:10PM -0700, Hugh Dickins wrote:
> Hi Paul,
> 
> On 3.4.0-rc4-next-20120427 and preceding linux-nexts (I've not tried
> rc5-next-20120430 but expect it's the same), on PowerPC G5 quad with
> CONFIG_PREEMPT=y and CONFIG_DEBUG_ATOMIC_SLEEP=y, I'm getting spurious
> "BUG: sleeping function called from invalid context" messages from
> __might_sleep().
> 
> Just once I saw such a message during startup.  Once I saw such a
> message when rebuilding the machine's kernel.  Usually I see them
> when I'm running a swapping load of kernel builds under memory
> pressure (but that's what I'm habitually running there): perhaps
> after a few minutes a flurry comes, then goes away, comes back
> again later, and after perhaps a couple of hours of that I see
> "INFO: rcu_preempt detected stalls" messages too, and soon it
> freezes (or perhaps it's still running, but I'm so flooded by
> messages that I reboot anyway).
> 
> Rather like from before you fixed schedule_tail() for your per-cpu
> RCU mods, but not so easy to reproduce.  I did a bisection and indeed
> it converged as expected on the RCU changes.  No such problem seen on
> x86: it looks as if there's some further tweak required on PowerPC.
> 
> Here are my RCU config options (I don't usually have the TORTURE_TEST
> in, but tried that for half an hour this morning, in the hope that it
> would generate the issue: but it did not).
> 
> # RCU Subsystem
> CONFIG_TREE_PREEMPT_RCU=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_RCU_FANOUT=64
> # CONFIG_RCU_FANOUT_EXACT is not set
> CONFIG_TREE_RCU_TRACE=y
> # CONFIG_RCU_BOOST is not set
> CONFIG_HAVE_RCU_TABLE_FREE=y
> # CONFIG_SPARSE_RCU_POINTER is not set
> CONFIG_RCU_TORTURE_TEST=m
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> # CONFIG_RCU_CPU_STALL_VERBOSE is not set
> # CONFIG_RCU_CPU_STALL_INFO is not set
> CONFIG_RCU_TRACE=y
> 
> Here's the message when I was rebuilding the G5's kernel:
> 
> BUG: sleeping function called from invalid context at include/linux/pagemap.h:354
> in_atomic(): 0, irqs_disabled(): 0, pid: 6886, name: cc1
> Call Trace:
> [c0000001a99f78e0] [c00000000000f34c] .show_stack+0x6c/0x16c (unreliable)
> [c0000001a99f7990] [c000000000077b40] .__might_sleep+0x11c/0x134
> [c0000001a99f7a10] [c0000000000c6228] .filemap_fault+0x1fc/0x494
> [c0000001a99f7af0] [c0000000000e7c9c] .__do_fault+0x120/0x684
> [c0000001a99f7c00] [c000000000025790] .do_page_fault+0x458/0x664
> [c0000001a99f7e30] [c000000000005868] handle_page_fault+0x10/0x30
> 
> I've plenty more examples, most of them from page faults or from kswapd;
> but I don't think there's any more useful information in them.
> 
> Anything I can try later on?

Interesting...  As you say, I saw this sort of thing before applying
the changes to schedule_tail(), and it is all too possible that there
is some other "sneak path" for context switches.

Have you tried running with CONFIG_PROVE_RCU?  This enables some
additional debugging in rcu_switch_from() and rcu_switch_to() that
helped track down the schedule_tail() problem.

						Thanx, Paul
