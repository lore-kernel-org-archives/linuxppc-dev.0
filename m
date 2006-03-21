Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:46:08 +1100
Subject: [PATCH 8/11] powerpc: Add strne2a() to convert a string from EBCDIC
	to ASCII
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094637.C86EE67BBB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add strne2a() which converts a string from EBCDIC to ASCII.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/lib/e2a.c       |   10 ++++++++++
 include/asm-powerpc/system.h |    2 ++
 2 files changed, 12 insertions(+)

Index: to-merge/arch/powerpc/lib/e2a.c
===================================================================
--- to-merge.orig/arch/powerpc/lib/e2a.c
+++ to-merge/arch/powerpc/lib/e2a.c
@@ -103,4 +103,14 @@ unsigned char e2a(unsigned char x)
 }
 EXPORT_SYMBOL(e2a);
 
+unsigned char* strne2a(unsigned char *dest, const unsigned char *src, size_t n)
+{
+	int i;
 
+	n = strnlen(src, n);
+
+	for (i = 0; i < n; i++)
+		dest[i] = e2a(src[i]);
+
+	return dest;
+}
Index: to-merge/include/asm-powerpc/system.h
===================================================================
--- to-merge.orig/include/asm-powerpc/system.h
+++ to-merge/include/asm-powerpc/system.h
@@ -171,6 +171,8 @@ extern u32 booke_wdt_period;
 
 /* EBCDIC -> ASCII conversion for [0-9A-Z] on iSeries */
 extern unsigned char e2a(unsigned char);
+extern unsigned char* strne2a(unsigned char *dest,
+		const unsigned char *src, size_t n);
 
 struct device_node;
 extern void note_scsi_host(struct device_node *, void *);
