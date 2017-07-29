Return-Path: <lin.sunze@gmail.com>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKHKx0ZyrzDrLv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 17:25:09 +1000 (AEST)
Received: by mail-pg0-f65.google.com with SMTP id y129so25598286pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 00:25:08 -0700 (PDT)
From: SZ Lin <sz.lin@moxa.com>
To: ashleydlai@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterhuewe@gmx.de, tpmdd@selhorst.ne, jarkko.sakkinen@linux.intel.com,
 jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 SZ Lin <sz.lin@moxa.com>
Subject: [PATCH 1/5] Fix packed and aligned attribute warnings.
Date: Sat, 29 Jul 2017 15:24:29 +0800
Message-Id: <20170729072433.13194-2-sz.lin@moxa.com>
In-Reply-To: <20170729072433.13194-1-sz.lin@moxa.com>
References: <20170729072433.13194-1-sz.lin@moxa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WARNING: __packed is preferred over __attribute__((packed))
+} __attribute__((packed, aligned(8)));

WARNING: __aligned(size) is preferred over __attribute__((aligned(size)))
+} __attribute__((packed, aligned(8)));

Signed-off-by: SZ Lin <sz.lin@moxa.com>
---
 drivers/char/tpm/tpm_ibmvtpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
index 91dfe766d080..9f708ca3dc84 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.h
+++ b/drivers/char/tpm/tpm_ibmvtpm.h
@@ -25,7 +25,7 @@ struct ibmvtpm_crq {
 	__be16 len;
 	__be32 data;
 	__be64 reserved;
-} __attribute__((packed, aligned(8)));
+} __packed __aligned(8);
 
 struct ibmvtpm_crq_queue {
 	struct ibmvtpm_crq *crq_addr;
-- 
2.13.3
