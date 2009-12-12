Return-Path: <albert_herranz@yahoo.es>
Received: from smtp104.mail.ukl.yahoo.com (smtp104.mail.ukl.yahoo.com
	[77.238.184.36]) by ozlabs.org (Postfix) with SMTP id 8F22EB7C4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Dec 2009 03:32:22 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 22/22] powerpc: wii: allow ioremap within the memory hole
Date: Sat, 12 Dec 2009 17:31:55 +0100
Message-Id: <1260635515-7478-23-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
References: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the flag that allows a platform to ioremap memory marked
as reserved.

This is currently needed on the Nintendo Wii video game console
due to the workaround introduced in "wii: use both mem1 and mem2 as ram".

This will no longer be needed when proper discontig memory support
for 32-bit PowerPC is added to the kernel.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/embedded6xx/wii.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index de0c1e3..57e5b60 100644
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
