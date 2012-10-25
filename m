Return-Path: <cbouatmailru@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 57B1B2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 21:33:44 +1100 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kq12so977045pab.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 03:33:42 -0700 (PDT)
Date: Thu, 25 Oct 2012 03:30:38 -0700
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: [PATCH] powerpc/esdhc: enable the card insert/remove interrupt
Message-ID: <20121025103038.GA5107@lizard>
References: <1350975677-8195-1-git-send-email-r66093@freescale.com>
 <20121023082648.GA21690@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1C68D9@039-SN1MPN1-003.039d.mgd.msft.net>
 <110EED8CC96DFC488B7E717A2027A27C1D7A42@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C1D7A42@039-SN1MPN1-003.039d.mgd.msft.net>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Chris Ball <cjb@laptop.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 25, 2012 at 10:05:44AM +0000, Huang Changming-R66093 wrote:
> Hi, Anton.
> Could you have any comment about it?
> If not, I will resend this patch with v2.

Technically, the patch looks fine.

But again, as far as I recall, the card detection logic was broken on the
SOC level (it's actually very hard to break it on the board level -- it
would either work or not, but in the eSDHC case it was just unreliable,
again, if I recall everything correctly -- I might be wrong).

Of course you know the hardware much better, so your words weight more, so
you don't need my ack on the patch. :)

Although there's a second issue: for P4080DS and mpc837x boards you still
have the same problem with polling method, right? It is causing
performance drops/freezes every like 100 ms, and that's why you want to
avoid the polling.

So, you've "fixed" some boards, but left others to suffer. Ideally, the
best fix would be to also make the card polling cheap.

Anyways, using (d) clause of the "Reviewer's statement of oversight", I
can easily give this:

	Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

:)

Thanks!

[...]
> > > IIRC, the card detection is broken SOC-revision-wise, not board-wise.
> > > So the change seems wrong.
> > >
> > > Also, take a look at this:
> > >
> > > 	http://lkml.org/lkml/2010/7/14/127
> > >
> > > I started the work but never finished, unfortunately it caused some
> > > regressions for non-FSL hardware...
> > >
> > > >  drivers/mmc/host/sdhci-of-esdhc.c |    7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > > > b/drivers/mmc/host/sdhci-of-esdhc.c
> > > > index ffc1226..5dc362f 100644
> > > > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > > > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > > > @@ -196,6 +196,11 @@ static void esdhc_of_detect_limitation(struct
> > > platform_device *pdev,
> > > >  	if (vvn == VENDOR_V_22)
> > > >  		pdata->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> > > >
> > > > +	/* P4080DS and MPC837XMDS board don't support interrupt mode */
> > > > +	if (of_machine_is_compatible("fsl,mpc837xmds") ||
> > > > +	    of_machine_is_compatible("fsl,P4080DS"))
> > > > +		pdata->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > > > +
> > > >  	iounmap(ioaddr);
> > > >  end:
> > > >  	return;
> > > > @@ -223,7 +228,7 @@ static struct sdhci_pltfm_data sdhci_esdhc_pdata
> > > > =
> > > {
> > > >  	 * card detection could be handled via GPIO
> > > >  	 * eSDHC cannot support End Attribute in NOP ADMA descriptor
> > > >  	 */
> > > > -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> > > > +	.quirks = ESDHC_DEFAULT_QUIRKS
> > > >  		| SDHCI_QUIRK_NO_CARD_NO_RESET
> > > >  		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> > > >  	.ops = &sdhci_esdhc_ops,
> > > > --
> > > > 1.7.9.5
