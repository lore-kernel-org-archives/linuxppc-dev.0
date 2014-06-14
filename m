Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D295D1A04CE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jun 2014 02:24:18 +1000 (EST)
Received: by mail-wi0-f178.google.com with SMTP id n15so2212739wiw.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 09:24:14 -0700 (PDT)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] arch: powerpc: platforms: cell: cbe_thermal.c: Cleaning up a
 variable is of the wrong type
Date: Sat, 14 Jun 2014 18:25:11 +0200
Message-Id: <1402763111-23458-2-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1402763111-23458-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1402763111-23458-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This variable is of the wrong type, everywhere it is used it
should be an unsigned int rather than a int.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/platforms/cell/cbe_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/cbe_thermal.c b/arch/powerpc/platforms/cell/cbe_thermal.c
index 94560db..2c15ff0 100644
--- a/arch/powerpc/platforms/cell/cbe_thermal.c
+++ b/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -125,7 +125,7 @@ static ssize_t show_throttle(struct cbe_pmd_regs __iomem *pmd_regs, char *buf, i
 static ssize_t store_throttle(struct cbe_pmd_regs __iomem *pmd_regs, const char *buf, size_t size, int pos)
 {
 	u64 reg_value;
-	int temp;
+	unsigned int temp;
 	u64 new_value;
 	int ret;
 
-- 
1.7.10.4
