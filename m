Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 51249DDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 03:13:55 +1000 (EST)
Message-ID: <46F7F04A.7020602@scram.de>
Date: Mon, 24 Sep 2007 19:13:46 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH#2 1/4] [POWERPC] Fix copy'n'paste typo in commproc.c
Content-Type: multipart/mixed; boundary="------------040807070706020104050703"
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
--------------040807070706020104050703
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The powerpc version of commproc.c exports cpm_dpram_addr twice
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

--------------040807070706020104050703
Content-Type: text/x-patch;
 name="ef0b35e6f35cd911148c86f0b73cce536968d5b5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ef0b35e6f35cd911148c86f0b73cce536968d5b5.diff"

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


--------------040807070706020104050703--
