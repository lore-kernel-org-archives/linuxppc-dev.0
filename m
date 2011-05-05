Return-Path: <mmarek@suse.cz>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 105621007F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 May 2011 01:23:39 +1000 (EST)
From: Michal Marek <mmarek@suse.cz>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH v2] powerpc: Use the deterministic mode of ar
Date: Thu,  5 May 2011 17:22:55 +0200
Message-Id: <1304608975-21441-1-git-send-email-mmarek@suse.cz>
In-Reply-To: <1302015561-21047-6-git-send-email-mmarek@suse.cz>
References: <1302015561-21047-6-git-send-email-mmarek@suse.cz>
In-Reply-To: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Michal Marek <mmarek@suse.cz>

---

Hi,

this version fixes build with binutils <= 2.19 by first checking if ar(1)
supports the D option. It depends on a previous patch in the kbuild tree,
commit 40df759e (kbuild: Fix build with binutils <= 2.19) in linux-next,
so it will need to go through the kbuild tree. But feedback from the PPC
maintainers would be appreciated.

Thanks
Michal

---
 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8917816..f0543f8 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -127,7 +127,7 @@ quiet_cmd_bootas = BOOTAS  $@
       cmd_bootas = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
 
 quiet_cmd_bootar = BOOTAR  $@
-      cmd_bootar = $(CROSS32AR) -cr $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
+      cmd_bootar = $(CROSS32AR) -cr$(KBUILD_ARFLAGS) $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
 
 $(obj-libfdt): $(obj)/%.o: $(srctree)/scripts/dtc/libfdt/%.c FORCE
 	$(call if_changed_dep,bootcc)
-- 
1.7.4.1
