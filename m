Return-Path: <clg@kaod.org>
Received: from 12.mo3.mail-out.ovh.net (12.mo3.mail-out.ovh.net
 [188.165.41.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRT3N44JMzDqpW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 19:03:59 +1000 (AEST)
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id E045112AF05
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 10:56:37 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 01/10] powerpc/xive: fix OV5_XIVE_EXPLOIT bits
Date: Tue,  8 Aug 2017 10:56:11 +0200
Message-Id: <1502182579-990-2-git-send-email-clg@kaod.org>
In-Reply-To: <1502182579-990-1-git-send-email-clg@kaod.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Platform Exploitation Mode support is indicated by the property
"ibm,arch-vec-5-platform-support-vec-5" : byte 23 bits 0-1 set to 0b01
or 0b10

OS Selection for Exploitation Mode is indicated by the property
"ibm,architecture-vec-5" : byte 23 bits 0-1 set to 0b01. A value of
0b00 indicates use of legacy compatibility mode.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/prom.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 35c00d7a0cf8..b6edaa0ed833 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -159,7 +159,8 @@ struct of_drconf_cell {
 #define OV5_PFO_HW_842		0x1140	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x1120	/* PFO Encryption Accelerator */
 #define OV5_SUB_PROCESSORS	0x1501	/* 1,2,or 4 Sub-Processors supported */
-#define OV5_XIVE_EXPLOIT	0x1701	/* XIVE exploitation supported */
+#define OV5_XIVE_SUPPORT	0x17C0	/* XIVE Exploitation Support Mask */
+#define OV5_XIVE_EXPLOIT	0x1740	/* XIVE exploitation mode */
 /* MMU Base Architecture */
 #define OV5_MMU_SUPPORT		0x18C0	/* MMU Mode Support Mask */
 #define OV5_MMU_HASH		0x1800	/* Hash MMU Only */
-- 
2.7.5
