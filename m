Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33D5A2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 22:05:52 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/fsl-pci: fix the unreachable warning message
Date: Tue, 21 May 2013 20:04:59 +0800
Message-ID: <1369137900-5748-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The (1ull << mem_log) is never greater than mem unless mem_log++;

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 028ac1f..3833c8f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -305,10 +305,10 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
 		/* Size window to exact size if power-of-two or one size up */
 		if ((1ull << mem_log) != mem) {
+			mem_log++;
 			if ((1ull << mem_log) > mem)
 				pr_info("%s: Setting PCI inbound window "
 					"greater than memory size\n", name);
-			mem_log++;
 		}
 
 		piwar |= ((mem_log - 1) & PIWAR_SZ_MASK);
-- 
1.8.1.4
