Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5D0A8DE130
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 06:31:25 +1100 (EST)
To: Stefan Roese <sr@denx.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <200901051912.25874.sr@denx.de>
References: <1227628088-10849-1-git-send-email-sr@denx.de>
	<200812271130.12513.david-b@pacbell.net>
	<200901051912.25874.sr@denx.de>
Date: Mon, 05 Jan 2009 20:31:17 +0100
Message-Id: <20090105193117.E5AD98387CDB@gemini.denx.de>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Stefan,

In message <200901051912.25874.sr@denx.de> you wrote:
>
> > > +	/* Write new configration */
> > > +	out_8(&hw->regs->mode, cs->mode);
> > > +
> > > +	/*
> > > +	 * Allow platform reduce the interrupt load on the CPU during SPI
> > > +	 * transfers. We do not target maximum performance, but rather allow
> > > +	 * platform to limit SPI bus frequency and interrupt rate.
> >
> > That comment doesn't seem even vaguely related to the
> > code it allegedly refers to ... nothing in this routine
> > affects the IRQ load.
> 
> IIRC (I didn't write the original version of this driver) then this comments 
> simply refers to the fact that the platform can select a maximum SPI 
> frequency via spi->max_speed_hz which is pretty obvious. So I'll just remove 
> this comment in the next version.

On PPC4xx systems we get one interrupt per transferred  byte,  i.  e.
there  is  a  direct relation between SPI bus frequency and interrupt
rate.

Since this is a PPC4xx SPI driver, the comment is actually helpful to
understand the operation of the driver especially in relation to  the
limitations of the hardware.

Instead of removing the  comment  (which  leaves  the  casual  reader
clueless)  it  would probably better to add a sentence explaining the
one byte / one interrupt situation?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
...when fits of creativity run strong, more than  one  programmer  or
writer  has  been  known to abandon the desktop for the more spacious
floor.                                             - Fred Brooks, Jr.
