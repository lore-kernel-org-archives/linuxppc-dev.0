Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD0B0DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 03:06:29 +1000 (EST)
From: Tim Abbott <tabbott@MIT.EDU>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 11/15] powerpc: share .data output section definition
	between 32 and 64 bits.
Date: Tue, 28 Apr 2009 13:00:58 -0400
Message-Id: <1240938062-3264-12-git-send-email-tabbott@mit.edu>
In-Reply-To: <1240938062-3264-11-git-send-email-tabbott@mit.edu>
References: <1240938062-3264-1-git-send-email-tabbott@mit.edu>
	<1240938062-3264-2-git-send-email-tabbott@mit.edu>
	<1240938062-3264-3-git-send-email-tabbott@mit.edu>
	<1240938062-3264-4-git-send-email-tabbott@mit.edu>
	<1240938062-3264-5-git-send-email-tabbott@mit.edu>
	<1240938062-3264-6-git-send-email-tabbott@mit.edu>
	<1240938062-3264-7-git-send-email-tabbott@mit.edu>
	<1240938062-3264-8-git-send-email-tabbott@mit.edu>
	<1240938062-3264-9-git-send-email-tabbott@mit.edu>
	<1240938062-3264-10-git-send-email-tabbott@mit.edu>
	<1240938062-3264-11-git-send-email-tabbott@mit.edu>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@mit.edu>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>,
	Paul Mackerras <paulus@samba.org>, Tim Abbott <tabbott@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waseem Daher <wdaher@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since upcoming changes will add several more common pieces of code
between the 32-bit and 64-bit powerpc architectures, it seems best to
unify these two blocks.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/vmlinux.lds.S |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index a047a6c..47899b0 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -220,20 +220,19 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	_sdata = .;
 
-#ifdef CONFIG_PPC32
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
+#ifdef CONFIG_PPC32
 		*(.sdata)
 		*(.got.plt) *(.got)
-	}
 #else
-	.data : AT(ADDR(.data) - LOAD_OFFSET) {
-		DATA_DATA
 		*(.data.rel*)
 		*(.toc1)
 		*(.branch_lt)
+#endif
 	}
 
+#ifndef CONFIG_PPC32
 	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
 		*(.opd)
 	}
-- 
1.6.2.1
