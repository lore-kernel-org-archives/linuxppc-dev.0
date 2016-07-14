Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqsr15rKCzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 20:48:33 +1000 (AEST)
Date: Thu, 14 Jul 2016 13:48:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: [patch] ide: missing break statement in set_timings_mdma()
Message-ID: <20160714104802.GI18175@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There was clearly supposed to be a break statement here.  Currently we
use the k2 ata timings instead of sh ata ones we intended.  Probably no
one has this hardware anymore so it likely doesn't make a difference
beyond the static checker warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 7f0434f..0c5d3a9 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -707,6 +707,7 @@ set_timings_mdma(ide_drive_t *drive, int intf_type, u32 *timings, u32 *timings2,
 		*timings = ((*timings) & ~TR_133_PIOREG_MDMA_MASK) | tr;
 		*timings2 = (*timings2) & ~TR_133_UDMAREG_UDMA_EN;
 		}
+		break;
 	case controller_un_ata6:
 	case controller_k2_ata6: {
 		/* 100Mhz cell */
