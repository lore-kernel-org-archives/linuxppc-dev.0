Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnnt66ZWjzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 23:44:14 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id a70so139647pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 06:44:14 -0700 (PDT)
Date: Wed, 14 Jun 2017 23:44:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 12/13] powerpc/64: runlatch CTRL[RUN] set optimisation
Message-ID: <20170614234400.214a1586@roar.ozlabs.ibm.com>
In-Reply-To: <87h8zi3ikj.fsf@concordia.ellerman.id.au>
References: <20170613130557.26315-1-npiggin@gmail.com>
 <20170613130557.26315-13-npiggin@gmail.com>
 <87h8zi3ikj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 14 Jun 2017 21:38:36 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > The CTRL register is read-only except bit 63 which is the run latch
> > control. This means it can be updated with a mtspr rather than
> > mfspr/mtspr.  
> 
> Turns out this doesn't work on Cell.
> 
> There's an extra field in there:
> 
>   Thread enable bits (Read/Write)
>   The hypervisor state can suspend its own thread by setting the TE bit
>   for its thread to '0’. The hypervisor state can resume the opposite
>   thread by setting the TE bit for the opposite thread to '1'. The
>   hypervisor state cannot suspend the opposite thread by setting the TE
>   bit for the opposite thread to ‘0’. This setting is ignored and does not
>   cause an error.
>   
>   TE0 is the thread enable bit for thread 0.
>   TE1 is the thread enable bit for thread 1.
>   
>   If thread 0 executes the mtctrl instruction, these are the bit values:
>   
>   [TE0 TE1] Description
>     0   0   Disable or suspend thread 0; thread 1 unchanged.
>     0   1   Disable or suspend thread 0; enable or resume thread 1 if it was disabled.
>     1   0   Unchanged.
>     1   1   Enable or resume thread 1 if it was disabled.
>   
>   If thread 1 executes the mtctrl instruction, these are the bit values:
>   
>   [TE0 TE1] Description
>     0   0    Thread 0 unchanged; disable or suspend thread 1.
>     0   1    Unchanged.
>     1   0    Enable or resume thread 0 if it was disabled; disable or suspend thread 1.
>     1   1    Enable or resume thread 0 if it was disabled.
> 
> 
> So writing either 0 or CTRL_RUNLATCH (1) will disable the thread that
> does the write - :D
> 
> For now I'll just drop this.

Ouch, good catch, thanks. I'll go with something like this (below)
instead, but I'll do some testing and get numbers first. So dropping
it should be fine.

---
 arch/powerpc/kernel/process.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index baae104b16c7..f587c1fdf981 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1960,11 +1960,25 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 void notrace __ppc64_runlatch_on(void)
 {
 	struct thread_info *ti = current_thread_info();
-	unsigned long ctrl;
 
-	ctrl = mfspr(SPRN_CTRLF);
-	ctrl |= CTRL_RUNLATCH;
-	mtspr(SPRN_CTRLT, ctrl);
+	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
+		/*
+		 * Least significant bit (RUN) is the only writable bit of
+		 * the CTRL register, so we can avoid mfspr. 2.06 is not the
+		 * earliest ISA where this is the case, but it's convenient.
+		 */
+		mtspr(SPRN_CTRLT, CTRL_RUNLATCH);
+	} else {
+		unsigned long ctrl;
+
+		/*
+		 * Some architectures (e.g., Cell) have writable fields other
+		 * than RUN, so do the read-modify-write.
+		 */
+		ctrl = mfspr(SPRN_CTRLF);
+		ctrl |= CTRL_RUNLATCH;
+		mtspr(SPRN_CTRLT, ctrl);
+	}
 
 	ti->local_flags |= _TLF_RUNLATCH;
 }
@@ -1973,13 +1987,18 @@ void notrace __ppc64_runlatch_on(void)
 void notrace __ppc64_runlatch_off(void)
 {
 	struct thread_info *ti = current_thread_info();
-	unsigned long ctrl;
 
 	ti->local_flags &= ~_TLF_RUNLATCH;
 
-	ctrl = mfspr(SPRN_CTRLF);
-	ctrl &= ~CTRL_RUNLATCH;
-	mtspr(SPRN_CTRLT, ctrl);
+	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
+		mtspr(SPRN_CTRLT, 0);
+	} else {
+		unsigned long ctrl;
+
+		ctrl = mfspr(SPRN_CTRLF);
+		ctrl &= ~CTRL_RUNLATCH;
+		mtspr(SPRN_CTRLT, ctrl);
+	}
 }
 #endif /* CONFIG_PPC64 */
 
-- 
2.11.0
