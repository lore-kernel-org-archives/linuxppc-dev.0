Return-Path: <scottwood@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 06FEF2C00D0
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2013 04:43:08 +1100 (EST)
Message-ID: <1385055779.1403.476.camel@snotra.buserror.net>
Subject: Re: [RFC][PATCH] powerpc/CoreNet64: compile with
 CONFIG_E{5,6}500_CPU well
From: Scott Wood <scottwood@freescale.com>
To: =?UTF-8?Q?=22=E2=80=9Ctiejun=2Echen=E2=80=9D=22?=
 <tiejun.chen@windriver.com>
Date: Thu, 21 Nov 2013 11:42:59 -0600
In-Reply-To: <528DCB61.8040807@windriver.com>
References: <1384936551-8494-1-git-send-email-tiejun.chen@windriver.com>
 <1384965671.1403.414.camel@snotra.buserror.net>
 <528DCB61.8040807@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-11-21 at 16:59 +0800, "=E2=80=9Ctiejun.chen=E2=80=9D" wrote:
> On 11/21/2013 12:41 AM, Scott Wood wrote:
> > On Wed, 2013-11-20 at 16:35 +0800, Tiejun Chen wrote:
> >> +# Altivec and Spe options not allowed with e500mc64 in GCC.
> >> +ifeq ($(call cc-option-yn,-mcpu=3De500mc64),n)
> >>   obj-$(CONFIG_ALTIVEC)	+=3D xor_vmx.o
> >>   CFLAGS_xor_vmx.o +=3D -maltivec -mabi=3Daltivec
> >> +endif
> >
> > This does not seem like the right fix.  What if GCC supports both
> > -mcpu=3De500mc64 and -mcpu=3De6500, and we're using the latter?  Or f=
or that
>=20
> I can understand what you mean, but in current kernel, -mcpu=3De500mc64=
 should be=20
> excluded from -mcpu=3De6500,
>=20
> arch/powerpc/Makefile:
>=20
> E5500_CPU :=3D $(call cc-option,-mcpu=3De500mc64,-mcpu=3Dpowerpc64)
> CFLAGS-$(CONFIG_E5500_CPU) +=3D $(E5500_CPU)
> CFLAGS-$(CONFIG_E6500_CPU) +=3D $(call cc-option,-mcpu=3De6500,$(E5500_=
CPU))

But your patch doesn't test what options we're actually using.  You
tested what options the compiler supports.

> But unfortunately, another place also use the same option,
>=20
> lib/raid6/Makefile:
>=20
> raid6_pq-$(CONFIG_ALTIVEC) +=3D altivec1.o altivec2.o altivec4.o altive=
c8.o
> ...
> ifeq ($(CONFIG_ALTIVEC),y)
> altivec_flags :=3D -maltivec -mabi=3Daltivec
> endif
>=20
> Looks we have to do something in this common Makefile file as well, but=
 it may=20
> be a bit ugly if still judge some cpu-specific flags...
>=20
> So what about this version?
>=20
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 607acf5..872a85c 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -127,7 +127,12 @@ CFLAGS-$(CONFIG_POWER5_CPU) +=3D $(call cc-option,=
-mcpu=3Dpower5)
>   CFLAGS-$(CONFIG_POWER6_CPU) +=3D $(call cc-option,-mcpu=3Dpower6)
>   CFLAGS-$(CONFIG_POWER7_CPU) +=3D $(call cc-option,-mcpu=3Dpower7)
>=20
> +# Altivec and Spe options not allowed with e500mc64 in GCC.
> +ifeq ($(CONFIG_ALTIVEC),)
>   E5500_CPU :=3D $(call cc-option,-mcpu=3De500mc64,-mcpu=3Dpowerpc64)
> +else
> +E5500_CPU :=3D -mcpu=3Dpowerpc64
> +endif
>   CFLAGS-$(CONFIG_E5500_CPU) +=3D $(E5500_CPU)
>   CFLAGS-$(CONFIG_E6500_CPU) +=3D $(call cc-option,-mcpu=3De6500,$(E550=
0_CPU))

Reverse the if/else so it uses positive logic, and remove the irrelevant
SPE from the comment, but otherwise I guess it's OK.

-Scott
