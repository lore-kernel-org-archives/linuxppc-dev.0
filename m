Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6DDE967A7B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 02:54:19 +1100 (EST)
In-Reply-To: <42282C7F.4010407@jp.fujitsu.com>
References: <42282C7F.4010407@jp.fujitsu.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <5e548efff8924e163b562381a93ffe35@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 4 Mar 2005 09:54:07 -0600
To: "Takeharu KATO" <kato.takeharu@jp.fujitsu.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] WDT Driver for Book-E [1/2] Architecture specific part.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Out of interest how did you test this?  If I find some time I will test =20=

it on an e500 system, just havent given much thought on how to test the =20=

watchdog though.

- kumar

On Mar 4, 2005, at 3:38 AM, Takeharu KATO wrote:

> Matt and Kurmar:
>
> I performed name-cleanup in the driver.
>
> Moreover, I tested this driver with PowerPC405GPr(Sycamore)
> in addition to PowerPC440GP(ebony)/MPC8555(MPC8555-CDS).
>
> This driver consist of two patches as follows:
>
> 1) Architecture specific part(booke_wdt-arch.patch)
>  This is the architecture specific part of the driver.
>  It contains WDT exception handlers
>  and kernel command line processing
>  routines.
>
> 2) Device driver part(booke_wdt-drv.patch)
>  This is the core of this WDT
>  driver.
>
> At first, I post the architecture specific part with this mail.
>
> Please apply.
>
> Regards,
>
> Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
>
> --- linux-2.6.11/arch/ppc/kernel/head_44x.S=A0=A0=A0=A0 2005-03-04 =20
> 17:12:42.944450424 +0900
>  +++ linux-2.6.11-booke-wdt/arch/ppc/kernel/head_44x.S=A0=A0 =
2005-03-04 =20
> 13:21:31.000000000 +0900
>  @@ -444,8 +444,12 @@ interrupt_base:
> =A0 =A0=A0=A0=A0=A0 EXCEPTION(0x1010, FixedIntervalTimer, =
UnknownException, =20
> EXC_XFER_EE)
>
> =A0 =A0=A0=A0=A0=A0 /* Watchdog Timer Interrupt */
>  -=A0=A0=A0=A0=A0=A0 /* TODO: Add watchdog support */
>  +#if defined(CONFIG_BOOKE_WDT)
> +=A0=A0=A0=A0=A0=A0 CRITICAL_EXCEPTION(0x1020, WatchdogTimer, =
booke_wdt_exception)
> +#else
>  =A0 =A0=A0=A0=A0=A0 CRITICAL_EXCEPTION(0x1020, WatchdogTimer, =
UnknownException)
> +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>  +=A0=A0=A0=A0=A0=A0
>
>  =A0 =A0=A0=A0=A0=A0 /* Data TLB Error Interrupt */
>  =A0 =A0=A0=A0=A0=A0 START_EXCEPTION(DataTLBError)
> --- linux-2.6.11/arch/ppc/kernel/head_4xx.S=A0=A0=A0=A0 2005-03-04 =20
> 17:16:48.089182760 +0900
>  +++ linux-2.6.11-booke-wdt/arch/ppc/kernel/head_4xx.S=A0=A0 =
2005-03-04 =20
> 13:21:31.000000000 +0900
>  @@ -469,27 +469,23 @@ label:
>
> =A0 /* 0x1000 - Programmable Interval Timer (PIT) Exception */
>  =A0 =A0=A0=A0=A0=A0 START_EXCEPTION(0x1000, Decrementer)
>  -=A0=A0=A0=A0=A0=A0 NORMAL_EXCEPTION_PROLOG
> -=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r0,TSR_PIS@h
> -=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_TSR,r0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 /* Clear the PIT exception */
>  -=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD
> -=A0=A0=A0=A0=A0=A0 EXC_XFER_LITE(0x1000, timer_interrupt)
> -
>  +=A0=A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 DecrementerHandler
> =A0 #if 0
>  =A0 /* NOTE:
>  - * FIT and WDT handlers are not implemented yet.
>  + * FIT handler are not implemented yet.
>  =A0=A0 */
>
> =A0 /* 0x1010 - Fixed Interval Timer (FIT) Exception
>  =A0 */
>  =A0 =A0=A0=A0=A0=A0 STND_EXCEPTION(0x1010,=A0 FITException,=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =20
> UnknownException)
>
> -/* 0x1020 - Watchdog Timer (WDT) Exception
>  -*/
>  -
>  -=A0=A0=A0=A0=A0=A0 CRITICAL_EXCEPTION(0x1020, WDTException, =
UnknownException)
> =A0 #endif
>
> +=A0 /* 0x1020 - Watchdog Timer (WDT) Exception
>  +=A0 */
>  +=A0=A0=A0=A0=A0=A0 START_EXCEPTION(0x1020, WDTException)
> +=A0=A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 WatchDogHandler
> +
>  =A0 /* 0x1100 - Data TLB Miss Exception
>  =A0=A0 * As the name implies, translation is not in the MMU, so =
search the
>  =A0=A0 * page tables and fix it.=A0 The only purpose of this function =
is to
>  @@ -771,6 +767,14 @@ label:
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 (MSR_KERNEL & =
~(MSR_ME|MSR_DE|MSR_CE)), \
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 NOCOPY, =
crit_transfer_to_handler, ret_from_crit_exc)
>
> +
>  +DecrementerHandler:
> +=A0=A0=A0=A0=A0=A0 NORMAL_EXCEPTION_PROLOG
> +=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r0,TSR_PIS@h
> +=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_TSR,r0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 /* Clear the PIT exception */
>  +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD
> +=A0=A0=A0=A0=A0=A0 EXC_XFER_LITE(0x1000, timer_interrupt)
> +
>  =A0 /*
>  =A0=A0 * The other Data TLB exceptions bail out to this point
>  =A0=A0 * if they can't resolve the lightweight TLB fault.
>  @@ -844,6 +848,19 @@ finish_tlb_load:
> =A0 =A0=A0=A0=A0=A0 rfi=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 /* Should sync shadow TLBs */
>  =A0 =A0=A0=A0=A0=A0 b=A0=A0=A0=A0=A0=A0 .=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 /* prevent prefetch past rfi */
>
> +/*
>  + * WatchDog Exception
>  + */
>  +WatchDogHandler:
> +=A0=A0=A0=A0=A0=A0 CRITICAL_EXCEPTION_PROLOG;
> +=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD;
> +#if defined(CONFIG_BOOKE_WDT)
> +=A0=A0=A0=A0=A0=A0 EXC_XFER_TEMPLATE(booke_wdt_exception, 0x1022, =
(MSR_KERNEL & =20
> ~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY,
>  crit_transfer_to_handler, ret_from_crit_exc)
> +
>  +#else
>  +=A0=A0=A0=A0=A0=A0 EXC_XFER_TEMPLATE(UnknownException, 0x1022, =
(MSR_KERNEL & =20
> ~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY,
>  crit_transfer_to_handler, ret_from_crit_exc)
> +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>  +
>  =A0 /* extern void giveup_fpu(struct task_struct *prev)
>  =A0=A0 *
>  =A0=A0 * The PowerPC 4xx family of processors do not have an FPU, so =
this =20
> just
>  --- linux-2.6.11/arch/ppc/kernel/head_e500.S=A0=A0=A0 2005-03-04 =20
> 17:15:36.641044528 +0900
>  +++ linux-2.6.11-booke-wdt/arch/ppc/kernel/head_e500.S=A0 2005-03-04 =20=

> 13:21:31.000000000 +0900
>  @@ -494,8 +494,11 @@ interrupt_base:
> =A0 =A0=A0=A0=A0=A0 EXCEPTION(0x3100, FixedIntervalTimer, =
UnknownException, =20
> EXC_XFER_EE)
>
> =A0 =A0=A0=A0=A0=A0 /* Watchdog Timer Interrupt */
>  -=A0=A0=A0=A0=A0=A0 /* TODO: Add watchdog support */
>  +#if defined(CONFIG_BOOKE_WDT)
> +=A0=A0=A0=A0=A0=A0 CRITICAL_EXCEPTION(0x3200, WatchdogTimer, =
booke_wdt_exception)
> +#else
>  =A0 =A0=A0=A0=A0=A0 CRITICAL_EXCEPTION(0x3200, WatchdogTimer, =
UnknownException)
> +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>
> =A0 =A0=A0=A0=A0=A0 /* Data TLB Error Interrupt */
>  =A0 =A0=A0=A0=A0=A0 START_EXCEPTION(DataTLBError)
> --- linux-2.6.11/arch/ppc/platforms/85xx/mpc8540_ads.c=A0 2005-03-04 =20=

> 17:13:11.927044400 +0900
>  +++ =20
> linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/mpc8540_ads.c=A0=A0=A0=A0=
=A0=A0=A0 =20
> 2005-03-04 13:21:31.000000000 +0900
>  @@ -54,6 +54,7 @@
>
> =A0 #include <syslib/ppc85xx_setup.h>
>
> +
>  =A0 /* =20
> =
***********************************************************************=20=

> *
> =A0=A0 *
>  =A0=A0 * Setup the architecture
>  @@ -187,6 +188,14 @@ platform_init(unsigned long r3, unsigned
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 strcpy(cmd_line, (char *) =
(r6 + KERNELBASE));
> =A0 =A0=A0=A0=A0=A0 }
>
> +#ifdef CONFIG_BOOKE_WDT
> +=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 extern void booke_wdt_setup_options(char =
*cmd_line);
>  +
>  +=A0=A0=A0=A0=A0=A0 booke_wdt_setup_options(cmd_line);
> +=A0=A0=A0=A0 }
>  +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>  +
>  =A0 =A0=A0=A0=A0=A0 identify_ppc_sys_by_id(mfspr(SVR));
>
> =A0 =A0=A0=A0=A0=A0 /* setup the PowerPC module struct */
>  --- linux-2.6.11/arch/ppc/platforms/85xx/mpc8560_ads.c=A0 2005-03-04 =20=

> 17:17:54.566076736 +0900
>  +++ =20
> linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/mpc8560_ads.c=A0=A0=A0=A0=
=A0=A0=A0 =20
> 2005-03-04 13:21:31.000000000 +0900
>  @@ -197,6 +197,14 @@ platform_init(unsigned long r3, unsigned
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 strcpy(cmd_line, (char *) =
(r6 + KERNELBASE));
> =A0 =A0=A0=A0=A0=A0 }
>
> +#ifdef CONFIG_BOOKE_WDT
> +=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 extern void booke_wdt_setup_options(char =
*cmd_line);
>  +
>  +=A0=A0=A0=A0=A0=A0 booke_wdt_setup_options(cmd_line);
> +=A0=A0=A0=A0 }
>  +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>  +
>  =A0 =A0=A0=A0=A0=A0 identify_ppc_sys_by_id(mfspr(SVR));
>
> =A0 =A0=A0=A0=A0=A0 /* setup the PowerPC module struct */
>  --- linux-2.6.11/arch/ppc/platforms/85xx/mpc85xx_cds_common.c=A0=A0 =20=

> 2005-03-04 17:16:27.056380232 +0900
>  +++ =20
> linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/mpc85xx_cds_common.c =20=

> 2005-03-04
> 13:21:31.000000000 +0900
>  @@ -437,6 +437,14 @@ platform_init(unsigned long r3, unsigned
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strcpy(cmd_line, =
(char *) (r6 + KERNELBASE));
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>
> +#ifdef CONFIG_BOOKE_WDT
> +=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 extern void booke_wdt_setup_options(char =
*cmd_line);
>  +
>  +=A0=A0=A0=A0=A0=A0 booke_wdt_setup_options(cmd_line);
> +=A0=A0=A0=A0 }
>  +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>  +
>  =A0 =A0=A0=A0=A0=A0 identify_ppc_sys_by_id(mfspr(SVR));
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 /* setup the PowerPC module struct */
>  --- linux-2.6.11/arch/ppc/platforms/85xx/sbc8560.c=A0=A0=A0=A0=A0 =
2005-03-04 =20
> 17:17:22.985877656 +0900
>  +++ linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/sbc8560.c=A0=A0=A0 =
=20
> 2005-03-04 13:21:31.000000000 +0900
>  @@ -198,6 +198,14 @@ platform_init(unsigned long r3, unsigned
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 strcpy(cmd_line, (char *) =
(r6 + KERNELBASE));
> =A0 =A0=A0=A0=A0=A0 }
>
> +#ifdef CONFIG_BOOKE_WDT
> +=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 extern void booke_wdt_setup_options(char =
*cmd_line);
>  +
>  +=A0=A0=A0=A0=A0=A0 booke_wdt_setup_options(cmd_line);
> +=A0=A0=A0=A0 }
>  +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>  +
>  =A0 =A0=A0=A0=A0=A0 identify_ppc_sys_by_id(mfspr(SVR));
>
> =A0 =A0=A0=A0=A0=A0 /* setup the PowerPC module struct */
>  --- linux-2.6.11/arch/ppc/platforms/85xx/stx_gp3.c=A0=A0=A0=A0=A0 =
2005-03-04 =20
> 17:14:12.883777568 +0900
>  +++ linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/stx_gp3.c=A0=A0=A0 =
=20
> 2005-03-04 13:21:31.000000000 +0900
>  @@ -68,6 +68,7 @@ unsigned long isa_mem_base =3D 0;
>  =A0 unsigned long pci_dram_offset =3D 0;
>  =A0 #endif
>
> +
>  =A0 /* Internal interrupts are all Level Sensitive, and Positive =20
> Polarity */
>  =A0 static u8 gp3_openpic_initsenses[] __initdata =3D {
>  =A0 =A0=A0=A0=A0=A0 (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),=A0=A0=A0=
=A0=A0 /* Internal=A0 =20
> 0: L2 Cache */
>  @@ -357,6 +358,14 @@ platform_init(unsigned long r3, unsigned
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 strcpy(cmd_line, (char *) =
(r6 + KERNELBASE));
> =A0 =A0=A0=A0=A0=A0 }
>
> +#ifdef CONFIG_BOOKE_WDT
> +=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 extern void booke_wdt_setup_options(char =
*cmd_line);
>  +
>  +=A0=A0=A0=A0=A0=A0 booke_wdt_setup_options(cmd_line);
> +=A0=A0=A0=A0 }
>  +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>  +
>  =A0 =A0=A0=A0=A0=A0 identify_ppc_sys_by_id(mfspr(SVR));
>
> =A0 =A0=A0=A0=A0=A0 /* setup the PowerPC module struct */
>  --- linux-2.6.11/arch/ppc/syslib/ppc4xx_setup.c 2005-03-04 =20
> 17:10:56.867576560 +0900
>  +++ linux-2.6.11-booke-wdt/arch/ppc/syslib/ppc4xx_setup.c=A0=A0=A0=A0=A0=
=A0 =20
> 2005-03-04 13:21:31.000000000 +0900
>  @@ -48,10 +48,6 @@
>  =A0 extern void abort(void);
>  =A0 extern void ppc4xx_find_bridges(void);
>
> -extern void ppc4xx_wdt_heartbeat(void);
> -extern int wdt_enable;
>  -extern unsigned long wdt_period;
>  -
>  =A0 /* Global Variables */
>  =A0 bd_t __res;
>
> @@ -257,22 +253,14 @@ ppc4xx_init(unsigned long r3, unsigned l
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 *(char *) (r7 + KERNELBASE) =
=3D 0;
>  =A0 =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 strcpy(cmd_line, (char *) =
(r6 + KERNELBASE));
> =A0 =A0=A0=A0=A0=A0 }
>  -#if defined(CONFIG_PPC405_WDT)
> -/* Look for wdt=3D option on command line */
>  -=A0=A0=A0=A0=A0=A0 if (strstr(cmd_line, "wdt=3D")) {
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 int valid_wdt =3D 0;
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 char *p, *q;
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 for (q =3D cmd_line; (p =3D =
strstr(q, "wdt=3D")) !=3D 0;) {
> -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 q =3D =
p + 4;
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (p =
> cmd_line && p[-1] !=3D ' ')
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 continue;
> -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
wdt_period =3D simple_strtoul(q, &q, 0);
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
valid_wdt =3D 1;
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ++q;
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
>  -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 wdt_enable =3D valid_wdt;
>  -=A0=A0=A0=A0=A0=A0 }
>  -#endif
>  +
>  +#ifdef CONFIG_BOOKE_WDT
> +=A0=A0=A0=A0 {
>  +=A0=A0=A0=A0=A0=A0 extern void booke_wdt_setup_options(char =
*cmd_line);
>  +
>  +=A0=A0=A0=A0=A0=A0 booke_wdt_setup_options(cmd_line);
> +=A0=A0=A0=A0 }
>  +#endif=A0 /*=A0 CONFIG_BOOKE_WDT=A0 */
>
> =A0 =A0=A0=A0=A0=A0 /* Initialize machine-dependent vectors */
>
> @@ -319,3 +307,5 @@ void platform_machine_check(struct pt_re
>  =A0 #endif
>
> =A0 }
>  +
>  +
>
>
> =20=
