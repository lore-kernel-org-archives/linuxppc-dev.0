Subject: get_pteptr prototype
From: Hollis Blanchard <hollis@austin.ibm.com>
To: paulus@samba.org
Cc: devel list <linuxppc-dev@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-V1ADyCFkeUMIl9FtaFrj"
Date: 06 Jan 2003 16:59:26 -0600
Message-Id: <1041893967.1207.42.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-V1ADyCFkeUMIl9FtaFrj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, I think the prototype for get_pteptr should be moved to
asm/pgtable.h . It currently is declared extern in mm/fault.c, and I
will need it for platforms/ibm405lp_pm.c .

Please apply to _2_4_devel and -2.5, and probably _2_4 for that matter.

-Hollis
--
PowerPC Linux
IBM Linux Technology Center

--=-V1ADyCFkeUMIl9FtaFrj
Content-Disposition: attachment; filename=get_pteptr.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=get_pteptr.diff; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1179  -> 1.1180=20
#	include/asm-ppc/pgtable.h	1.52    -> 1.53  =20
#	 arch/ppc/mm/fault.c	1.28    -> 1.29  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/06	hollis@granite.austin.ibm.com	1.1180
# move get_pteptr prototype to pgtable.h
# --------------------------------------------
#
diff -Nru a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
--- a/arch/ppc/mm/fault.c	Mon Jan  6 16:46:23 2003
+++ b/arch/ppc/mm/fault.c	Mon Jan  6 16:46:23 2003
@@ -55,7 +55,6 @@
 extern void die_if_kernel(char *, struct pt_regs *, long);
 void bad_page_fault(struct pt_regs *, unsigned long, int sig);
 void do_page_fault(struct pt_regs *, unsigned long, unsigned long);
-extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **pt=
ep);
=20
 /*
  * For 600- and 800-family processors, the error_code parameter is DSISR
diff -Nru a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h	Mon Jan  6 16:46:23 2003
+++ b/include/asm-ppc/pgtable.h	Mon Jan  6 16:46:23 2003
@@ -112,6 +112,7 @@
 extern unsigned long va_to_phys(unsigned long address);
 extern pte_t *va_to_pte(unsigned long address);
 extern unsigned long ioremap_bot, ioremap_base;
+extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **pt=
ep);
 #endif /* __ASSEMBLY__ */
=20
 /*

--=-V1ADyCFkeUMIl9FtaFrj--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
