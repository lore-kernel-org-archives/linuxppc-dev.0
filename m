Date: Fri, 25 Apr 2003 12:33:11 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: _PAGE_HWWRITE missing in pte_mkdirty()?
To: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEEHFMAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

I noticed that pte_mkdirty() does not set the change bit(HWWRITE) when
dirtying a page. I think it should. Is there a reason why it doesn't?

Patch below which adds HWWRITE to pte_mkdirty()

 Jocke

Index: include/asm-ppc/pgtable.h
===================================================================
RCS file: /home/cvsadmin/cvsroot/kernel/linuxppc/include/asm-ppc/pgtable.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pgtable.h
--- include/asm-ppc/pgtable.h	1 Nov 2002 13:44:24 -0000	1.1.1.1
+++ include/asm-ppc/pgtable.h	25 Apr 2003 09:20:47 -0000
@@ -526,7 +526,7 @@
 static inline pte_t pte_mkwrite(pte_t pte) {
 	pte_val(pte) |= _PAGE_RW; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte) {
-	pte_val(pte) |= _PAGE_DIRTY; return pte; }
+	pte_val(pte) |= _PAGE_DIRTY  | _PAGE_HWWRITE; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte) {
 	pte_val(pte) |= _PAGE_ACCESSED; return pte; }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
