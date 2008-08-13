Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (isa.tranzeo.com [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 2AF29DDF53
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 05:55:24 +1000 (EST)
Subject: Re: Strange Badness with RT Spin Lock
From: Darcy Watkins <dwatkins@tranzeo.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1218225371.3465.51.camel@localhost>
References: <1218225371.3465.51.camel@localhost>
Content-Type: text/plain
Date: Wed, 13 Aug 2008 12:55:22 -0700
Message-Id: <1218657322.3465.93.camel@localhost>
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

I have an update...

First please disregard the follow-up email I sent mentioning memory
barriers.  That blew up shortly after I sent out the email.

The problem appears to be resolved when I declare the spinlock variable
using the __cacheline_aligned attribute (that is without the _in_smp
suffix).

Does anyone know of an explanation as to why a spinlock may need to be
cacheline aligned in a uniprocessor system?


Regards,

Darcy


On Fri, 2008-08-08 at 12:56 -0700, Darcy Watkins wrote:
> Hello,
> 
> I have a very unusual bug I have been trying to get to the bottom of.
> 
> First the background...
> 
>    AMCC PPC405EP on embedded network device (simpler than a Taihu)
>    Kernel 2.6.25.8-rt7 with incremental patches up to 2.6.25.13
>    mPCI slot with a WiMax radio card
> 
> This is an RT-Preemption kernel.
> 
> In my system, in a real time radio (WiMax) driver, I have code that
> makes use of a spinlock to control access to a tree structure...
> 
> spinlock_t tree_lock;
> 

-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
