Return-Path: <chenhui.zhao@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0041.outbound.protection.outlook.com [104.47.2.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl9bG5DS5zDsj8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 20:21:30 +1000 (AEST)
From: "C.H. Zhao" <chenhui.zhao@nxp.com>
To: Scott Wood <oss@buserror.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "z.chenhui@gmail.com" <z.chenhui@gmail.com>, Jason Jin <jason.jin@nxp.com>
Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
Date: Thu, 29 Sep 2016 10:21:23 +0000
Message-ID: <AM4PR0401MB2355465DF56ECC2CC4DF7E8B95CE0@AM4PR0401MB2355.eurprd04.prod.outlook.com>
References: <1470139172-12699-5-git-send-email-chenhui.zhao@nxp.com>
 ,<20160925072400.GA17928@home.buserror.net>
 <AM4PR0401MB23559F508FC92E0FD670998095CC0@AM4PR0401MB2355.eurprd04.prod.outlook.com>,
 <1475092993.4283.51.camel@buserror.net>
In-Reply-To: <1475092993.4283.51.camel@buserror.net>
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
Sent: Thursday, September 29, 2016 4:03 AM
To: C.H. Zhao
Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; z.chenhui@=
gmail.com; Jason Jin
Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
=A0  =20
On Tue, 2016-09-27 at 11:05 +0000, C.H. Zhao wrote:
> From: Scott Wood <oss@buserror.net>
> Sent: Sunday, September 25, 2016 3:24 PM
> To: C.H. Zhao
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; z.chenhu=
i@g
> mail.com; Jason Jin
> Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
> =A0=A0=A0=A0
> On Tue, Aug 02, 2016 at 07:59:31PM +0800, Chenhui Zhao wrote:
> >=20
> > T104x has deep sleep feature, which can switch off most parts of
> > the SoC when it is in deep sleep mode. This way, it becomes more
> > energy-efficient.
> >=20
> > The DDR controller will also be powered off in deep sleep. Therefore,
> > the last stage (the latter part of fsl_dp_enter_low) will run without D=
DR
> > access. This piece of code and related TLBs are prefetched in advance.
> >=20
> > Due to the different initialization code between 32-bit and 64-bit, the=
y
> > have separate resume entry and precedure.
> >=20
> > The feature supports 32-bit and 64-bit kernel mode.
> >=20
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> > ---
> > =A0 arch/powerpc/include/asm/fsl_pm.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 24 ++
> > =A0 arch/powerpc/kernel/asm-offsets.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 12 +
> > =A0 arch/powerpc/kernel/fsl_booke_entry_mapping.S |=A0 10 +
> > =A0 arch/powerpc/kernel/head_64.S=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0=A0 2 +-
> > =A0 arch/powerpc/platforms/85xx/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0 1 +
> > =A0 arch/powerpc/platforms/85xx/deepsleep.c=A0=A0=A0=A0=A0=A0 | 278 +++=
+++++++++++
> > =A0 arch/powerpc/platforms/85xx/qoriq_pm.c=A0=A0=A0=A0=A0=A0=A0 |=A0 25=
 ++
> > =A0 arch/powerpc/platforms/85xx/t104x_deepsleep.S | 531
> > ++++++++++++++++++++++++++
> > =A0 arch/powerpc/sysdev/fsl_rcpm.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0 8 +-
> > =A0 9 files changed, 889 insertions(+), 2 deletions(-)
> > =A0 create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
> > =A0 create mode 100644 arch/powerpc/platforms/85xx/t104x_deepsleep.S
> >=20
> > diff --git a/arch/powerpc/include/asm/fsl_pm.h
> > b/arch/powerpc/include/asm/fsl_pm.h
> > index e05049b..48c2631 100644
> > --- a/arch/powerpc/include/asm/fsl_pm.h
> > +++ b/arch/powerpc/include/asm/fsl_pm.h
> > @@ -20,6 +20,7 @@
> > =A0=A0
> > =A0 #define PLAT_PM_SLEEP=A0=A0=A0=A0=A0=A0=A0 20
> > =A0 #define PLAT_PM_LPM20=A0=A0=A0=A0=A0=A0=A0 30
> > +#define PLAT_PM_LPM35=A0=A0=A0=A0=A0=A0=A0 40
> > =A0=A0
> > =A0 #define FSL_PM_SLEEP=A0=A0=A0=A0=A0=A0=A0=A0 (1 << 0)
> > =A0 #define FSL_PM_DEEP_SLEEP=A0=A0=A0 (1 << 1)
> > @@ -48,4 +49,27 @@ extern const struct fsl_pm_ops *qoriq_pm_ops;
> > =A0=A0
> > =A0 int __init fsl_rcpm_init(void);
> > =A0=A0
> > +#ifdef CONFIG_FSL_QORIQ_PM
> > +int fsl_enter_deepsleep(void);
> > +int fsl_deepsleep_init(void);
> > +#else
> > +static inline int fsl_enter_deepsleep(void) { return -1; }
> > +static inline int fsl_deepsleep_init(void) { return -1; }
> > +#endif
> Please return proper error codes.
>=20
> Where can fsl_deepsleep_init() be called without CONFIG_FSL_QORIQ_PM?
>=20
> [Chenhui] I can get rid of the ifdef here. And add it
> in=A0arch/powerpc/sysdev/fsl_rcpm.c.

No, this is the right place for the ifdef for functions that are called fro=
m
code that doesn't depend on CONFIG_FSL_QORIQ_PM. =A0But fsl_deepsleep_init(=
) is
called from deepsleep.c which is only built with CONFIG_FSL_QORIQ_PM, and i=
t's
hard to picture a scenario where it would be called from elsewhere.


