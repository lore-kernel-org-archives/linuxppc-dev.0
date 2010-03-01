Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Mon, 1 Mar 2010 15:19:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC: PATCH 03/13] powerpc/47x: Base ppc476 support
Message-ID: <20100301201900.GA8963@zod.rchland.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191315.20987.48063.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100301191315.20987.48063.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Overall I'm just going to trust you that things aren't broken on 47x :)

A few minor comments below.  Also, if Torez and Benh contributed to this code,
then their S-o-b lines should be included as well (same goes for any other
patch).

On Mon, Mar 01, 2010 at 12:13:15PM -0700, Dave Kleikamp wrote:
>diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>index bc8dd53..4af1c28 100644
>--- a/arch/powerpc/include/asm/reg.h
>+++ b/arch/powerpc/include/asm/reg.h
>@@ -813,6 +813,7 @@
> #define PVR_403GC	0x00200200
> #define PVR_403GCX	0x00201400
> #define PVR_405GP	0x40110000
>+#define PVR_476		0x11a52000

Is that really needed?  None of the 44x CPUs have a PVR value here.

> #define PVR_STB03XXX	0x40310000
> #define PVR_NP405H	0x41410000
> #define PVR_NP405L	0x41610000

<snip>

>diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
>index 2fc82ba..338ac47 100644
>--- a/arch/powerpc/kernel/cputable.c
>+++ b/arch/powerpc/kernel/cputable.c
>@@ -1701,6 +1701,19 @@ static struct cpu_spec __initdata cpu_specs[] = {
> 		.machine_check		= machine_check_440A,
> 		.platform		= "ppc440",
> 	},
>+	{ /* 476 core */
>+		.pvr_mask		= 0xffff0000,
>+		.pvr_value		= 0x11a50000,

Could we use PVR_476 here (if it's going to stay).

>+		.cpu_name		= "476",
>+		.cpu_features		= CPU_FTRS_47X,
>+		.cpu_user_features	= COMMON_USER_BOOKE |
>+			PPC_FEATURE_HAS_FPU,
>+		.mmu_features		= MMU_FTR_TYPE_47x |
>+			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
>+		.icache_bsize		= 32,
>+		.dcache_bsize		= 128,
>+		.platform		= "ppc470",
>+	},

<snip>

>diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
>index 7486bff..1dfc1c1 100644
>--- a/arch/powerpc/platforms/44x/Kconfig
>+++ b/arch/powerpc/platforms/44x/Kconfig
>@@ -1,6 +1,17 @@
>+config PPC_44x_46x
>+	bool "Support for 44x and 46x variants"
>+	depends on 44x
>+	default n

Why do this?  All it seems to do is add a bunch of churn to the Kconfig here.
If the intention was to try and prevent selecting both 44x and 47x kernel
options, then maybe I could see that.  However nothing prevents both from being
enabled.  Maybe PPC_47x should:

depends on !PPC_44x_46x && 44x

josh
