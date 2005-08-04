Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EDAF67EC7
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2005 19:51:01 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20050804055459.GA19874@iram.es>
References: <20050802095509.GA32585@lst.de>
	<20050803221517.21b54d7e.akpm@osdl.org>
	<20050804055459.GA19874@iram.es>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 11:46:38 +0200
Message-Id: <1123148798.30257.62.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] fix gcc4 warning in asm-ppc/time.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-08-04 at 07:54 +0200, Gabriel Paubert wrote:
> On Wed, Aug 03, 2005 at 10:15:17PM -0700, Andrew Morton wrote:
> > Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > A function must not return a const value, instead use
> > > __attribute_const__.
> > > 
> > > 
> > > Index: linux-2.6/include/asm/time.h
> > > ===================================================================
> > > --- linux-2.6.orig/include/asm/time.h	2005-04-30 10:17:19.000000000 +0200
> > > +++ linux-2.6/include/asm/time.h	2005-08-01 11:57:12.000000000 +0200
> > > @@ -10,6 +10,7 @@
> > >  #define __ASM_TIME_H__
> > >  
> > >  #include <linux/config.h>
> > > +#include <linux/compiler.h>
> > >  #include <linux/types.h>
> > >  #include <linux/rtc.h>
> > >  #include <linux/threads.h>
> > > @@ -58,7 +59,7 @@
> > >  /* Accessor functions for the timebase (RTC on 601) registers. */
> > >  /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
> > >  #ifdef CONFIG_6xx
> > > -extern __inline__ int const __USE_RTC(void) {
> > > +extern __inline__ int __attribute_const__ __USE_RTC(void) {
> > >  	return (mfspr(SPRN_PVR)>>16) == 1;
> > >  }
> > >  #else
> > 
> > Do we really want to do this?  The above implies that mfspr(SPRN_PVR) will
> > return the same value across the entire uptime of the kernel.  Is that
> > true?
> 
> Yes, it is a read-only register. PVR means processor version register
> and is linked to the revision of the silicon. Besides that it is
> only used in this context to check for processors of the 601 family
> (the very first PPC processors). Nobody expects them to be hotpluggable,
> nor even used in SMP systems for the matter.

Yes ... However, we want to get rid of PVR accesses. They are a problem
for Xen-like virtualization without HW support (that is running the
kernel actually in user space) among other things.

The above should be replaced by a test of CPU features.

Ben.
