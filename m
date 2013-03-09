Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 03A372C0351
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 12:02:32 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix dynamic relocation
Date: Sat,  9 Mar 2013 02:02:30 +0100
Message-Id: <1362790950-23065-1-git-send-email-agraf@suse.de>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5ac47f7a introduced dynamic relocation of code by manually
relocating TOC entries. However, we need to access the TOC using
the physical address that we have for it, not the virtual address
that we can't even access yet.

Drop the offset from the TOC accessing pointer.

This fixes Linux 3.9 booting on OpenBIOS for me.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

I've also encountered breakage on a G5 Mac, not sure if it's related.
I'll have to test whether this is the culprit on that one too.

Ben, please make sure that this gets into 3.9.
---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7f7fb7f..2bf7cc3 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2851,7 +2851,7 @@ static void reloc_toc(void)
 		(__prom_init_toc_end - __prom_init_toc_start) / sizeof(long);
 
 	/* Need to add offset to get at __prom_init_toc_start */
-	__reloc_toc(__prom_init_toc_start + offset, offset, nr_entries);
+	__reloc_toc(__prom_init_toc_start, offset, nr_entries);
 
 	mb();
 }
-- 
1.6.0.2
