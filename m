Return-Path: <chenhui.zhao@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10057.outbound.protection.outlook.com [40.107.1.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjygG1XVjzDrVM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 21:05:44 +1000 (AEST)
From: "C.H. Zhao" <chenhui.zhao@nxp.com>
To: Scott Wood <oss@buserror.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "z.chenhui@gmail.com" <z.chenhui@gmail.com>, Jason Jin <jason.jin@nxp.com>
Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
Date: Tue, 27 Sep 2016 11:05:37 +0000
Message-ID: <AM4PR0401MB23559F508FC92E0FD670998095CC0@AM4PR0401MB2355.eurprd04.prod.outlook.com>
References: <1470139172-12699-5-git-send-email-chenhui.zhao@nxp.com>,
 <20160925072400.GA17928@home.buserror.net>
In-Reply-To: <20160925072400.GA17928@home.buserror.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


From: Scott Wood <oss@buserror.net>
Sent: Sunday, September 25, 2016 3:24 PM
To: C.H. Zhao
Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; z.chenhui@=
gmail.com; Jason Jin
Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
=A0  =20
On Tue, Aug 02, 2016 at 07:59:31PM +0800, Chenhui Zhao wrote:
> T104x has deep sleep feature, which can switch off most parts of
> the SoC when it is in deep sleep mode. This way, it becomes more
> energy-efficient.
>=20
> The DDR controller will also be powered off in deep sleep. Therefore,
> the last stage (the latter part of fsl_dp_enter_low) will run without DDR
> access. This piece of code and related TLBs are prefetched in advance.
>=20
> Due to the different initialization code between 32-bit and 64-bit, they
> have separate resume entry and precedure.
>=20
> The feature supports 32-bit and 64-bit kernel mode.
>=20
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> ---
>=A0 arch/powerpc/include/asm/fsl_pm.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0 24 ++
>=A0 arch/powerpc/kernel/asm-offsets.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0 12 +
>=A0 arch/powerpc/kernel/fsl_booke_entry_mapping.S |=A0 10 +
>=A0 arch/powerpc/kernel/head_64.S=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0 2 +-
>=A0 arch/powerpc/platforms/85xx/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 1 +
>=A0 arch/powerpc/platforms/85xx/deepsleep.c=A0=A0=A0=A0=A0=A0 | 278 ++++++=
++++++++
>=A0 arch/powerpc/platforms/85xx/qoriq_pm.c=A0=A0=A0=A0=A0=A0=A0 |=A0 25 ++
>=A0 arch/powerpc/platforms/85xx/t104x_deepsleep.S | 531 ++++++++++++++++++=
++++++++
>=A0 arch/powerpc/sysdev/fsl_rcpm.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 8 +-
>=A0 9 files changed, 889 insertions(+), 2 deletions(-)
>=A0 create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
>=A0 create mode 100644 arch/powerpc/platforms/85xx/t104x_deepsleep.S
>=20
> diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm=
/fsl_pm.h
> index e05049b..48c2631 100644
> --- a/arch/powerpc/include/asm/fsl_pm.h
> +++ b/arch/powerpc/include/asm/fsl_pm.h
> @@ -20,6 +20,7 @@
>=A0=20
>=A0 #define PLAT_PM_SLEEP=A0=A0=A0=A0=A0=A0=A0 20
>=A0 #define PLAT_PM_LPM20=A0=A0=A0=A0=A0=A0=A0 30
> +#define PLAT_PM_LPM35=A0=A0=A0=A0=A0=A0=A0 40
>=A0=20
>=A0 #define FSL_PM_SLEEP=A0=A0=A0=A0=A0=A0=A0=A0 (1 << 0)
>=A0 #define FSL_PM_DEEP_SLEEP=A0=A0=A0 (1 << 1)
> @@ -48,4 +49,27 @@ extern const struct fsl_pm_ops *qoriq_pm_ops;
>=A0=20
>=A0 int __init fsl_rcpm_init(void);
>=A0=20
> +#ifdef CONFIG_FSL_QORIQ_PM
> +int fsl_enter_deepsleep(void);
> +int fsl_deepsleep_init(void);
> +#else
> +static inline int fsl_enter_deepsleep(void) { return -1; }
> +static inline int fsl_deepsleep_init(void) { return -1; }
> +#endif

Please return proper error codes.

Where can fsl_deepsleep_init() be called without CONFIG_FSL_QORIQ_PM?

[Chenhui] I can get rid of the ifdef here. And add it in=A0arch/powerpc/sys=
dev/fsl_rcpm.c.

> +
> +extern void fsl_dp_enter_low(void *priv);
> +extern void fsl_booke_deep_sleep_resume(void);
> +
> +struct fsl_iomap {
> +=A0=A0=A0=A0 void *ccsr_scfg_base;
> +=A0=A0=A0=A0 void *ccsr_rcpm_base;
> +=A0=A0=A0=A0 void *ccsr_ddr_base;
> +=A0=A0=A0=A0 void *ccsr_gpio1_base;
> +=A0=A0=A0=A0 void *ccsr_cpc_base;
> +=A0=A0=A0=A0 void *dcsr_epu_base;
> +=A0=A0=A0=A0 void *dcsr_npc_base;
> +=A0=A0=A0=A0 void *dcsr_rcpm_base;
> +=A0=A0=A0=A0 void *cpld_base;
> +=A0=A0=A0=A0 void *fpga_base;
> +};

__iomem

[Chenhui] Yes. Will add it.

>=A0 #endif /* __PPC_FSL_PM_H */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index 9ea0955..cc488f9 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -68,6 +68,10 @@
>=A0 #include "../mm/mmu_decl.h"
>=A0 #endif
>=A0=20
> +#ifdef CONFIG_FSL_QORIQ_PM
> +#include <asm/fsl_pm.h>
> +#endif

I know this file ifdefs headers a lot, but it's generally not good
practice.=A0 Does including this file cause any harm on other platforms?

[Chenhui] Not at all. Will remove it.

> diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc=
/kernel/fsl_booke_entry_mapping.S
> index 83dd0f6..659b059 100644
> --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> @@ -173,6 +173,10 @@ skpinv:=A0 addi=A0=A0=A0 r6,r6,1=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Increment */
>=A0=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGE=
SZ_64M, M_IF_NEEDED)@h
>=A0=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_P=
AGESZ_64M, M_IF_NEEDED)@l
>=A0=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_MAS2,r6
> +#ifdef ENTRY_DEEPSLEEP_SETUP
> +=A0=A0=A0=A0 LOAD_REG_IMMEDIATE(r8, MEMORY_START)
> +=A0=A0=A0=A0 ori=A0=A0=A0=A0 r8,r8,(MAS3_SX|MAS3_SW|MAS3_SR)
> +#endif
>=A0=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_MAS3,r8
>=A0=A0=A0=A0=A0=A0=A0 tlbwe
>=A0=20

