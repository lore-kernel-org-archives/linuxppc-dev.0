Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGtqk0yL6zDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 11:54:25 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9I0rUDJ029274
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 20:54:23 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dnr5a2cm8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 20:54:23 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 20:54:22 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v5 05/18] ima: Simplify ima_eventsig_init
Date: Tue, 17 Oct 2017 22:53:18 -0200
In-Reply-To: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
References: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20171018005331.2688-6-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "goto out" statement doesn't have any purpose since there's no cleanup
to be done when returning early, so remove it. This also makes the rc
variable unnecessary so remove it as well.

Also, the xattr_len and fmt variables are redundant so remove them as well.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_template_lib.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index d941260e979f..e8ec783b6a8d 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -378,16 +378,11 @@ int ima_eventname_ng_init(struct ima_event_data *event_data,
 int ima_eventsig_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data)
 {
-	enum data_formats fmt = DATA_FMT_HEX;
 	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
-	int xattr_len = event_data->xattr_len;
-	int rc = 0;
 
 	if (!xattr_value || xattr_value->type != EVM_IMA_XATTR_DIGSIG)
-		goto out;
+		return 0;
 
-	rc = ima_write_template_field_data(xattr_value, xattr_len, fmt,
-					   field_data);
-out:
-	return rc;
+	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
+					     DATA_FMT_HEX, field_data);
 }
