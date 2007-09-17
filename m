Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id C4FCCDDE2C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 05:27:10 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1263502rvf
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 12:27:09 -0700 (PDT)
Message-ID: <fa686aa40709171227p1d6d3a43u795e1b893ae518a7@mail.gmail.com>
Date: Mon, 17 Sep 2007 13:27:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stefan Roese" <sr@denx.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
In-Reply-To: <200709170734.09079.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200709161352.03459.sr@denx.de>
	<20070916185330.GA32314@gate.ebshome.net>
	<200709170734.09079.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/16/07, Stefan Roese <sr@denx.de> wrote:
> On Sunday 16 September 2007, Eugene Surovegin wrote:
> > Hmm, I just noticed that you basically added a copy of existing
> > driver with small changes to support OF while keeping OCP one.
> >
> > Why not just add OF support to the existing code (under some ifdef),
> > and then remove OCP support as soon as ppc -> powerpc transition is
> > finished? Why have two almost identical code in the tree?
>
> My understanding was, that adding many #ifdef's into the code was not the
> preferred way. I could of course change this patch to not add an additional
> driver but extend the existing driver with a bunch of #ifdef's to support
> both versions.
>
> This approach of multiple drivers seems to be common in the kernel right now:
>
> drivers/mtd/maps/physmap.c
> drivers/mtd/maps/physmap_of.c
>
> or
>
> drivers/usb/host/ohci-ppc-soc.c
> drivers/usb/host/ohci-ppc-of.c
>
> Any other opinions on this? How should this be handled to get accepted
> upstream? Two different drivers with removing the "old" one later when
> arch/ppc is gone, or one driver which supports both versions and removing the
> ocp support in this driver later?

FWIW, I'm not a big fan of duplicating drivers, and I don't think it
should be necessary.  If a large number of #ifdef block are needed
then it may be that it would be better to refactor parts of the driver
to localize the conditionally compiled code.

Also, neither of these examples are particularly strong support.  In
both cases (physmap and ohci-ppc) the mentioned C files are bus
mappings only, not the actual driver.  In this scenario it does make
sense to use separate files, but it requires the dependent driver to
be abstracted enough to support multiple bindings.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
