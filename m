Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BDDBEB6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2012 04:51:35 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 7 May 2012 14:51:30 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0431338C807F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2012 14:50:42 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q47IodJ4094938
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2012 14:50:40 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q47IoTVA007248
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2012 12:50:29 -0600
Date: Mon, 7 May 2012 11:50:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Hugh Dickins <hughd@google.com>
Subject: Re: linux-next ppc64: RCU mods cause __might_sleep BUGs
Message-ID: <20120507185017.GA21152@linux.vnet.ibm.com>
References: <20120501142208.GA2441@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1205011410360.28232@eggly.anvils>
 <20120501232516.GR2441@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1205021324430.24246@eggly.anvils>
 <1335993615.4088.1.camel@pasglop>
 <20120502215406.GL2450@linux.vnet.ibm.com>
 <CANsGZ6bw4JwMRgUriooDvFB=g-HkpyL8XJa9s47RPfOEPCMcpw@mail.gmail.com>
 <20120503001433.GO2450@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1205021721350.24869@eggly.anvils>
 <alpine.LSU.2.00.1205070858450.1416@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LSU.2.00.1205070858450.1416@eggly.anvils>
Cc: linuxppc-dev@lists.ozlabs.org, Christoph Lameter <cl@linux-foundation.org>,
 linux-kernel@vger.kernel.org, "Paul E. McKenney" <paul.mckenney@linaro.org>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 07, 2012 at 09:21:54AM -0700, Hugh Dickins wrote:
> On Wed, 2 May 2012, Hugh Dickins wrote:
> > On Wed, 2 May 2012, Paul E. McKenney wrote:
> > > 
> > > In any case, I must confess that I feel quite silly about my series
> > > of patches.  I have reverted them aside from a couple that did useful
> > > optimizations, and they should show up in -next shortly.
> > 
> > A wee bit sad, but thank you - it was an experiment worth trying,
> > and perhaps there will be reason to come back to it future.
> 
> The revert indeed showed up in next-20120504: thanks, no problem now.
> 
> But although it's just history, and not worth anyone's time to
> investigate, I shouldn't let this thread die without an epilogue.
> 
> Although the patch I posted (this_cpu_inc in __rcu_read_lock,
> preempt_disable and enable in __rcu_read_unlock) ran well until
> I killed the test after 70 hours, it did not _entirely_ eliminate
> the sleeping function BUG messages.
> 
> In 70 hours I got six isolated messages like the below (but from
> different __might_sleep callsites) - where before I'd have flurries
> of hundreds(?) and freeze within the hour.
> 
> And the "rcu_nesting" debug line I'd added to the message was different:
> where before it was showing ffffffff on some tasks and 1 on others i.e.
> increment or decrement had been applied to the wrong task, these messages
> now all showed 0s throughout i.e. by the time the message was printed,
> there was no longer any justification for the message.
> 
> As if a memory barrier were missing somewhere, perhaps.

These fields should be updated only by the corresponding CPU, so
if memory barriers are needed, it seems to me that the cross-CPU
access is the bug, not the lack of a memory barrier.

Ah...  Is preemption disabled across the access to RCU's nesting level
when printing out the message?  If not, a preeemption at that point
could result in the value printed being inaccurate.

							Thanx, Paul

> BUG: sleeping function called from invalid context at arch/powerpc/mm/fault.c:305
> cpu=2 preempt_count=0 preempt_offset=0 rcu_nesting=0 nesting_save=0
> in_atomic(): 0, irqs_disabled(): 0, pid: 12266, name: cc1
> Call Trace:
> [c000000003affac0] [c00000000000f36c] .show_stack+0x6c/0x16c (unreliable)
> [c000000003affb70] [c000000000078788] .__might_sleep+0x150/0x170
> [c000000003affc00] [c0000000000255f4] .do_page_fault+0x288/0x664
> [c000000003affe30] [c000000000005868] handle_page_fault+0x10/0x30
> 
> Hugh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
