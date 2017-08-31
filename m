Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjP0k6SFQzDqR9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 10:49:58 +1000 (AEST)
Message-ID: <1504140598.4670.32.camel@neuling.org>
Subject: Re: [PATCH v3 00/17] powerpc: Do alignment fixups using
 analyse_instr etc.
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Date: Thu, 31 Aug 2017 10:49:58 +1000
In-Reply-To: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
References: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested-by: Michael Neuling <mikey@neuling.org>

FWIW I've written a test case for alignment faults (which I'll convert to a
selftest and upstream). It tests all load stores supported by POWER9 (resul=
ts
below).

VSX: 2.06B
	Doing lxvd2x:	PASSED
	Doing lxvw4x:	PASSED
	Doing lxsdx:	PASSED
	Doing lxvdsx:	PASSED
	Doing stxvd2x:	PASSED
	Doing stxvw4x:	PASSED
	Doing stxsdx:	PASSED
VSX: 2.07B
	Doing lxsspx:	PASSED
	Doing lxsiwax:	PASSED
	Doing lxsiwzx:	PASSED
	Doing stxsspx:	PASSED
	Doing stxsiwx:	PASSED
VSX: 3.00B
	Doing lxsd:	PASSED
	Doing lxsibzx:	PASSED
	Doing lxsihzx:	PASSED
	Doing lxssp:	PASSED
	Doing lxv:	PASSED
	Doing lxvb16x:	PASSED
	Doing lxvh8x:	PASSED
	Doing lxvx:	PASSED
	Doing lxvwsx:	PASSED
	Doing lxvl:	PASSED
	Doing lxvll:	PASSED
	Doing stxsd:	PASSED
	Doing stxsibx:	PASSED
	Doing stxsihx:	PASSED
	Doing stxssp:	PASSED
	Doing stxv:	PASSED
	Doing stxvb16x:	PASSED
	Doing stxvh8x:	PASSED
	Doing stxvx:	PASSED
	Doing stxvl:	PASSED
	Doing stxvll:	PASSED
Integer
	Doing lbz:	PASSED
	Doing lbzu:	PASSED
	Doing lbzx:	PASSED
	Doing lbzux:	PASSED
	Doing lhz:	PASSED
	Doing lhzu:	PASSED
	Doing lhzx:	PASSED
	Doing lhzux:	PASSED
	Doing lha:	PASSED
	Doing lhau:	PASSED
	Doing lhax:	PASSED
	Doing lhaux:	PASSED
	Doing lhbrx:	PASSED
	Doing lwz:	PASSED
	Doing lwzu:	PASSED
	Doing lwzx:	PASSED
	Doing lwzux:	PASSED
	Doing lwa:	PASSED
	Doing lwax:	PASSED
	Doing lwaux:	PASSED
	Doing lwbrx:	PASSED
	Doing ld:	PASSED
	Doing ldu:	PASSED
	Doing ldx:	PASSED
	Doing ldux:	PASSED
	Doing ldbrx:	PASSED
	Doing lmw:	PASSED
	Doing stb:	PASSED
	Doing stbx:	PASSED
	Doing stbu:	PASSED
	Doing stbux:	PASSED
	Doing sth:	PASSED
	Doing sthx:	PASSED
	Doing sthu:	PASSED
	Doing sthux:	PASSED
	Doing sthbrx:	PASSED
	Doing stw:	PASSED
	Doing stwx:	PASSED
	Doing stwu:	PASSED
	Doing stwux:	PASSED
	Doing stwbrx:	PASSED
	Doing std:	PASSED
	Doing stdx:	PASSED
	Doing stdu:	PASSED
	Doing stdux:	PASSED
	Doing stdbrx:	PASSED
	Doing stmw:	PASSED
VMX
	Doing stvx:	PASSED
	Doing stvebx:	PASSED
	Doing stvehx:	PASSED
	Doing stvewx:	PASSED
	Doing stvxl:	PASSED
Floating point
	Doing lfd:	PASSED
	Doing lfdx:	PASSED
	Doing lfdp:	PASSED
	Doing lfdpx:	PASSED
	Doing lfdu:	PASSED
	Doing lfdux:	PASSED
	Doing lfs:	PASSED
	Doing lfsx:	PASSED
	Doing lfsu:	PASSED
	Doing lfsux:	PASSED
	Doing lfiwzx:	PASSED
	Doing lfiwax:	PASSED
	Doing stfd:	PASSED
	Doing stfdx:	PASSED
	Doing stfdp:	PASSED
	Doing stfdpx:	PASSED
	Doing stfdu:	PASSED
	Doing stfdux:	PASSED
	Doing stfs:	PASSED
	Doing stfsx:	PASSED
	Doing stfsu:	PASSED
	Doing stfsux:	PASSED
	Doing stfiwx:	PASSED


On Wed, 2017-08-30 at 14:12 +1000, Paul Mackerras wrote:
> This series extends the instruction emulation infrastructure in
> arch/powerpc/lib/sstep.c and uses it for emulating instructions when
> we get an alignment interrupt.=C2=A0=C2=A0The advantage of this is that w=
e only
> have to add the new POWER9 instructions in one place, and it fixes
> several bugs in alignment interrupt handling that have been identified
> recently.
>=20
> With this, analyse_instr() and emulate_step() handle almost all load
> and store instructions in Power ISA v3.00 -- all except the atomic
> memory operations (lwat, stwat, etc.).=C2=A0=C2=A0We now always use the l=
argest
> possible aligned memory accesses (up to 8 bytes) to emulate unaligned
> accesses.=C2=A0=C2=A0If we get a fault, the faulting address is accuratel=
y
> recorded in regs->dar.=C2=A0=C2=A0We also can now access FP/VMX/VSX regis=
ters
> directly if they are live, without having to spill them all to the
> thread_struct and the reload them all later.=C2=A0=C2=A0There are also va=
rious
> other fixes in the series.
>=20
> This version is based on the current powerpc next branch.
>=20
> Paul.
>=20
> =C2=A0arch/powerpc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A0=C2=A0=C2=A04 -
> =C2=A0arch/powerpc/include/asm/ppc-opcode.h |=C2=A0=C2=A0=C2=A010 +-
> =C2=A0arch/powerpc/include/asm/sstep.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A0=C2=A090 +-
> =C2=A0arch/powerpc/kernel/align.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0774 +-----------
> =C2=A0arch/powerpc/lib/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A03 +-
> =C2=A0arch/powerpc/lib/ldstfp.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0307 ++---
> =C2=A0arch/powerpc/lib/quad.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A062 +
> =C2=A0arch/powerpc/lib/sstep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 2139 +++++++++++++++++++++++---=
------
> -
> =C2=A08 files changed, 1802 insertions(+), 1587 deletions(-)
>=20
