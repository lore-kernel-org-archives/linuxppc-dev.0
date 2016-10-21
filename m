Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0VRy0jpQzDvby
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:46:21 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L2hrvb032757
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:46:20 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2675yh92u1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:46:19 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 00:46:17 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 64A66352005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:45:49 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L2kFeB33554562
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:46:15 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L2kFEN005252
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:46:15 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andreas Steffen <andreas.steffen@strongswan.org>
Subject: [PATCH v6 10/10] ima: platform-independent hash value
Date: Fri, 21 Oct 2016 00:44:58 -0200
In-Reply-To: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1477017898-10375-11-git-send-email-bauerman@linux.vnet.ibm.com>
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
index 38f2ed830dd6..802d5d20f36f 100644
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
2.7.4
