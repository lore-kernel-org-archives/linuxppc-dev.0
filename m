Return-Path: <r61911@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB1D5B6F8C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 16:01:30 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: "S, Venkatraman" <svenkatr@ti.com>
Subject: RE: [PATCH 2/3] eSDHC: Fix errors when booting kernel with fsl esdhc
Date: Mon, 18 Jul 2011 06:01:20 +0000
Message-ID: <2239AC579C7D3646A720227A37E0268116E839@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1309839543-6031-1-git-send-email-tie-fei.zang@freescale.com>
	<1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
	<CANfBPZ_xXQ0ZiLOmaJ=yC=Nm9Poumb45pyTpJ7fBQ3+Zbg+ZAA@mail.gmail.com>
In-Reply-To: <CANfBPZ_xXQ0ZiLOmaJ=yC=Nm9Poumb45pyTpJ7fBQ3+Zbg+ZAA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Xu Lei-B33228 <B33228@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>,
	akpm <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: S, Venkatraman [mailto:svenkatr@ti.com]
> Sent: Tuesday, July 05, 2011 14:17 PM
> To: Zang Roy-R61911
> Cc: linux-mmc; linuxppc-dev; cbouatmailru; akpm; Xu Lei-B33228; Kumar Gal=
a
> Subject: Re: [PATCH 2/3] eSDHC: Fix errors when booting kernel with fsl e=
sdhc
>=20
> On Tue, Jul 5, 2011 at 9:49 AM, Roy Zang <tie-fei.zang@freescale.com> wro=
te:
> > From: Xu lei <B33228@freescale.com>
> >
> > When esdhc module was enabled in p5020, there were following errors:
> >
> > mmc0: Timeout waiting for hardware interrupt.
> > mmc0: error -110 whilst initialising SD card
> > mmc0: Unexpected interrupt 0x02000000.
> > mmc0: Timeout waiting for hardware interrupt.
> > mmc0: error -110 whilst initialising SD card
> > mmc0: Unexpected interrupt 0x02000000.
> >
> > It is because ESDHC controller has different bit setting for PROCTL
> > register, when kernel sets Power Control Register by method for standar=
d
> > SD Host Specification, it would overwritten FSL ESDHC PROCTL[DMAS];
> > when it set Host Control Registers[DMAS], it sets PROCTL[EMODE] and
> > PROCTL[D3CD]. These operations will set bad bits for PROCTL Register
> > on FSL ESDHC Controller and cause errors, so this patch will make esdhc
> > driver access FSL PROCTL Register according to block guide instead of
> > standard SD Host Specification.
> >
> > For some FSL chips, such as MPC8536/P2020, PROCTL[VOLT_SEL] and PROCTL[=
DMAS]
> > bits are reserved and even if they are set to wrong bits there is no er=
ror.
> > But considering that all FSL ESDHC Controller register map is not fully
> > compliant to standard SD Host Specification, we put the patch to all of
> > FSL ESDHC Controllers.
> >
> > Signed-off-by: Lei Xu <B33228@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > ---
> > =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A03 ++
> > =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 62 ++++++++++++++++++=
++++++++++++-----
> --
> > =A0include/linux/mmc/sdhci.h =A0 =A0 =A0 =A0| =A0 =A06 ++-
> > =A03 files changed, 57 insertions(+), 14 deletions(-)
[snip]

> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 58d5436..77174e5 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -674,7 +674,7 @@ static void sdhci_set_transfer_irqs(struct sdhci_ho=
st
> *host)
> > =A0static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_c=
ommand
> *cmd)
> > =A0{
> > =A0 =A0 =A0 =A0u8 count;
> > - =A0 =A0 =A0 u8 ctrl;
> > + =A0 =A0 =A0 u32 ctrl;
> > =A0 =A0 =A0 =A0struct mmc_data *data =3D cmd->data;
> > =A0 =A0 =A0 =A0int ret;
> >
> > @@ -807,14 +807,28 @@ static void sdhci_prepare_data(struct sdhci_host =
*host,
> struct mmc_command *cmd)
> > =A0 =A0 =A0 =A0 * is ADMA.
> > =A0 =A0 =A0 =A0 */
> > =A0 =A0 =A0 =A0if (host->version >=3D SDHCI_SPEC_200) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CON=
TROL);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_DMA_MASK;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_REQ_USE_DMA) &&
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->flags & SDHCI_USE_=
ADMA))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_ADMA=
32;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_SDMA=
;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CONTR=
OL);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_QORIQ_PROC=
TL_WEIRD) {
> > +#define ESDHCI_PROCTL_DMAS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000=
300
> > +#define ESDHCI_PROCTL_ADMA32 =A0 =A0 =A0 =A0 =A0 0x00000200
> > +#define ESDHCI_PROCTL_SDMA =A0 =A0 =A0 =A0 =A0 =A0 0x00000000
>=20
> Breaks the code flow / readability. Can be moved to top of the file ?
The defines are only used in the following section. Why it will break
the readability?
I can also see this kind of define in the file
...
#define SAMPLE_COUNT    5

static int sdhci_get_ro(struct mmc_host *mmc)
...

Any rule should follow?


[snip]
> > @@ -1162,6 +1189,17 @@ static void sdhci_set_power(struct sdhci_host *h=
ost,
> unsigned short power)
> >
> > =A0 =A0 =A0 =A0host->pwr =3D pwr;
> >
> > + =A0 =A0 =A0 /* Now FSL ESDHC Controller has no Bus Power bit,
> > + =A0 =A0 =A0 =A0* and PROCTL[21] bit is for voltage selection */
>=20
> Multiline comment style needed..
Will update.
please help to explain your previous comment.
Thanks.
Roy
