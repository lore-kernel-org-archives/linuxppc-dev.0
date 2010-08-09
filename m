Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id C3E97B6EF7
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 15:50:45 +1000 (EST)
Received: by gyh4 with SMTP id 4so5896915gyh.15
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Aug 2010 22:50:44 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60AEA19@zch01exm23.fsl.freescale.net>
References: <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
	<3850A844E6A3854C827AC5C0BEC7B60AEA19@zch01exm23.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 8 Aug 2010 23:50:24 -0600
Message-ID: <AANLkTimOtWeDNewWfoCteJW7UN2cCrY-SPv7h6qsTL_-@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
To: Zang Roy-R61911 <r61911@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 4, 2010 at 8:14 PM, Zang Roy-R61911 <r61911@freescale.com> wrot=
e:
>> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> > index c6d1bd8..a92566e 100644
>> > --- a/drivers/mmc/host/sdhci.c
>> > +++ b/drivers/mmc/host/sdhci.c
>> > @@ -817,8 +817,12 @@ static void
>> sdhci_set_transfer_mode(struct sdhci_host *host,
>> > =A0 =A0 =A0 =A0WARN_ON(!host->data);
>> >
>> > =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
>> > - =A0 =A0 =A0 if (data->blocks > 1)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
>> > + =A0 =A0 =A0 if (data->blocks > 1) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks &
>> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MUL=
TI |
>> SDHCI_TRNS_ACMD12;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MUL=
TI;
>>
>> nit:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_=
READ_ACMD12)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_ACMD1=
2;
>>
>> Clearer, no?
> why?

Shorter lines, fewer lines, and the SDHCI_TRNS_MULTI is more obviously
unconditional.  But as I said, it is a nitpick.

g.
