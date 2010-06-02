Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B6E6B7D59
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jun 2010 22:45:35 +1000 (EST)
Subject: Re: [PATCH] powerpc: Emulate most Book I instructions in
	emulate_step()
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100602112903.GB30149@brick.ozlabs.ibm.com>
Date: Wed, 2 Jun 2010 07:45:27 -0500
Message-Id: <09904F7B-6319-45FA-ADC4-757A2AD239AB@kernel.crashing.org>
References: <20100602112903.GB30149@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, "K.Prasad" <prasad@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 2, 2010, at 6:29 AM, Paul Mackerras wrote:

> This extends the emulate_step() function to handle a large proportion
> of the Book I instructions implemented on current 64-bit server
> processors.  The aim is to handle all the load and store instructions
> used in the kernel, plus all of the instructions that appear between
> l[wd]arx and st[wd]cx., so this handles the Altivec/VMX lvx and stvx
> and the VSX lxv2dx and stxv2dx instructions (implemented in POWER7).
>=20
> The new code can emulate user mode instructions, and checks the
> effective address for a load or store if the saved state is for
> user mode.  It doesn't handle little-endian mode at present.
>=20
> For floating-point, Altivec/VMX and VSX instructions, it checks
> that the saved MSR has the enable bit for the relevant facility
> set, and if so, assumes that the FP/VMX/VSX registers contain
> valid state, and does loads or stores directly to/from the
> FP/VMX/VSX registers, using assembly helpers in ldstfp.S.
>=20
> Instructions supported now include:
> * Loads and stores, including some but not all VMX and VSX =
instructions,
>  and lmw/stmw
> * Atomic loads and stores (l[dw]arx, st[dw]cx.)
> * Integer arithmetic instructions (add, subtract, multiply, divide, =
etc.)
> * Compare instructions
> * Rotate and mask instructions
> * Shift instructions
> * Logical instructions (and, or, xor, etc.)
> * Condition register logical instructions
> * mtcrf, cntlz[wd], exts[bhw]
> * isync, sync, lwsync, ptesync, eieio
> * Cache operations (dcbf, dcbst, dcbt, dcbtst)
>=20
> The overflow-checking arithmetic instructions are not included, but
> they appear not to be ever used in C code.  None of the floating
> point, VMX or VSX computational instructions are included.
>=20
> This uses decimal values for the minor opcodes in the switch =
statements
> because that is what appears in the Power ISA specification, thus it =
is
> easier to check that they are correct if they are in decimal.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> arch/powerpc/lib/Makefile |    4 +-
> arch/powerpc/lib/ldstfp.S |  207 ++++++
> arch/powerpc/lib/sstep.c  | 1513 =
+++++++++++++++++++++++++++++++++++++++++++--
> 3 files changed, 1677 insertions(+), 47 deletions(-)
> create mode 100644 arch/powerpc/lib/ldstfp.S

Why do we need to have emu support for all of these instructions?

- k=
