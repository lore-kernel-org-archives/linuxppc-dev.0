Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406fMf3DnvzDr2S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 08:05:34 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id h2so10098057wre.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 14:05:34 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] cxl: remove a dead branch
Date: Thu, 22 Mar 2018 22:05:28 +0100
Message-Id: <20180322210528.22017-1-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 14baf4d9c739 ("cxl: Add guest-specific code") the following code
was added:

	if (afu->crs_len < 0) {
		dev_err(&afu->dev, "Unexpected configuration record size value\n");
		return -EINVAL;
	}

However the variable `crs_len` is of type u64 and cannot be compared < 0.
Remove the dead code section. Fix the following warning treated as error
with W=1:

../drivers/misc/cxl/guest.c:919:19: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/misc/cxl/guest.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index f58b4b6c79f2..48103fcff0b5 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -916,11 +916,6 @@ static int afu_properties_look_ok(struct cxl_afu *afu)
 		return -EINVAL;
 	}
 
-	if (afu->crs_len < 0) {
-		dev_err(&afu->dev, "Unexpected configuration record size value\n");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.11.0
