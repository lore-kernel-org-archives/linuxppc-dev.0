Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6A617B734A
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:38:41 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Dan Malek <ppc6dev@digitaldans.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/3] 8xx: Use LARGE pages for kernel RAM.
Date: Mon, 10 Oct 2011 13:38:34 +0200
Message-Id: <1318246714-5015-4-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the new _PAGE_PSE to map all kernel RAM with 8 MB TLBs

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/mm/pgtable.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
index 866ae43..56e847e 100644
--- a/arch/ppc/mm/pgtable.c
+++ b/arch/ppc/mm/pgtable.c
@@ -298,7 +298,9 @@ void __init mapin_ram(void)
 		/* On the MPC8xx, we want the page shared so we
 		 * don't get ASID compares on kernel space.
 		 */
-		f = _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_SHARED | _PAGE_HWEXEC;
+		f = _PAGE_PSE | _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_SHARED | _PAGE_HWEXEC;
+		if (_PAGE_PSE)
+			f |= _PAGE_WRENABLE;
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH)
 		/* Allows stub to set breakpoints everywhere */
 		f |= _PAGE_WRENABLE;
-- 
1.7.3.4
