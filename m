Message-ID: <3F9A511D.2000002@alles.or.jp>
Date: Sat, 25 Oct 2003 19:31:57 +0900
From: Takeharu KATO <tk1219@alles.or.jp>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [TRIVAL] Critical interrupt handling for PPC44x
Content-Type: multipart/mixed;
 boundary="------------090901060204010509040601"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090901060204010509040601
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Dear all:

I fixed ``ret_from_crit_exc'' in arch/ppc/kernel/entry.S for PPC44x.
In PPC44x return from interruption with CSRR0/CSRR1 instead of SRR2/SRR3.
But I do not have PPC44x board so, I did not test this code on a real
machine.
Please test this code.

--
-----------------------------------
Takeharu KATO
Mail: tk1219@alles.or.jp


--------------090901060204010509040601
Content-Type: text/x-diff;
 name="crit-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="crit-fix.patch"

diff -Nacr linux-2.6.0-test8-original/arch/ppc/kernel/entry.S linux-2.6.0-test8/arch/ppc/kernel/entry.S
*** linux-2.6.0-test8-original/arch/ppc/kernel/entry.S	2003-10-24 23:58:30.000000000 +0900
--- linux-2.6.0-test8/arch/ppc/kernel/entry.S	2003-10-25 19:15:47.678618416 +0900
***************
*** 689,696 ****
--- 689,701 ----
  	mtspr	SPRN_ESR,r10
  	lwz	r11,_NIP(r1)
  	lwz	r12,_MSR(r1)
+ #if defined(CONFIG_44x)
+ 	mtspr	CSRR0,r11
+ 	mtspr	CSRR1,r12
+ #else
  	mtspr	SRR2,r11
  	mtspr	SRR3,r12
+ #endif
  	lwz	r9,GPR9(r1)
  	lwz	r12,GPR12(r1)
  	lwz	r10,crit_sprg0@l(0)
diff -Nacr linux-2.6.0-test8-original/arch/ppc/kernel/ppc_ksyms.c linux-2.6.0-test8/arch/ppc/kernel/ppc_ksyms.c
*** linux-2.6.0-test8-original/arch/ppc/kernel/ppc_ksyms.c	2003-10-24 23:58:40.000000000 +0900
--- linux-2.6.0-test8/arch/ppc/kernel/ppc_ksyms.c	2003-10-25 19:17:24.102959688 +0900
***************
*** 365,370 ****
--- 365,371 ----

  EXPORT_SYMBOL(next_mmu_context);
  EXPORT_SYMBOL(set_context);
+ #if defined(CONFIG_PPC_MULTIPLATFORM)
  EXPORT_SYMBOL(handle_mm_fault); /* For MOL */
  EXPORT_SYMBOL_NOVERS(disarm_decr);
  extern long mol_trampoline;
***************
*** 375,380 ****
--- 376,382 ----
  extern int mmu_hash_lock;
  EXPORT_SYMBOL(mmu_hash_lock); /* For MOL */
  #endif /* CONFIG_SMP */
+ #endif  /*  CONFIG_PPC_MULTIPLATFORM  */
  extern long *intercept_table;
  EXPORT_SYMBOL(intercept_table);
  #endif /* CONFIG_PPC_STD_MMU */

--------------090901060204010509040601--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
