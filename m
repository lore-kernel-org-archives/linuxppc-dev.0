Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F345F4FDB9
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 10:05:38 +1000 (EST)
From: Tim Abbott <tabbott@MIT.EDU>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 7/8] powerpc: use new macro for .data.read_mostly section.
Date: Thu, 30 Apr 2009 19:56:16 -0400
Message-Id: <1241135777-9462-8-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135777-9462-7-git-send-email-tabbott@mit.edu>
References: <1241135777-9462-1-git-send-email-tabbott@mit.edu>
	<1241135777-9462-2-git-send-email-tabbott@mit.edu>
	<1241135777-9462-3-git-send-email-tabbott@mit.edu>
	<1241135777-9462-4-git-send-email-tabbott@mit.edu>
	<1241135777-9462-5-git-send-email-tabbott@mit.edu>
	<1241135777-9462-6-git-send-email-tabbott@mit.edu>
	<1241135777-9462-7-git-send-email-tabbott@mit.edu>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@mit.edu>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Tim Abbott <tabbott@mit.edu>,
	Waseem Daher <wdaher@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

.data.read_mostly should not need a separate output section; this
change moves it into the .data section.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/vmlinux.lds.S |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index f91d7c1..c982827 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -1,3 +1,4 @@
+
 #ifdef CONFIG_PPC64
 #define PROVIDE32(x)	PROVIDE(__unused__##x)
 #else
@@ -227,6 +228,7 @@ SECTIONS
 		PAGE_ALIGNED_DATA
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
+		READ_MOSTLY_DATA(L1_CACHE_BYTES)
 		DATA_DATA
 #ifdef CONFIG_PPC32
 		*(.sdata)
@@ -254,11 +256,6 @@ SECTIONS
 	_edata  =  .;
 	PROVIDE32 (edata = .);
 
-	. = ALIGN(L1_CACHE_BYTES);
-	.data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) {
-		*(.data.read_mostly)
-	}
-
 /*
  * And finally the bss
  */
-- 
1.6.2.1
