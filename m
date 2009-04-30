Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E08A8DDED4
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 10:05:32 +1000 (EST)
From: Tim Abbott <tabbott@MIT.EDU>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 4/8] powerpc: use NOSAVE_DATA macro for .data.nosave section.
Date: Thu, 30 Apr 2009 19:56:13 -0400
Message-Id: <1241135777-9462-5-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135777-9462-4-git-send-email-tabbott@mit.edu>
References: <1241135777-9462-1-git-send-email-tabbott@mit.edu>
	<1241135777-9462-2-git-send-email-tabbott@mit.edu>
	<1241135777-9462-3-git-send-email-tabbott@mit.edu>
	<1241135777-9462-4-git-send-email-tabbott@mit.edu>
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

.data.nosave should not need a separate output section; this change
moves it into the .data section.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/vmlinux.lds.S |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index d3dcea0..4223892 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -222,6 +222,7 @@ SECTIONS
 
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		PAGE_ALIGNED_DATA
+		NOSAVE_DATA
 		DATA_DATA
 #ifdef CONFIG_PPC32
 		*(.sdata)
@@ -268,14 +269,6 @@ SECTIONS
 		*(.data.read_mostly)
 	}
 
-	. = ALIGN(PAGE_SIZE);
-	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
-		__nosave_begin = .;
-		*(.data.nosave)
-		. = ALIGN(PAGE_SIZE);
-		__nosave_end = .;
-	}
-
 /*
  * And finally the bss
  */
-- 
1.6.2.1
