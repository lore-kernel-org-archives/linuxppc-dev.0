Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlz40rcZzDr79
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:24 +1100 (AEDT)
In-Reply-To: <20171102030906.3061-1-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, andrew@aj.id.au, gromero@linux.vnet.ibm.com,
 jk@ozlabs.org, leitao@debian.org, sam@mendozajonas.com
Subject: Re: [v3,1/4] powerpc: Don't enable FP/Altivec if not checkpointed
Message-Id: <3yWlyz73mYz9s7m@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-02 at 03:09:03 UTC, Cyril Bur wrote:
> Lazy save and restore of FP/Altivec means that a userspace process can
> be sent to userspace with FP or Altivec disabled and loaded only as
> required (by way of an FP/Altivec unavailable exception). Transactional
> Memory complicates this situation as a transaction could be started
> without FP/Altivec being loaded up. This causes the hardware to
> checkpoint incorrect registers. Handling FP/Altivec unavailable
> exceptions while a thread is transactional requires a reclaim and
> recheckpoint to ensure the CPU has correct state for both sets of
> registers.
> 
> Lazy save and restore of FP/Altivec cannot be done if a process is
> transactional. If a facility was enabled it must remain enabled whenever
> a thread is transactional.
> 
> Commit dc16b553c949 ("powerpc: Always restore FPU/VEC/VSX if hardware
> transactional memory in use") ensures that the facilities are always
> enabled if a thread is transactional. A bug in the introduced code may
> cause it to inadvertently enable a facility that was (and should remain)
> disabled. The problem with this extraneous enablement is that the
> registers for the erroneously enabled facility have not been correctly
> recheckpointed - the recheckpointing code assumed the facility would
> remain disabled.
> 
> Further compounding the issue, the transactional {fp,altivec,vsx}
> unavailable code has been incorrectly using the MSR to enable
> facilities. The presence of the {FP,VEC,VSX} bit in the regs->msr simply
> means if the registers are live on the CPU, not if the kernel should
> load them before returning to userspace. This has worked due to the bug
> mentioned above.
> 
> This causes transactional threads which return to their failure handler
> to observe incorrect checkpointed registers. Perhaps an example will
> help illustrate the problem:
> 
> A userspace process is running and uses both FP and Altivec registers.
> This process then continues to run for some time without touching
> either sets of registers. The kernel subsequently disables the
> facilities as part of lazy save and restore. The userspace process then
> performs a tbegin and the CPU checkpoints 'junk' FP and Altivec
> registers. The process then performs a floating point instruction
> triggering a fp unavailable exception in the kernel.
> 
> The kernel then loads the FP registers - and only the FP registers.
> Since the thread is transactional it must perform a reclaim and
> recheckpoint to ensure both the checkpointed registers and the
> transactional registers are correct. It then (correctly) enables
> MSR[FP] for the process. Later (on exception exist) the kernel also
> (inadvertently) enables MSR[VEC]. The process is then returned to
> userspace.
> 
> Since the act of loading the FP registers doomed the transaction we know
> CPU will fail the transaction, restore its checkpointed registers, and
> return the process to its failure handler. The problem is that we're
> now running with Altivec enabled and the 'junk' checkpointed registers
> are restored. The kernel had only recheckpointed FP.
> 
> This patch solves this by only activating FP/Altivec if userspace was
> using them when it entered the kernel and not simply if the process is
> transactional.
> 
> Fixes: dc16b553c949 ("powerpc: Always restore FPU/VEC/VSX if hardware
> transactional memory in use")
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7771176b4392fbc3a17399c51a8c1

cheers
