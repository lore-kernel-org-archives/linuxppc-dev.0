Message-Id: <200109242209.RAA30858@lists.linuxppc.org>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: paulus@samba.org
Subject: Re: [PATCH] gcc3 compatibility and debugger support
Date: Tue, 25 Sep 2001 00:09:55 +0200
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
References: <200109061932.OAA12306@lists.linuxppc.org> <15278.40161.431833.765393@cargo.ozlabs.ibm.com>
In-Reply-To: <15278.40161.431833.765393@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_JKT6FSL3BFOAQCHQJQC9"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_JKT6FSL3BFOAQCHQJQC9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Monday 24 September 2001 04:39, Paul Mackerras wrote:
> Franz Sirl writes:
> >  	current_set[smp_processor_id()] = new;
> > +#else
> > +	current_set[0] = new;
> >  #endif /* CONFIG_SMP */
>
> Yuck.  Just put the #endif before the line that sets current_set[].
> smp_processor_id() is 0 on UP.

OK, here is the updated patch.

Franz.


--------------Boundary-00=_JKT6FSL3BFOAQCHQJQC9
Content-Type: text/plain;
  charset="iso-8859-1";
  name="bk-misc1a.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="bk-misc1a.diff"

===== arch/ppc/kernel/process.c 1.29 vs edited =====
--- 1.29/arch/ppc/kernel/process.c	Tue Sep 18 03:19:06 2001
+++ edited/arch/ppc/kernel/process.c	Mon Sep 24 19:59:28 2001
@@ -226,8 +226,10 @@
 	if ((prev->thread.regs && (prev->thread.regs->msr & MSR_VEC)))
 		giveup_altivec(prev);
 #endif /* CONFIG_ALTIVEC */
-	current_set[smp_processor_id()] = new;
 #endif /* CONFIG_SMP */
+
+	current_set[smp_processor_id()] = new;
+
 	/* Avoid the trap.  On smp this this never happens since
 	 * we don't set last_task_used_altivec -- Cort
 	 */
===== include/asm-ppc/prom.h 1.20 vs edited =====
--- 1.20/include/asm-ppc/prom.h	Wed Aug 29 00:49:25 2001
+++ edited/include/asm-ppc/prom.h	Thu Sep  6 21:13:57 2001
@@ -106,7 +106,7 @@

 #define PTRRELOC(x)	((typeof(x))((unsigned long)(x) + offset))
 #define PTRUNRELOC(x)	((typeof(x))((unsigned long)(x) - offset))
-#define RELOC(x)	(*PTRRELOC(&(x)))
+#define RELOC(x)	(*({ typeof(x) * __ptr  = PTRRELOC(&(x)); __asm__ ("" : "=r" (__ptr) : "0" (__ptr)); __ptr;}))

 #endif /* _PPC_PROM_H */
 #endif /* __KERNEL__ */

--------------Boundary-00=_JKT6FSL3BFOAQCHQJQC9--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
