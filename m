Message-Id: <200009031238.OAA00869@piglet.grunz.lu>
Date: Sun, 3 Sep 2000 14:38:24 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Latest rsync from Paul doesn't compile
To: linuxppc-dev@lists.linuxppc.org
cc: paulus@linuxcare.com.au
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-967984710=:867"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-967984710=:867
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

Paul's latest rsync devel tree doesn't compile due to the recent MOL
patches. It's a problem with altivec symbols, and the patch below fixes
it for me.

However, I'm not sure I've done it the roght way, so the MOL maintainers
might want to look into this...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-967984710=:867
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="ksyms-mol.patch"

--- linux-2.4.paul/arch/ppc/kernel/ppc_ksyms.c	Sun Aug 27 12:46:13 2000
+++ linux/arch/ppc/kernel/ppc_ksyms.c	Sun Sep  3 13:44:52 2000
@@ -320,14 +320,16 @@
 extern PTE *Hash;
 extern unsigned long Hash_mask;
 extern void (*ret_from_except)(void);
+#ifdef CONFIG_ALTIVEC
 extern struct task_struct *last_task_used_altivec;
+EXPORT_SYMBOL(last_task_used_altivec);
+EXPORT_SYMBOL(giveup_altivec);
+#endif
 EXPORT_SYMBOL_NOVERS(mol_interface);
 EXPORT_SYMBOL(Hash);
 EXPORT_SYMBOL(Hash_mask);
 EXPORT_SYMBOL(handle_mm_fault);
 EXPORT_SYMBOL(last_task_used_math);
-EXPORT_SYMBOL(last_task_used_altivec);
-EXPORT_SYMBOL(giveup_altivec);
 EXPORT_SYMBOL(ret_from_except);
 #endif


--134458388-1804289383-967984710=:867--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
