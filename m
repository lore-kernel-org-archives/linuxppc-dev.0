Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb3lF1pX8zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 10:29:45 +1100 (AEDT)
In-Reply-To: <1457388527-14575-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>, Anton Blanchard <anton@samba.org>
Subject: Re: powerpc/process: fix altivec SPR not being saved
Message-Id: <3qb3lF16RQz9sf6@ozlabs.org>
Date: Thu, 31 Mar 2016 10:29:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-07-03 at 22:08:47 UTC, Oliver O'Halloran wrote:
> In save_sprs() in process.c contains the following test:
> 
> 	if (cpu_has_feature(cpu_has_feature(CPU_FTR_ALTIVEC)))
> 		t->vrsave = mfspr(SPRN_VRSAVE);
> 
> CPU feature with the mask 0x1 is CPU_FTR_COHERENT_ICACHE so the test
> is equivilent to:
> 
> 	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
> 		cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> 
> On CPUs without support for both (i.e G5) this results in vrsave not being
> saved between context switches. The vector register save/restore code
> doesn't use VRSAVE to determine which registers to save/restore,
> but the value of VRSAVE is used to determine if altivec is being used
> in several code paths.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Fixes: 152d523e6307 ("powerpc: Create context switch helpers save_sprs() and restore_sprs()")
> Cc: stable@vger.kernel.org

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/01d7c2a2de47890934faba91a7

cheers
