Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 11BF6B7230
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 06:14:09 +1000 (EST)
Date: Thu, 18 Jun 2009 00:13:29 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] sdhci: Add support for hosts that are only capable of
	1-bit transfers
Message-ID: <20090617201329.GA9149@oksana.dev.rtsoft.ru>
References: <20090611201545.GA15942@oksana.dev.rtsoft.ru>
	<fa686aa40906130840lfb751a7xc9e24646c860a76d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40906130840lfb751a7xc9e24646c860a76d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Pierre Ossman <pierre@ossman.eu>,
	devicetree-discuss@ozlabs.org, sdhci-devel@lists.ossman.eu
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 13, 2009 at 09:40:02AM -0600, Grant Likely wrote:
> On Thu, Jun 11, 2009 at 2:15 PM, Anton
> Vorontsov<avorontsov@ru.mvista.com> wrote:
> > Some hosts (hardware configurations, or particular SD/MMC slots) may
> > not support 4-bit bus. For example, on MPC8569E-MDS boards we can
> > switch between serial (1-bit only) and nibble (4-bit) modes, thought
> > we have to disable more peripherals to work in 4-bit mode.
> >
> > Along with some small core changes, this patch modifies sdhci-of
> > driver, so that now it looks for "mode" property in the device-tree.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >
> > Pierre, I'm not sure if a quirk would be appropriate here. If so,
> > I can redo the patch with FORCE_1_BIT_DATA quirk.
> >
> > Thanks,
> >
> >  Documentation/powerpc/dts-bindings/fsl/esdhc.txt |    2 ++
> >  drivers/mmc/host/sdhci-of.c                      |    7 +++++++
> >  drivers/mmc/host/sdhci-pci.c                     |    1 +
> >  drivers/mmc/host/sdhci.c                         |    2 +-
> >  4 files changed, 11 insertions(+), 1 deletions(-)
> >
> > diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> > index 5093ddf..298b865 100644
> > --- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> > +++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> > @@ -10,6 +10,8 @@ Required properties:
> >   - interrupts : should contain eSDHC interrupt.
> >   - interrupt-parent : interrupt source phandle.
> >   - clock-frequency : specifies eSDHC base clock frequency.
> > +  - mode : specifies eSDHC mode, valid values are: "1-bit" and "4-bit".
> > +    If mode is unspecified, then 4-bit mode is assumed.
> 
> In light of Pierre's comment that 4-bit is mandatory and this is a
> deviation, perhaps it would be better to define an empty property to
> indicate that only 1-bit transfers work.  Maybe something along the
> lines of "sdhc-1-bit-only"?

Yeah, since it turned up to be a quirk, we'd better use a named
property.

(I think that by convention we should use commas for
controller-specific properties, i.e. "sdhci,property".)


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
