Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id B79FADDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 07:48:53 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1159387uge.0
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 14:48:51 -0700 (PDT)
Date: Fri, 18 Apr 2008 01:48:46 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
Message-ID: <20080417214846.GA3161@zarina>
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192846.GB28286@polina.dev.rtsoft.ru>
	<4807AB7A.90005@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4807AB7A.90005@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 02:56:42PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > +config QE_USB
> > +	bool
> > +	help
> > +	  QE USB Host Controller support
> 
> Don't you need something like "depends on USB"?  I would assume that you need
> core USB support before any USB drivers can be loaded.

No, I'll add there "default y if USB_HCD_FHCI", but I'll do this at the
same time as USB_HCD_FHCI merges, because otherwise I would reference not
existent Kconfig symbol.

> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/qe_lib/usb.c
> > @@ -0,0 +1,57 @@
> > +/*
> > + * QE USB routines
> > + *
> > + * Copyright (c) Freescale Semicondutor, Inc. 2006.
> > + *               Shlomi Gridish <gridish@freescale.com>
> 
> Is this code from one of our BSPs?

Well, it is based on. I'm not sure that there is a single line of the
original code, but anyway I'd better be safe than remove someone's
copyright. The same applies to FSL GTM code.

> > +int qe_usb_clock_set(enum qe_clock clk, int rate)
> > +{
> > +	struct qe_mux __iomem *mux = &qe_immr->qmx;
> > +	unsigned long flags;
> > +	const bool is_brg = clk < QE_CLK1;
> 
> You don't really need "is_brg", since it's only used once.

Hm, no. This is code that speaks. More than that, I'd prefer this in
qe.h:

static inline bool qe_clock_is_brg(enum qe_clock clk)
{
	return clk < QE_CLK1;
}

:-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
