Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5FF111007D3
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 15:27:26 +1000 (EST)
Subject: Re: [PATCH] powerpc: add denormalisation exception handling for
	POWER6/7
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <11738.1310363538@neuling.org>
Date: Wed, 13 Jul 2011 00:27:07 -0500
Message-Id: <5E6FBB75-BE97-4D97-AEA2-EC8EAF1E0ECF@kernel.crashing.org>
References: <11738.1310363538@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Paul Mackerras <paulus@samba.org>, miltonm@bga.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 11, 2011, at 12:52 AM, Michael Neuling wrote:

> On POWER6 and POWER7 if the input operand to an instruction is a
> denormalised single precision binary floating we can take a
> denormalisation exception where it's expected that the hypervisor =
(HV=3D1)
> will fix up the inputs before the instruction is run.
>=20
> This adds code to handle this denormalisation exception for POWER6 and
> POWER7.
>=20
> It also add a CONFIG_PPC_DENORMALISATION option and sets it in
> pseries/ppc64_defconfig.=20
>=20
> This is useful on bare metal systems only.  Based on patch from Milton
> Miller.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
>=20
> ---
> arch/powerpc/Kconfig                   |    7 +
> arch/powerpc/configs/ppc64_defconfig   |    1=20
> arch/powerpc/configs/pseries_defconfig |    1=20
> arch/powerpc/include/asm/ppc-opcode.h  |    2=20
> arch/powerpc/include/asm/reg.h         |    1=20
> arch/powerpc/kernel/exceptions-64s.S   |  125 =
+++++++++++++++++++++++++++++++++
> 6 files changed, 137 insertions(+)
>=20
> Index: linux-ozlabs/arch/powerpc/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-ozlabs.orig/arch/powerpc/Kconfig
> +++ linux-ozlabs/arch/powerpc/Kconfig
> @@ -556,6 +556,13 @@ config SCHED_SMT
> 	  when dealing with POWER5 cpus at a cost of slightly increased
> 	  overhead in some places. If unsure say N here.
>=20
> +config PPC_DENORMALISATION
> +	bool "PowerPC denormalisation exception handling"

Should this at least depend on PPC_BOOK3S_64 ?

> +	default "n"
> +	---help---
> +	  Add support for handling denormalisation of single precision
> +	  values.  Useful for bare metal only.  If unsure say Y here.
> +
> config CMDLINE_BOOL
> 	bool "Default bootloader kernel arguments"
>=20
>=20

- k=
