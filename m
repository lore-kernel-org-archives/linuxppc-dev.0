Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2BCDA2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2013 03:24:31 +1000 (EST)
Date: Fri, 19 Jul 2013 12:24:18 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4 V2] mmc: esdhc: Add broken timeout quirk for p4/p5
 board
To: Zhang Haijun-B42677 <B42677@freescale.com>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374055891-20703-3-git-send-email-Haijun.Zhang@freescale.com>
 <1374081229.8183.361@snotra>
 <99E897753B6F7048BD8CCDB4661D02E13DF50D@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E13DF50D@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B42677@freescale.com on Thu Jul 18 21:19:59 2013)
Message-ID: <1374254658.5357.19@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/2013 09:19:59 PM, Zhang Haijun-B42677 wrote:
>=20
>=20
> Thanks.
>=20
> Regards
> Haijun.
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, July 18, 2013 1:14 AM
> > To: Zhang Haijun-B42677
> > Cc: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > cbouatmailru@gmail.com; cjb@laptop.org; Fleming Andy-AFLEMING; Zhang
> > Haijun-B42677; Zhang Haijun-B42677
> > Subject: Re: [PATCH 4/4 V2] mmc: esdhc: Add broken timeout quirk for
> > p4/p5 board
> >
> > On 07/17/2013 05:11:31 AM, Haijun Zhang wrote:
> > > Sometimes command can't be completed within the time give in
> > > eSDHC_SYSCTL[DTOCV]. So just give the max value 0x14 to avoid this
> > > issue.
> > >
> > > Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> > > ---
> > > changes for v2:
> > > 	- Rebuild patch of eSDHC host need long time to generate
> > > 	 command interrupt
> > >
> > >  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > > b/drivers/mmc/host/sdhci-of-esdhc.c
> > > index 570bca8..30bfb5c 100644
> > > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > > @@ -325,6 +325,12 @@ static void esdhc_of_platform_init(struct
> > > sdhci_host *host)
> > >
> > >  	if (vvn > VENDOR_V_22)
> > >  		host->quirks &=3D ~SDHCI_QUIRK_NO_BUSY_IRQ;
> > > +
> > > +	if ((SVR_SOC_VER(svr) =3D=3D SVR_B4860) ||
> > > +		(SVR_SOC_VER(svr) =3D=3D SVR_P5020) ||
> > > +		(SVR_SOC_VER(svr) =3D=3D SVR_P5040) ||
> > > +		(SVR_SOC_VER(svr) =3D=3D SVR_P4080))
> > > +		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> > >  }
> >
> > Please don't line up the continuation lines of the if-condition =20
> with the
> > if-body.
> [Haijun Wrote:] I'll correct it.
> >
> > Please check variant SoCs as well.  If the bug exists on p4080, =20
> then it
> > exists on p4040.  Likewise with p5040/p5021, and p5020/p5010.
> >
> > Is it present on all revisions of these SoCs?  How about p3041, =20
> which is
> > usually pretty similar to p5020?  p2040/p2041?  Is there an erratum
> > number for this problem?
> >
> [Haijun Wrote:] I only checked this on these boards.

These aren't boards; they're chips.

Please find out for sure which chips are affected, or else we'll have =20
support issues later when someone is using a chip you didn't test =20
with.  And always include the fewer-core variants -- if p4080 is =20
affected, then p4040 is affected, and so on as described above.

> No errata number yet,

Will one be coming?

> This quirk only give the host max detecting time value to check =20
> card's response. No
> impact on performance or other functions.

Does this affect boot time if a card is not present?

-Scott=
