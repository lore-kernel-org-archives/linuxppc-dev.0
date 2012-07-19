Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 463DB2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 01:14:34 +1000 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Thu, 19 Jul 2012 10:44:20 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id ACFB46E8053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 10:42:58 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6JEgvd5346134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 10:42:57 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6JEgt8C020380
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 08:42:56 -0600
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc/crypto: add compression support to arch vec
Date: Thu, 19 Jul 2012 09:42:39 -0500
Message-Id: <1342708961-28587-3-git-send-email-sjenning@linux.vnet.ibm.com>
In-Reply-To: <1342708961-28587-1-git-send-email-sjenning@linux.vnet.ibm.com>
References: <1342708961-28587-1-git-send-email-sjenning@linux.vnet.ibm.com>
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>,
 Kent Yoder <key@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables compression engine support in the
architecture vector.  This causes the Power hypervisor
to allow access to the nx comrpession accelerator.

Signed-off-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 0794a30..9ec5e55 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -705,6 +705,7 @@ static void __init early_cmdline_parse(void)
 #endif
 #define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
 #define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
+#define OV5_PFO_HW_842		0x40	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x20	/* PFO Encryption Accelerator */
 
 /* Option Vector 6: IBM PAPR hints */
@@ -774,8 +775,7 @@ static unsigned char ibm_architecture_vec[] = {
 	0,
 	0,
 	0,
-	OV5_PFO_HW_RNG | OV5_PFO_HW_ENCR,
-
+	OV5_PFO_HW_RNG | OV5_PFO_HW_ENCR | OV5_PFO_HW_842,
 	/* option vector 6: IBM PAPR hints */
 	4 - 2,				/* length */
 	0,
-- 
1.7.9.5
