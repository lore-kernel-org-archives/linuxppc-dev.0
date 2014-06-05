Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F9C41A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 14:43:45 +1000 (EST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85049140093
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2014 14:43:44 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 10:13:42 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 131B61258048
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2014 10:12:59 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s554iPvm9634082
 for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2014 10:14:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s554hea3004845
 for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2014 10:13:40 +0530
Subject: [PATCH] powerpc/powernv: Pass buffer size to OPAL validate flash call
To: linuxppc-dev@ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Thu, 05 Jun 2014 10:13:40 +0530
Message-ID: <20140605044339.4622.81792.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We pass actual buffer size to opal_validate_flash() OPAL API call
and in return it contains output buffer size.

Commit cc146d1d (Fix little endian issues) missed to set the size
param before making OPAL call. So firmware image validation fails.

This patch sets size variable before making OPAL call.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Tested-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-flash.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index dc487ff..4e541e6 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -130,7 +130,8 @@ static inline void opal_flash_validate(void)
 {
 	long ret;
 	void *buf = validate_flash_data.buf;
-	__be32 size, result;
+	__be32 size = cpu_to_be32(validate_flash_data.buf_size);
+	__be32 result;
 
 	ret = opal_validate_flash(__pa(buf), &size, &result);
 
