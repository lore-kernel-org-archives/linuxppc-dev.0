Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3153687E7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 06:06:25 +1100 (EST)
Date: Wed, 23 Nov 2005 13:03:37 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0511231303030.4255-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Fix suboptimal uImage target   
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sam Ravnborg pointed out that calling if_changed was redudant in the
rule since we a prerequisite had to have change for us to get there.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit b3b2fd54eab2d87dcc29db5c537b5aee2a7732ce
tree 0eba205e3944aca7095fb2723f95e9799be5c853
parent 74dc65dbfa00bb69929c34da2ae788868aaae399
author Kumar Gala <galak@kernel.crashing.org> Wed, 23 Nov 2005 13:04:48 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 23 Nov 2005 13:04:48 -0600

 arch/powerpc/boot/Makefile    |    2 +-
 arch/ppc/boot/images/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index dfc7eac..22726ae 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -169,7 +169,7 @@ $(obj)/vmlinux.gz: $(obj)/vmlinux.bin FO
 
 $(obj)/uImage: $(obj)/vmlinux.gz
 	$(Q)rm -f $@
-	$(call if_changed,uimage)
+	$(call cmd,uimage)
 	@echo -n '  Image: $@ '
 	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
 
diff --git a/arch/ppc/boot/images/Makefile b/arch/ppc/boot/images/Makefile
index 532e7ef..58415d5 100644
--- a/arch/ppc/boot/images/Makefile
+++ b/arch/ppc/boot/images/Makefile
@@ -26,7 +26,7 @@ quiet_cmd_uimage = UIMAGE  $@
 targets += uImage
 $(obj)/uImage: $(obj)/vmlinux.gz
 	$(Q)rm -f $@
-	$(call if_changed,uimage)
+	$(call cmd,uimage)
 	@echo -n '  Image: $@ '
 	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
 
