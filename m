Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vhHZ2KXyzDqGQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 01:54:17 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Suchanek <msuchanek@suse.de>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: Enhance the information in cpu_show_spectre_v1()
Date: Mon, 28 May 2018 15:19:14 +0200
Message-Id: <20180528131914.32231-1-msuchanek@suse.de>
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We now have barrier_nospec as mitigation so print it in
cpu_show_spectre_v1 when enabled.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/security.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 0239383c7e4d..a0c32d53980b 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -120,7 +120,10 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, c
 	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "Vulnerable\n");
+	if (barrier_nospec_enabled)
+		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+	else
+		return sprintf(buf, "Vulnerable\n");
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.13.6
