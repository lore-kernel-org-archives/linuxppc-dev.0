Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqy6Q9nzF0XT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:22 +1100 (AEDT)
In-Reply-To: <1514762446-1323-1-git-send-email-gromero@linux.vnet.ibm.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: cyrilbur@gmail.com
Subject: Re: [1/2] powerpc/tm: Fix endianness flip on trap
Message-Id: <3zPxqy2nFCz9sP1@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-12-31 at 23:20:45 UTC, Gustavo Romero wrote:
> Currently it's possible that a thread on PPC64 LE has its endianness
> flipped inadvertently to Big-Endian resulting in a crash once the process
> is back from the signal handler.
> 
> If giveup_all() is called when regs->msr has the bits MSR.FP and MSR.VEC
> disabled (and hence MSR.VSX disabled too) it returns without calling
> check_if_tm_restore_required() which copies regs->msr to ckpt_regs->msr if
> the process caught a signal whilst in transactional mode. Then once in
> setup_tm_sigcontexts() MSR from ckpt_regs.msr is used, but since
> check_if_tm_restore_required() was not called previuosly, gp_regs[PT_MSR]
> gets a copy of invalid MSR bits as MSR in ckpt_regs was not updated from
> regs->msr and so is zeroed. Later when leaving the signal handler once in
> sys_rt_sigreturn() the TS bits of gp_regs[PT_MSR] are checked to determine
> if restore_tm_sigcontexts() must be called to pull in the correct MSR state
> into the user context. Because TS bits are zeroed
> restore_tm_sigcontexts() is never called and MSR restored from the user
> context on returning from the signal handler has the MSR.LE (the endianness
> bit) forced to zero (Big-Endian). That leads, for instance, to 'nop' being
> treated as an illegal instruction in the following sequence:
> 
> 	tbegin.
> 	beq	1f
> 	trap
> 	tend.
> 1:	nop
> 
> on PPC64 LE machines and the process dies just after returning from the
> signal handler.
> 
> PPC64 BE is also affected but in a subtle way since forcing Big-Endian on
> a BE machine does not change the endianness.
> 
> This commit fixes the issue described above by ensuring that once in
> setup_tm_sigcontexts() the MSR used is from regs->msr instead of from
> ckpt_regs->msr and by ensuring that we pull in only the MSR.FP, MSR.VEC,
> and MSR.VSX bits from ckpt_regs->msr.
> 
> The fix was tested both on LE and BE machines and no regression regarding
> the powerpc/tm selftests was observed.
> 
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1c200e63d055ec0125e44a5e386b9b

cheers
