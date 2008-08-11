Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (mail.tranzeo.com [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id AFEFDDDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Aug 2008 01:30:54 +1000 (EST)
Subject: Re: Strange Badness with RT Spin Lock
From: Darcy Watkins <dwatkins@tranzeo.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1218225371.3465.51.camel@localhost>
References: <1218225371.3465.51.camel@localhost>
Content-Type: text/plain
Date: Mon, 11 Aug 2008 08:30:52 -0700
Message-Id: <1218468652.3465.60.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Further to what I reported earlier regarding my unusual bug, adding a
memory barrier such as shown below also prevents the oops (and is a lot
cleaner than putting in unused dummy static instance(s) of spinlocks).

This has me scratching my head.  Isn't the PPC405EP a uni-processor?  I
suppose my problem could be an interaction of RT-Preemption with
predictive loads / deferred stores or perhaps there is a memory barrier
related bug in the spinlock/rtmutex code?.


>         // We dispatch the PDU.
>          ...
> 
> #ifdef USE_MUTEX_CHECK_HACK
>          MUTEX_CHECK_SAVE_LOCKED;
> #endif
>          spin_unlock(&tree_lock);
> #ifdef USE_MUTEX_CHECK_HACK
>          rt_mutex_owner_check("process_packed_pdu() - no frag - before
> cblk()");
>          MUTEX_CHECK_SAVE_UNLOCKED;
> #endif
>          clbk(new_skb, gen_header_p->cid);
> 
> 

         barrier(); // memory barrier

> #ifdef USE_MUTEX_CHECK_HACK
>          MUTEX_CHECK_DUMP_ON_BUG;
>          rt_mutex_owner_check("process_packed_pdu() - no frag - after
> cblk()");
> #endif
>          spin_lock(&tree_lock);




On Fri, 2008-08-08 at 12:56 -0700, Darcy Watkins wrote:
> Hello,
> 
> I have a very unusual bug I have been trying to get to the bottom of.
> 
--snip!--


-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
