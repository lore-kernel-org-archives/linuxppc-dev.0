Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CBA0A67BF9
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 13:25:46 +1000 (EST)
Date: Tue, 2 May 2006 13:25:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: move _etext out of the text section
Message-Id: <20060502132525.00bde9ab.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The readprofile program stops when it hits the first non-text symbol
after _stext.  By moving _etext, it will become an absolute symbol and
so stop the readprofile output.  This is a safety measure in case more
text symbols are placed directly after the text section.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/vmlinux.lds.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

It would be nice if this was in 2.6.17, but 2.6.18 would also do.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

77a86e7cdbf5eaa5810109f7632e5bff69e1a7e6
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index fe79c25..9055f5a 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -46,12 +46,12 @@ #ifdef CONFIG_PPC32
 		*(.got2)
 		__got2_end = .;
 #endif /* CONFIG_PPC32 */
-
-		. = ALIGN(PAGE_SIZE);
-		_etext = .;
-		PROVIDE32 (etext = .);
 	}
 
+	. = ALIGN(PAGE_SIZE);
+	_etext = .;
+	PROVIDE32 (etext = .);
+
 	/* Read-only data */
 	RODATA
 
-- 
1.3.1.gaa6b
