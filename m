Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9236B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2012 23:39:21 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 1 May 2012 07:39:18 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B5BB61FF0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2012 07:39:11 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q41Dd3CV186360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 May 2012 07:39:03 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q41Dd1IW004307
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 May 2012 07:39:02 -0600
Date: Tue, 1 May 2012 06:39:00 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next ppc64: RCU mods cause __might_sleep BUGs
Message-ID: <20120501133900.GA4462@linux.vnet.ibm.com>
References: <alpine.LSU.2.00.1204301451270.2986@eggly.anvils>
 <1335832418.20866.95.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335832418.20866.95.camel@pasglop>
Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 01, 2012 at 10:33:38AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-04-30 at 15:37 -0700, Hugh Dickins wrote:
> > 
> > BUG: sleeping function called from invalid context at include/linux/pagemap.h:354
> > in_atomic(): 0, irqs_disabled(): 0, pid: 6886, name: cc1
> 
> Hrm ... in_atomic and irqs_disabled are both 0 ... so yeah it smells
> like a preempt count problem... odd.

All of the preempt-count patches are now in mainline.  :-(

The CONFIG_PROVE_RCU checks verify that either the task is new or it
is the same task that was last context-switched to on this CPU.  So
the most likely suspect is a newly created task that starts running
without schedule_tail() being invoked on the path from parent task
to child task.  If so, the fix would be to invoke rcu_switch_from()
and rcu_switch_to() on that code path.

So, does Power have a way of switching to a new task without involving
schedule_tail()?  I convinced myself that my old bugbear, usermode helpers,
aren't causing this problem, but I could easily be missing something.

> Did you get a specific bisect target yet ?

On this one, Hugh is close enough.  ;-)

							Thanx, Paul

> Cheers,
> Ben.
> 
> > Call Trace:
> > [c0000001a99f78e0] [c00000000000f34c] .show_stack+0x6c/0x16c (unreliable)
> > [c0000001a99f7990] [c000000000077b40] .__might_sleep+0x11c/0x134
> > [c0000001a99f7a10] [c0000000000c6228] .filemap_fault+0x1fc/0x494
> > [c0000001a99f7af0] [c0000000000e7c9c] .__do_fault+0x120/0x684
> > [c0000001a99f7c00] [c000000000025790] .do_page_fault+0x458/0x664
> > [c0000001a99f7e30] [c000000000005868] handle_page_fault+0x10/0x30
> > 
> > I've plenty more examples, most of them from page faults or from kswapd;
> > but I don't think there's any more useful information in them.
> > 
> > Anything I can try later on? 
> 