Have you tried this with a relocatable kernel?

[Chenhui] Not yet. Not sure whether it has been supported on QorIQ platform=
.

> +static void fsl_dp_set_resume_pointer(void)
> +{
> +=A0=A0=A0=A0 u32 resume_addr;
> +
> +=A0=A0=A0=A0 /* the bootloader will finally jump to this address to retu=
rn kernel */
> +#ifdef CONFIG_PPC32
> +=A0=A0=A0=A0 resume_addr =3D (u32)(__pa(fsl_booke_deep_sleep_resume));
> +#else
> +=A0=A0=A0=A0 resume_addr =3D (u32)(__pa(*(u64 *)fsl_booke_deep_sleep_res=
ume)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 & 0xffffffff);
> +#endif

Why are you masking the physical address by 0xffffffff?=A0 Besides the
(u32) cast accomplishing the same thing, wouldn't it be a problem if
(e.g. due to a relocatable kernel) the address is above 4 GiB?

[Chenhui] Here, I assumed kernel is below 4 GiB. Maybe I should add a comme=
nt here.

> +static void fsl_dp_pins_setup(void)
> +{
> +=A0=A0=A0=A0 u32 mask =3D BIT(31 - fsl_gpio_mcke);
> +
> +=A0=A0=A0=A0 /* set GPIO1_29 as an output pin (not open-drain), and outp=
ut 0 */
> +=A0=A0=A0=A0 clrbits32(fsl_dp_priv.ccsr_gpio1_base + CCSR_GPIO1_GPDAT, m=
ask);
> +=A0=A0=A0=A0 clrbits32(fsl_dp_priv.ccsr_gpio1_base + CCSR_GPIO1_GPODR, m=
ask);
> +=A0=A0=A0=A0 setbits32(fsl_dp_priv.ccsr_gpio1_base + CCSR_GPIO1_GPDIR, m=
ask);
> +
> +=A0=A0=A0=A0 /* wait for the stabilization of GPIO1_29 */
> +=A0=A0=A0=A0 udelay(10);
> +
> +=A0=A0=A0=A0 /* enable the functionality of pins relevant to deep sleep =
*/
> +=A0=A0=A0=A0 if (fsl_dp_priv.cpld_base) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 setbits8(fsl_dp_priv.cpld_base + QO=
RIQ_CPLD_MISCCSR,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 QORIQ_CP=
LD_MISCCSR_SLEEPEN);
> +=A0=A0=A0=A0 } else if (fsl_dp_priv.fpga_base) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 setbits8(fsl_dp_priv.fpga_base + QI=
XIS_PWR_CTL2,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 QIXIS_PW=
R_CTL2_PCTL);
> +=A0=A0=A0=A0 }
> +}

Please use callbacks to handle board-specific things.

[Chenhui] Yes. Will do it as you said.

> +/* reset time base to prevent from overflow */
> +#define DELAY(count)=A0=A0=A0=A0=A0=A0=A0=A0 \
> +=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r3, count;=A0=A0=A0=A0=A0 \
> +=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r4, 0;=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> +=A0=A0=A0=A0 mtspr=A0=A0 SPRN_TBWL, r4;=A0 \
> +101: mfspr=A0=A0 r4, SPRN_TBRL;=A0 \
> +=A0=A0=A0=A0 cmpw=A0=A0=A0 r4, r3;=A0=A0=A0=A0=A0=A0=A0=A0 \
> +=A0=A0=A0=A0 blt=A0=A0=A0=A0 101b

Please find a better way of dealing with overflow than writing to the
timebase.

-Scott

[Chenhui] OK. Let me try other way. Thank you for your time.=
