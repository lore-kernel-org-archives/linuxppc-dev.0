Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BE9EE2C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 16:08:04 +1100 (EST)
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on e500
 cores
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1382081880-6666-1-git-send-email-wd@denx.de>
Date: Wed, 23 Oct 2013 00:07:48 -0500
Message-Id: <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
To: Wolfgang Denk <wd@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 18, 2013, at 2:38 AM, Wolfgang Denk wrote:

> Default Debian PowerPC doesn't work on e500 because the code contains
> "lwsync" instructions, which are unsupported on this core.  As a
> result, applications using this will crash with an "unhandled signal =
4"
> "Illegal instruction" error.
>=20
> As a work around we add code to emulate this insn.  This is expensive
> performance-wise, but allows to run standard user land code.
>=20
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Scott Wood <scottwood@freescale.com>
> ---
> I am aware that the clean solution to the problem is to build user
> space with compiler options that match the target architecture.
> However, sometimes this is just too much effort.
>=20
> Also, of course the performance of such an emulation sucks. But the
> the occurrence of such instructions is so rare that no significant
> slowdown can be oserved.
>=20
> I'm not sure if this should / could go into mainline.  I'm posting it
> primarily so it can be found should anybody else need this.
> - wd
>=20
> arch/powerpc/kernel/traps.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index f783c93..f330374 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -986,6 +986,13 @@ static int emulate_instruction(struct pt_regs =
*regs)
> 		return 0;
> 	}
>=20
> +	/* Emulating the lwsync insn as a sync insn */
> +	if (instword =3D=3D PPC_INST_LWSYNC) {
> +		PPC_WARN_EMULATED(lwsync, regs);
> +		asm volatile("sync" : : : "memory");

Do we really need the inline asm?  Doesn't the fact of just taking an =
exception and returning from it equate to a sync.

> +		return 0;
> +	}
> +
> 	/* Emulate the mcrxr insn.  */
> 	if ((instword & PPC_INST_MCRXR_MASK) =3D=3D PPC_INST_MCRXR) {
> 		int shift =3D (instword >> 21) & 0x1c;
> --=20
> 1.8.3.1
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
