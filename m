Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZbjL5tl9zDsXY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:27:02 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FBNLUx041056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 07:27:00 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25fsbhc843-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 07:26:59 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 21:26:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 545B73578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:52 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FBQqr761931656
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:52 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FBQp3V008497
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:52 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Andreas Steffen <andreas.steffen@strongswan.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 9/9] ima: platform-independent hash value
Date: Thu, 15 Sep 2016 07:26:11 -0400
In-Reply-To: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1473938771-2782-10-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andreas Steffen <andreas.steffen@strongswan.org>

For remote attestion it is important for the ima measurement values
to be platform-independent. Therefore integer fields to be hashed
must be converted to canonical format.

Changelog:
- Define canonical format as little endian (Mimi)

Signed-off-by: Andreas Steffen <andreas.steffen@strongswan.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 38f2ed8..802d5d2 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -477,11 +477,13 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 		u8 buffer[IMA_EVENT_NAME_LEN_MAX + 1] = { 0 };
 		u8 *data_to_hash = field_data[i].data;
 		u32 datalen = field_data[i].len;
+		u32 datalen_to_hash =
+		    !ima_canonical_fmt ? datalen : cpu_to_le32(datalen);
 
 		if (strcmp(td->name, IMA_TEMPLATE_IMA_NAME) != 0) {
 			rc = crypto_shash_update(shash,
-						(const u8 *) &field_data[i].len,
-						sizeof(field_data[i].len));
+						(const u8 *) &datalen_to_hash,
+						sizeof(datalen_to_hash));
 			if (rc)
 				break;
 		} else if (strcmp(td->fields[i]->field_id, "n") == 0) {
-- 
2.1.0
