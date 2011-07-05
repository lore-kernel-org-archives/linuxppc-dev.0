Return-Path: <svenkatr@ti.com>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B3E8B6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jul 2011 16:22:37 +1000 (EST)
Received: by iyi20 with SMTP id 20so5621097iyi.7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Jul 2011 23:22:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
References: <1309839543-6031-1-git-send-email-tie-fei.zang@freescale.com>
	<1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
Date: Tue, 5 Jul 2011 11:47:08 +0530
Message-ID: <CANfBPZ_xXQ0ZiLOmaJ=yC=Nm9Poumb45pyTpJ7fBQ3+Zbg+ZAA@mail.gmail.com>
Subject: Re: [PATCH 2/3] eSDHC: Fix errors when booting kernel with fsl esdhc
From: "S, Venkatraman" <svenkatr@ti.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Xu lei <B33228@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>,
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

On Tue, Jul 5, 2011 at 9:49 AM, Roy Zang <tie-fei.zang@freescale.com> wrote=
:
> From: Xu lei <B33228@freescale.com>
>
> When esdhc module was enabled in p5020, there were following errors:
>
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: error -110 whilst initialising SD card
> mmc0: Unexpected interrupt 0x02000000.
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: error -110 whilst initialising SD card
> mmc0: Unexpected interrupt 0x02000000.
>
> It is because ESDHC controller has different bit setting for PROCTL
> register, when kernel sets Power Control Register by method for standard
> SD Host Specification, it would overwritten FSL ESDHC PROCTL[DMAS];
> when it set Host Control Registers[DMAS], it sets PROCTL[EMODE] and
> PROCTL[D3CD]. These operations will set bad bits for PROCTL Register
> on FSL ESDHC Controller and cause errors, so this patch will make esdhc
> driver access FSL PROCTL Register according to block guide instead of
> standard SD Host Specification.
>
> For some FSL chips, such as MPC8536/P2020, PROCTL[VOLT_SEL] and PROCTL[DM=
AS]
> bits are reserved and even if they are set to wrong bits there is no erro=
r.
> But considering that all FSL ESDHC Controller register map is not fully
> compliant to standard SD Host Specification, we put the patch to all of
> FSL ESDHC Controllers.
>
> Signed-off-by: Lei Xu <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A03 ++
> =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 62 ++++++++++++++++++++=
++++++++++-------
> =A0include/linux/mmc/sdhci.h =A0 =A0 =A0 =A0| =A0 =A06 ++-
> =A03 files changed, 57 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of=
-core.c
> index 60e4186..fede43d 100644
> --- a/drivers/mmc/host/sdhci-of-core.c
> +++ b/drivers/mmc/host/sdhci-of-core.c
> @@ -179,6 +179,9 @@ static int __devinit sdhci_of_probe(struct platform_d=
evice *ofdev)
> =A0 =A0 =A0 =A0if (sdhci_of_wp_inverted(np))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_INVERTED_WRI=
TE_PROTECT;
>
> + =A0 =A0 =A0 if (of_device_is_compatible(np, "fsl,esdhc"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_QORIQ_PROCTL_=
WEIRD;
> +
> =A0 =A0 =A0 =A0clk =3D of_get_property(np, "clock-frequency", &size);
> =A0 =A0 =A0 =A0if (clk && size =3D=3D sizeof(*clk) && *clk)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_host->clock =3D be32_to_cpup(clk);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 58d5436..77174e5 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -674,7 +674,7 @@ static void sdhci_set_transfer_irqs(struct sdhci_host=
 *host)
> =A0static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_com=
mand *cmd)
> =A0{
> =A0 =A0 =A0 =A0u8 count;
> - =A0 =A0 =A0 u8 ctrl;
> + =A0 =A0 =A0 u32 ctrl;
> =A0 =A0 =A0 =A0struct mmc_data *data =3D cmd->data;
> =A0 =A0 =A0 =A0int ret;
>
> @@ -807,14 +807,28 @@ static void sdhci_prepare_data(struct sdhci_host *h=
ost, struct mmc_command *cmd)
> =A0 =A0 =A0 =A0 * is ADMA.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (host->version >=3D SDHCI_SPEC_200) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTR=
OL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_DMA_MASK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_REQ_USE_DMA) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->flags & SDHCI_USE_AD=
MA))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_ADMA32=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_SDMA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL=
_WEIRD) {
> +#define ESDHCI_PROCTL_DMAS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0000030=
0
> +#define ESDHCI_PROCTL_ADMA32 =A0 =A0 =A0 =A0 =A0 0x00000200
> +#define ESDHCI_PROCTL_SDMA =A0 =A0 =A0 =A0 =A0 =A0 0x00000000

Breaks the code flow / readability. Can be moved to top of the file ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readl(host, =
SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~ESDHCI_PROCTL_DM=
AS_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_RE=
Q_USE_DMA) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->flag=
s & SDHCI_USE_ADMA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D E=
SDHCI_PROCTL_ADMA32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D E=
SDHCI_PROCTL_SDMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writel(host, ctrl, SD=
HCI_HOST_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, =
SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_DMA_M=
ASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_RE=
Q_USE_DMA) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->flag=
s & SDHCI_USE_ADMA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D S=
DHCI_CTRL_ADMA32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D S=
DHCI_CTRL_SDMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SD=
HCI_HOST_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!(host->flags & SDHCI_REQ_USE_DMA)) {
> @@ -1138,19 +1152,32 @@ out:
> =A0static void sdhci_set_power(struct sdhci_host *host, unsigned short po=
wer)
> =A0{
> =A0 =A0 =A0 =A0u8 pwr =3D 0;
> + =A0 =A0 =A0 u8 volt =3D 0;
>
> =A0 =A0 =A0 =A0if (power !=3D (unsigned short)-1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (1 << power) {
> +#define =A0 =A0 =A0 =A0ESDHCI_FSL_POWER_MASK =A0 0x40
> +#define =A0 =A0 =A0 =A0ESDHCI_FSL_POWER_180 =A0 =A00x00
> +#define =A0 =A0 =A0 =A0ESDHCI_FSL_POWER_300 =A0 =A00x40

<As above>

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_165_195:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D SDHCI_POWER_180;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QU=
IRK_QORIQ_PROCTL_WEIRD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D ESD=
HCI_FSL_POWER_180;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D SDH=
CI_POWER_180;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_29_30:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_30_31:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D SDHCI_POWER_300;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QU=
IRK_QORIQ_PROCTL_WEIRD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D ESD=
HCI_FSL_POWER_300;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D SDH=
CI_POWER_300;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_32_33:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_33_34:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D SDHCI_POWER_330;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QU=
IRK_QORIQ_PROCTL_WEIRD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D ESD=
HCI_FSL_POWER_300;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D SDH=
CI_POWER_330;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG();
> @@ -1162,6 +1189,17 @@ static void sdhci_set_power(struct sdhci_host *hos=
t, unsigned short power)
>
> =A0 =A0 =A0 =A0host->pwr =3D pwr;
>
> + =A0 =A0 =A0 /* Now FSL ESDHC Controller has no Bus Power bit,
> + =A0 =A0 =A0 =A0* and PROCTL[21] bit is for voltage selection */

Multiline comment style needed..

> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL_WEIRD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt =3D sdhci_readb(host, SDHCI_POWER_CONT=
ROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt &=3D ~ESDHCI_FSL_POWER_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt |=3D pwr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, volt, SDHCI_POWER_CONTRO=
L);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (pwr =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_writeb(host, 0, SDHCI_POWER_CONTROL)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 6a68c4e..d87abc7 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -21,7 +21,7 @@ struct sdhci_host {
> =A0 =A0 =A0 =A0/* Data set by hardware interface driver */
> =A0 =A0 =A0 =A0const char *hw_name; =A0 =A0/* Hardware bus name */
>
> - =A0 =A0 =A0 unsigned int quirks; =A0 =A0/* Deviations from spec. */
> + =A0 =A0 =A0 u64 quirks; =A0 =A0 /* Deviations from spec. */
>
> =A0/* Controller doesn't honor resets unless we touch the clock register =
*/
> =A0#define SDHCI_QUIRK_CLOCK_BEFORE_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<0)
> @@ -86,7 +86,9 @@ struct sdhci_host {
> =A0/* Controller treats ADMA descriptors with length 0000h incorrectly */
> =A0#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC =A0 =A0 =A0 =A0 =A0 (1<<3=
0)
> =A0/* The read-only detection via SDHCI_PRESENT_STATE register is unstabl=
e */
> -#define SDHCI_QUIRK_UNSTABLE_RO_DETECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
1<<31)
> +#define SDHCI_QUIRK_UNSTABLE_RO_DETECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
1U<<31)
> +/* Controller has weird bit setting for Protocol Control Register */
> +#define SDHCI_QUIRK_QORIQ_PROCTL_WEIRD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
0x100000000U)
>
> =A0 =A0 =A0 =A0int irq; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Device IRQ */
> =A0 =A0 =A0 =A0void __iomem *ioaddr; =A0 /* Mapped address */
> --
> 1.6.0.6
>