[Chenhui] You are right. No need to enclose fsl_deepsleep_init() in the ifd=
ef.
                 But regarding fsl_enter_deepsleep(), it is called in rcpm_=
v2_plat_enter_sleep()
                 in arch/powerpc/sysdev/fsl_rcpm.c. It still needs to be en=
closed in the ifdef.
                 I would change it like:

int fsl_deepsleep_init(void);                                             =
=20
#ifdef CONFIG_FSL_QORIQ_PM                                                =
=20
int fsl_enter_deepsleep(void);
#else          =20
static inline int fsl_enter_deepsleep(void) { return -EINVAL; }           =
=20
#endif


> > diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> > b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> > index 83dd0f6..659b059 100644
> > --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> > +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> > @@ -173,6 +173,10 @@ skpinv:=A0 addi=A0=A0=A0 r6,r6,1=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> > Increment */
> > =A0=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_P=
AGESZ_64M, M_IF_NEEDED)@h
> > =A0=A0=A0=A0=A0=A0=A0 ori=A0=A0=A0=A0 r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3=
E_PAGESZ_64M,
> > M_IF_NEEDED)@l
> > =A0=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_MAS2,r6
> > +#ifdef ENTRY_DEEPSLEEP_SETUP
> > +=A0=A0=A0=A0 LOAD_REG_IMMEDIATE(r8, MEMORY_START)
> > +=A0=A0=A0=A0 ori=A0=A0=A0=A0 r8,r8,(MAS3_SX|MAS3_SW|MAS3_SR)
> > +#endif
> > =A0=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_MAS3,r8
> > =A0=A0=A0=A0=A0=A0=A0 tlbwe
> > =A0=A0
> Have you tried this with a relocatable kernel?
>=20
> [Chenhui] Not yet. Not sure whether it has been supported on QorIQ platfo=
rm.

It is supported, and deep sleep needs to work with it.


[Chenhui] OK. I'm going to work something out.

> > +static void fsl_dp_set_resume_pointer(void)
> > +{
> > +=A0=A0=A0=A0 u32 resume_addr;
> > +
> > +=A0=A0=A0=A0 /* the bootloader will finally jump to this address to re=
turn kernel
> > */
> > +#ifdef CONFIG_PPC32
> > +=A0=A0=A0=A0 resume_addr =3D (u32)(__pa(fsl_booke_deep_sleep_resume));
> > +#else
> > +=A0=A0=A0=A0 resume_addr =3D (u32)(__pa(*(u64 *)fsl_booke_deep_sleep_r=
esume)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 & 0xffffffff);
> > +#endif
> Why are you masking the physical address by 0xffffffff?=A0 Besides the
> (u32) cast accomplishing the same thing, wouldn't it be a problem if
> (e.g. due to a relocatable kernel) the address is above 4 GiB?
>=20
> [Chenhui] Here, I assumed kernel is below 4 GiB. Maybe I should add a
> comment here.

It needs a fix rather than a comment, unless you can show that the relocata=
ble
mechanism doesn't support kernels over 4 GiB (I don't remember of the top o=
f
my head whether it does).

-Scott

[Chenhui] OK. I'm going to work something out.
    =
