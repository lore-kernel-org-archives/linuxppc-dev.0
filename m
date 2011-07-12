Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3B74B6F7A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 13:51:51 +1000 (EST)
Subject: Re: [PATCH] powerpc: add denormalisation exception handling for
	POWER6/7
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <11738.1310363538@neuling.org>
Date: Mon, 11 Jul 2011 22:51:33 -0500
Message-Id: <9875FD87-1762-4CCE-8A34-7BAC2C42E9A6@kernel.crashing.org>
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

Is it possible to run POWER6/7 systems in baremetal if you are not IBM?

Just wondering if this is useful to anyone but IBM.

- k=
