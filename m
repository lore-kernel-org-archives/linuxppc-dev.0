Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18078.43412.493174.590540@cargo.ozlabs.ibm.com>
Date: Thu, 19 Jul 2007 10:00:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
In-Reply-To: <11847726193856-git-send-email-segher@kernel.crashing.org>
References: <11847726193856-git-send-email-segher@kernel.crashing.org>
	<5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Some old software on ppc32 executes from pages it hasn't marked
> executable.  Since "classic" hardware doesn't distinguish between
> execute and read accesses, the do_page_fault() code shouldn't
> either.  This makes glibc-2.2 work again on such hardware.
> 
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> ---
> [Resend again, ozlabs' greylisting doesn't like me at all.]
> 
> Tested by Scott on 32-bit, glibc-2.2.5 and glibc-2.3.3 (no new
> failures and problem solved), and by Johannes on his glibc-2.4
> "---p" testcase.  Could use testing on ppc64 and BookE too, for
> good measure.

Hmmm.  The dangling else clauses are pretty gross, and in fact we have
the same problem on POWER3 and RS64 processors (to be fair, we had
the problem before and didn't notice, but we should still fix it).

How about this instead?  Could people test it please?  (Note that
CPU_FTR_NOEXECUTE is 0 in 32-bit kernels.)

Paul.

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 0ece513..99c3093 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -283,7 +283,13 @@ good_area:
 		/* protection fault */
 		if (error_code & DSISR_PROTFAULT)
 			goto bad_area;
-		if (!(vma->vm_flags & VM_EXEC))
+		/*
+		 * Allow execution from readable areas if the MMU does not
+		 * provide separate controls over reading and executing.
+		 */
+		if (!(vma->vm_flags & VM_EXEC) &&
+		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
+		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
 			goto bad_area;
 #else
 		pte_t *ptep;
