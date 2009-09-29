Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 5FFA0B7C2C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 02:00:10 +1000 (EST)
Date: Tue, 29 Sep 2009 12:00:06 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: warning: allocated section `.data_nosave'  not in
	segment
Message-ID: <20090929120006.78affe3f@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to align before the output section. Having the align inside
the output section causes the linker to put some filler in there,
which makes it a non-empty section, but this section isn't assigned to
a segment so you get a warning from the linker.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/kernel/vmlinux.lds.S
b/arch/powerpc/kernel/vmlinux.lds.S index f564293..e853763 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -236,6 +236,7 @@ SECTIONS
 		READ_MOSTLY_DATA(L1_CACHE_BYTES)
 	}
 
+  	. = ALIGN(PAGE_SIZE);
 	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
 		NOSAVE_DATA
 	}
