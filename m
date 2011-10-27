Return-Path: <geoff@geoffthorpe.net>
Received: from oproxy7-pub.bluehost.com (oproxy7.bluehost.com
 [IPv6:2605:dc00:100:2::a7])
 by ozlabs.org (Postfix) with SMTP id 3F7B01007D8
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2011 00:05:40 +1100 (EST)
From: Geoff Thorpe <geoff@geoffthorpe.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add pgprot_cached_noncoherent()
Date: Thu, 27 Oct 2011 08:58:45 -0400
Message-Id: <1319720325-5169-1-git-send-email-geoff@geoffthorpe.net>
Cc: Geoff Thorpe <geoff@geoffthorpe.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a pgprot combination required by some cache-enabled IO device
mappings, such as Freescale datapath (QMan and BMan) portals.

Signed-off-by: Geoff Thorpe <geoff@geoffthorpe.net>
---
 arch/powerpc/include/asm/pgtable.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 88b0bd9..2e0e411 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -170,6 +170,9 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
 #define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
 				            _PAGE_COHERENT | _PAGE_WRITETHRU))
 
+#define pgprot_cached_noncoherent(prot) \
+		(__pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL))
+
 #define pgprot_writecombine pgprot_noncached_wc
 
 struct file;
-- 
1.7.3.4
