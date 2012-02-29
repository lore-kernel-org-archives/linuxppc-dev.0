Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 423BEB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 01:19:07 +1100 (EST)
Received: by wgbdt14 with SMTP id dt14so2612181wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 06:19:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1330505221-3678-1-git-send-email-mla@apm.com>
References: <1330505221-3678-1-git-send-email-mla@apm.com>
Date: Wed, 29 Feb 2012 09:18:16 -0500
Message-ID: <CA+5PVA4UAztYrJPqCqC9=T9brojOg2g=T--+BbMP8Br=xBrxfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/44x: Fix PCI MSI support for APM821xx SoC and
 Bluestone board
From: Josh Boyer <jwboyer@gmail.com>
To: Mai La <mla@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: open-source-review@apm.com, Tirumala R Marri <tmarri@apm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 29, 2012 at 3:47 AM, Mai La <mla@apm.com> wrote:
> This patch consists of:
> - Enable PCI MSI as default for Bluestone board
> - Define number of MSI interrupt for Maui APM821xx

What is Maui?  Is that the same thing as Bluestone?

> - Fix returning ENODEV as finding MSI node
> - Fix MSI physical high and low address
> - Keep MSI data logically
>
> Signed-off-by: Mai La <mla@apm.com>

Wow.  So there are a lot of bugfixes here.  I'm surprised this ever worked =
at
all with some of the things you're fixing.  Nice to see.

> ---
> =A0arch/powerpc/platforms/44x/Kconfig | =A0 =A02 ++
> =A0arch/powerpc/sysdev/ppc4xx_msi.c =A0 | =A0 28 ++++++++++++++++++------=
----
> =A02 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/=
44x/Kconfig
> index fcf6bf2..9f04ce3 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -23,6 +23,8 @@ config BLUESTONE
> =A0 =A0 =A0 =A0default n
> =A0 =A0 =A0 =A0select PPC44x_SIMPLE
> =A0 =A0 =A0 =A0select APM821xx
> + =A0 =A0 =A0 select PCI_MSI
> + =A0 =A0 =A0 select PPC4xx_MSI
> =A0 =A0 =A0 =A0select IBM_EMAC_RGMII
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option enables support for the APM APM821xx Evalu=
ation board.
> diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4x=
x_msi.c
> index 1c2d7af..6103908 100644
> --- a/arch/powerpc/sysdev/ppc4xx_msi.c
> +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
> @@ -31,7 +31,7 @@
> =A0#include <asm/prom.h>
> =A0#include <asm/hw_irq.h>
> =A0#include <asm/ppc-pci.h>
> -#include <boot/dcr.h>
> +#include <asm/dcr.h>
> =A0#include <asm/dcr-regs.h>
> =A0#include <asm/msi_bitmap.h>
>
> @@ -43,7 +43,12 @@
> =A0#define PEIH_FLUSH0 =A0 =A00x30
> =A0#define PEIH_FLUSH1 =A0 =A00x38
> =A0#define PEIH_CNTRST =A0 =A00x48
> +
> +#ifdef CONFIG_APM821xx
> +#define NR_MSI_IRQS =A0 =A08
> +#else
> =A0#define NR_MSI_IRQS =A0 =A04
> +#endif

Hm.  Do you think this is going to change quite a bit depending on which So=
C
is being used?  If so, it might be better to introduce a Kconfig variable
that just defines this instead.  Something like:

	config 4xx_MSI_IRQS
	   int "Number of MSI IRQs"
	   depends on 4xx
	   default "8" if APM821xx
	   default "4" if !APM821xx

If there aren't going to be a wide variety of numbers, then the simple ifde=
f
you have is probably sufficient.

> =A0struct ppc4xx_msi {
> =A0 =A0 =A0 =A0u32 msi_addr_lo;
> @@ -150,12 +155,11 @@ static int ppc4xx_setup_pcieh_hw(struct platform_de=
vice *dev,
> =A0 =A0 =A0 =A0if (!sdr_addr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> - =A0 =A0 =A0 SDR0_WRITE(sdr_addr, (u64)res.start >> 32); =A0 =A0 =A0/*HI=
GH addr */
> - =A0 =A0 =A0 SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low ad=
dr */
> -
> + =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr, res.start >> 32); =A0 =A0 =A0 /*HIG=
H addr */
> + =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr + 1, res.start & 0xFFFFFFFF);/* Low =
addr */

Don't you still want the (u64) cast on res.start?

> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,
> is for the sole use of the intended recipient(s) and contains information
> that is confidential and proprietary to AppliedMicro Corporation or its s=
ubsidiaries.
> It is to be used solely for the purpose of furthering the parties' busine=
ss relationship.
> All unauthorized review, use, disclosure or distribution is prohibited.
> If you are not the intended recipient, please contact the sender by reply=
 e-mail
> and destroy all copies of the original message.

Is there a way you can drop this?  Others from APM seem to have figured out
how to do that, so hopefully it won't be a big problem.

josh
