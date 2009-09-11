Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AB993B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 15:37:59 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02CA9DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 15:37:58 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n8B5brPp007254
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 00:37:54 -0500
Subject: [PATCH] powerpc/iseries: Fix oops reading from
	/proc/iSeries/mf/*/cmdline
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 15:37:52 +1000
Message-Id: <1252647472.8566.66.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

That code uses dma_mapping_error() with a NULL device, which is
a bad idea :-) The proper fix might be to start using some kind
of pseudo device for all these low level mappings with the
hypervisor but that will be for another day. Since it directly
calls into the low level iommu code, I see no problem in having
it directly test against DMA_ERROR_CODE instead of using the
accessors with a NULL argument for now.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/iseries/mf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/mf.c b/arch/powerpc/platforms/iseries/mf.c
index fef4d51..0d9343d 100644
--- a/arch/powerpc/platforms/iseries/mf.c
+++ b/arch/powerpc/platforms/iseries/mf.c
@@ -872,7 +872,7 @@ static int proc_mf_dump_cmdline(char *page, char **start, off_t off,
 		count = 256 - off;
 
 	dma_addr = iseries_hv_map(page, off + count, DMA_FROM_DEVICE);
-	if (dma_mapping_error(NULL, dma_addr))
+	if (dma_addr == DMA_ERROR_CODE)
 		return -ENOMEM;
 	memset(page, 0, off + count);
 	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
-- 
1.6.1.2.14.gf26b5
