Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D0D91A009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 16:38:51 +1000 (EST)
Message-ID: <1408603130.9307.6.camel@concordia>
Subject: Re: [PATCH 1/3] powerpc: Split out instruction analysis part of
 emulate_step()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
Date: Thu, 21 Aug 2014 16:38:50 +1000
In-Reply-To: <1408363992-7929-2-git-send-email-paulus@samba.org>
References: <1408363992-7929-1-git-send-email-paulus@samba.org>
 <1408363992-7929-2-git-send-email-paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-08-18 at 22:13 +1000, Paul Mackerras wrote:
> This splits out the instruction analysis part of emulate_step() into
> a separate analyse_instr() function, which decodes the instruction,
> but doesn't execute any load or store instructions.  It does execute
> integer instructions and branches which can be executed purely by
> updating register values in the pt_regs struct.  For other instructions,
> it returns the instruction type and other details in a new
> instruction_op struct.  emulate_step() then uses that information
> to execute loads, stores, cache operations, mfmsr, mtmsr[d], and
> (on 64-bit) sc instructions.
> 
> The reason for doing this is so that the KVM code can use it instead
> of having its own separate instruction emulation code.  Possibly the
> alignment interrupt handler could also use this.

Breaks the ppc64e_defconfig build:

  arch/powerpc/lib/sstep.c: In function 'emulate_step':
  arch/powerpc/lib/sstep.c:1794:3: error: implicit declaration of function 'do_vec_load' [-Werror=implicit-function-declaration]
  reg, do_lvx, op.ea & ~0xfUL, regs);
  
  arch/powerpc/lib/sstep.c:1840:3: error: implicit declaration of function 'do_vec_store' [-Werror=implicit-function-declaration]
     err = do_vec_store(op.reg, do_stvx, op.ea & ~0xfUL, regs);
     ^

cheers
