Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 5F313B7BDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 05:44:01 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 4/4] powerpc: wii: allow ioremap within the memory hole
Date: Tue,  8 Dec 2009 19:43:53 +0100
Message-Id: <1260297833-17625-5-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>
References: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/wii.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 5eaed86..0df8a91 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -97,6 +97,9 @@ void __init wii_memory_fixups(void)
 
 	/* reserve the hole */
 	lmb_reserve(wii_hole_start, wii_hole_size);
+
+	/* allow ioremapping the address space in the hole */
+	__allow_ioremap_reserved = 1;
 }
 
 unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
-- 
1.6.3.3
