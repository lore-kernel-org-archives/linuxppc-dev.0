Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 4F0042BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 08:09:27 +1000 (EST)
Date: Thu, 7 Oct 2004 15:09:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20041007220924.GT14773@smtp.west.cox.net>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
	<20041007173023.GK14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
	<20041007184840.GN14773@smtp.west.cox.net>
	<0927BD6D-18A9-11D9-9049-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0927BD6D-18A9-11D9-9049-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] remove obsolete arch/ppc/8xx_io/uart.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 07, 2004 at 05:37:06PM -0400, Dan Malek wrote:
> 
> On Oct 7, 2004, at 2:48 PM, Tom Rini wrote:
> 
> >>  CONFIG_8xx_UART
> >>  CONFIG_SMC2_UART
> >>  CONFIG_ALTSMC2
> >>  CONFIG_CONS_SMC2
> >>  CONFIG_USE_SCC_IO
> >
> >Not all of these options exist in linux-2.6.
> 
> Why not?  They must or some equivalent to get these features.
> I dislike this 2.6 "forward progress" that continually removes
> features we have deemed necessary in previous kernel versions.

Because some stuff to the now-dead uart driver never made it past
linuxppc-2.5.  Specifically I believe it was 8xx_UART that didn't.

> >I think this had been discussed before, but perhaps not.  What should
> >happen at some point is something more like "Do you hae SMC1 ? What is
> >it? Do you have SMC2 ? What is it? Do youhave SCC1? What is it?" and so
> >on.  For now, I wouldn't worry about it.
> 
> I don't understand the "what is it?" part of these questions.  As I
> have continually pointed out over the years, we don't have "SMC" or
> "SCC" drivers.

Right.  But we don't have ethernet and serial on SMC1.  What I was
talking about is we ask what driver should take care of SMC1, SMC2,
SCC1, and so on.  You could just be smart and not configure 2
drivers to use the same SMC or SCC as well.  What Robert was talking
about was making the system smart enough to not let you do it.  And
with 2.6 Kconfig syntax, this isn't as painful as it would have been
before.

-- 
Tom Rini
http://gate.crashing.org/~trini/
