Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYp1nttzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:46 +1000 (AEST)
In-Reply-To: <1455604313-13818-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>, andrew.donnellan@au1.ibm.com
Subject: Re: [v2] powerpc/sstep.c - Fix emulation fall-through
Message-Id: <3r4CYp020Kz9t50@ozlabs.org>
Date: Wed, 11 May 2016 07:48:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-16-02 at 06:31:53 UTC, Oliver O'Halloran wrote:
> There is a switch fallthough in instr_analyze() which can cause
> an invalid instruction to be emulated as a different, valid,
> instruction. The rld* (opcode 30) case extracts a sub-opcode from
> bits 3:1 of the instruction word. However, the only valid values
> of this field a 001 and 000. These cases are correctly handled,
> but the others are not which causes execution to fall through
> into case 31.
> 
> Breaking out of the switch causes the instruction to be marked as
> unknown and allows the caller to deal with the invalid instruction
> in a manner consistent with other invalid instructions.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ab66c8ca52f790d816e421d3b1

cheers
