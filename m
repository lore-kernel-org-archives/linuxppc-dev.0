Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E67301A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 08:04:39 +1000 (EST)
Date: Thu, 5 Jun 2014 08:04:39 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mjw@linux.vnet.ibm.com
Subject: [PATCH] powerpc: exported functions __clear_user and copy_page use
 r2 so need _GLOBAL_TOC()
Message-ID: <20140605080439.34de3dc0@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__clear_user and copy_page load from the TOC and are also exported
to modules. This means we have to use _GLOBAL_TOC() so that we
create the global entry point that sets up the TOC.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/lib/copypage_64.S
===================================================================
--- a/arch/powerpc/lib/copypage_64.S
+++ b/arch/powerpc/lib/copypage_64.S
@@ -16,7 +16,7 @@ PPC64_CACHES:
         .tc             ppc64_caches[TC],ppc64_caches
         .section        ".text"
 
-_GLOBAL(copy_page)
+_GLOBAL_TOC(copy_page)
 BEGIN_FTR_SECTION
 	lis	r5,PAGE_SIZE@h
 FTR_SECTION_ELSE
Index: b/arch/powerpc/lib/string_64.S
===================================================================
--- a/arch/powerpc/lib/string_64.S
+++ b/arch/powerpc/lib/string_64.S
@@ -77,7 +77,7 @@ err3;	stb	r0,0(r3)
 	mr	r3,r4
 	blr
 
-_GLOBAL(__clear_user)
+_GLOBAL_TOC(__clear_user)
 	cmpdi	r4,32
 	neg	r6,r3
 	li	r0,0
