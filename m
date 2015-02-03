Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D852A1A0AF2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 16:36:01 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 agraf@suse.de
Subject: [PATCH 2/5] powerpc: Remove powerpc specific byteswap from bt8xx DVB
 driver
Date: Tue,  3 Feb 2015 16:36:22 +1100
Message-Id: <1422941785-22557-3-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
References: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, aik@ozlabs.ru,
 Peter Hettkamp <peter.hettkamp@htp-tel.de>, linux-kernel@vger.kernel.org,
 mdroth@us.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The bt8xx PCI DVB driver includes a powerpc specific hack, using one of
the powerpc specific byteswapping functions in an IO helper macro.

There's no reason to use the powerpc specific function instead of a
generic byteswap, so this patch removes it.  I'm not sure if the powerpc
specific memory barrier is required, so I'm leaving that in.

Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Peter Hettkamp <peter.hettkamp@htp-tel.de>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 drivers/media/pci/bt8xx/bt878.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bt878.h b/drivers/media/pci/bt8xx/bt878.h
index d19b592..bbb76bb 100644
--- a/drivers/media/pci/bt8xx/bt878.h
+++ b/drivers/media/pci/bt8xx/bt878.h
@@ -145,12 +145,12 @@ void bt878_stop(struct bt878 *bt);
 #if defined(__powerpc__)	/* big-endian */
 static inline void io_st_le32(volatile unsigned __iomem *addr, unsigned val)
 {
-	st_le32(addr, val);
+	*addr = cpu_to_le32(val);
 	eieio();
 }
 
 #define bmtwrite(dat,adr)  io_st_le32((adr),(dat))
-#define bmtread(adr)       ld_le32((adr))
+#define bmtread(adr)       le32_to_cpu(*((volatile __le32 *)(adr)))
 #else
 #define bmtwrite(dat,adr)  writel((dat), (adr))
 #define bmtread(adr)       readl(adr)
-- 
2.1.0
