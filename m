Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9E1DEDDFFB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Sep 2007 06:17:23 +1000 (EST)
Message-ID: <46F6C9C9.5060600@scram.de>
Date: Sun, 23 Sep 2007 22:17:13 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH1/4] [POWERPC] Fix copy'n'paste typo in commproc.c
Content-Type: multipart/mixed; boundary="------------020406050103040109000402"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020406050103040109000402
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


The powerpc version of commproc.c doesn't export cpm_dpram_addr twice
and cpm_dpram_phys not at all due to a typo. This patch fixes this
problem.

CC      arch/powerpc/sysdev/commproc.o
arch/powerpc/sysdev/commproc.c:398: error: redefinition of '__kcrctab_cpm_dpram_addr'
arch/powerpc/sysdev/commproc.c:392: error: previous definition of '__kcrctab_cpm_dpram_addr' was here
arch/powerpc/sysdev/commproc.c:398: error: redefinition of '__kstrtab_cpm_dpram_addr'
arch/powerpc/sysdev/commproc.c:392: error: previous definition of '__kstrtab_cpm_dpram_addr' was here
arch/powerpc/sysdev/commproc.c:398: error: redefinition of '__ksymtab_cpm_dpram_addr'
arch/powerpc/sysdev/commproc.c:392: error: previous definition of '__ksymtab_cpm_dpram_addr' was here
make[1]: *** [arch/powerpc/sysdev/commproc.o] Error 1
make: *** [arch/powerpc/sysdev] Error 2

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/sysdev/commproc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

--------------020406050103040109000402
Content-Type: text/x-patch;
 name="828fc894599eb4bb5a015277687adbb75bb94cc0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="828fc894599eb4bb5a015277687adbb75bb94cc0.diff"

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 4f67b89..dd5417a 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -395,4 +395,4 @@ uint cpm_dpram_phys(u8* addr)
 {
 	return (dpram_pbase + (uint)(addr - dpram_vbase));
 }
-EXPORT_SYMBOL(cpm_dpram_addr);
+EXPORT_SYMBOL(cpm_dpram_phys);


--------------020406050103040109000402--
