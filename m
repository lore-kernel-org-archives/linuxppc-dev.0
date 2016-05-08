Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r2Wx36XwNzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 May 2016 13:59:35 +1000 (AEST)
In-Reply-To: <1460547084-1818-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: [v2] powerpc/xmon: Fix SPR read/write commands and add command to
 dump SPRs
Message-Id: <3r2Wx35k4Fz9t3c@ozlabs.org>
Date: Sun,  8 May 2016 13:59:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-04 at 11:31:24 UTC, Michael Ellerman wrote:
> From: Paul Mackerras <paulus@ozlabs.org>
> 
> xmon has commands for reading and writing SPRs, but they don't work
> currently for several reasons. They attempt to synthesize a small
> function containing an mfspr or mtspr instruction and call it. However,
> the instructions are on the stack, which is usually not executable.
> Also, for 64-bit we set up a procedure descriptor, which is fine for the
> big-endian ABIv1, but not correct for ABIv2. Finally, the code uses the
> infrastructure for catching memory errors, but that only catches data
> storage interrupts and machine check interrupts, but a failed
> mfspr/mtspr can generate a program interrupt or a hypervisor emulation
> assist interrupt, or be a no-op.
> 
> Instead of trying to synthesize a function on the fly, this adds two new
> functions, xmon_mfspr() and xmon_mtspr(), which take an SPR number as an
> argument and read or write the SPR. Because there is no Power ISA
> instruction which takes an SPR number in a register, we have to generate
> one of each possible mfspr and mtspr instruction, for all 1024 possible
> SPRs. Thus we get just over 8k bytes of code for each of xmon_mfspr()
> and xmon_mtspr(). However, this 16kB of code pales in comparison to the
> > 130kB of PPC opcode tables used by the xmon disassembler.
> 
> To catch interrupts caused by the mfspr/mtspr instructions, we add a new
> 'catch_spr_faults' flag. If an interrupt occurs while it is set, we come
> back into xmon() via program_check_interrupt(), _exception() and die(),
> see that catch_spr_faults is set and do a longjmp to bus_error_jmp, back
> into read_spr() or write_spr().
> 
> This adds a couple of other nice features: first, a "Sa" command that
> attempts to read and print out the value of all 1024 SPRs. If any mfspr
> instruction acts as a no-op, then the SPR is not implemented and not
> printed.
> 
> Secondly, the Sr and Sw commands detect when an SPR is not
> implemented (i.e. mfspr is a no-op) and print a message to that effect
> rather than printing a bogus value.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/4d2a14c627ab449d2cc79254d4

cheers
