Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id A29C5DDDF2
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 10:03:11 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so247447and
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 15:03:10 -0800 (PST)
Message-ID: <fa686aa40711051503r342cba1er4d0957a51602bfe@mail.gmail.com>
Date: Mon, 5 Nov 2007 16:03:09 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <472F915F.9010400@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com> <472F9086.2060606@genesi-usa.com>
	<472F915F.9010400@freescale.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> Matt Sealey wrote:
> > Scott Wood wrote:
> >> Jon Smirl wrote:
> >
> >>>>> cell-index = <1>;
> >>>> What is cell-index for?
> >>> I was using it to control the bus number, is that the wrong
> >>> attribute?
> >>
> >> It shouldn't be specified at all -- the hardware has no concept of
> >> a device number.
> >
> > Well, all i2c devices have a chip id you can probe for,
>
> I meant a controller device number (a.k.a. bus number), which (outside
> of documentation) is purely a Linux invention, and which is what
> cell-index was being used for above.
>
> > as for buses I think cell-index is a holdover from the way the PSC
> > code is organised on the MPC5200 for example - if you have multiple
> > buses which use the same registers, for example. It's redundant on
> > the PSC's for programming because they all use different register
> > offsets but if you move to other devices like the GPTs, then it is
> > then useful for debugging (it is far more interesting to say GPT1
> > than GPT @ offset to match the)

Actually, it is not intended for this.  cell-index is not intended to
be able to say GPT1 instead of GPT@xxx (while that may be possible, it
is not the intent).  Nor is it a holdover from the PSC code design.
It is designed to describe the internal structure of the SoC.  The
5200 has 6 PSCs, and there are some chip registers which are shared
between all the PSCs (for clocking, IO mode, etc).  It is not
sufficient to simply plop down a device tree node for each PSC because
it doesn't give enough information about which bits to use in the
shared regs.  (For example, the port_config register)

> > and in general for tweaking OTHER
> > parts of the chip (for instance the CDM - very relevant!) which use
> > single registers to control entire swathes of units.
>
> Right, that's what cell-index is for.  This is different. :-)

Yes, this is correct.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
