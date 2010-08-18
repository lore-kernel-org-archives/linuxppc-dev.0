Return-Path: <nfont@austin.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B041B70D1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 05:58:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7IJj6Dq022204
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 15:45:06 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7IJwl94084362
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 15:58:47 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7IJwlOb032594
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 13:58:47 -0600
Received: from [9.53.40.150] (mudbug-009053040150.austin.ibm.com [9.53.40.150])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o7IJwkhv032568
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 13:58:47 -0600
Message-ID: <4C6C3B76.8040105@austin.ibm.com>
Date: Wed, 18 Aug 2010 14:58:46 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Correct rtas_data_buf locking in dlpar code
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The dlpar code can cause a deadlock to occur when making the RTAS
configure-connector call.  This occurs because we make kmalloc calls,
which can block, while parsing the rtas_data_buf and holding the
rtas_data_buf_lock.  This an cause issues if someone else attempts
to grab the rtas_data_bug_lock.

This patch alleviates this issue by copying the contents of the rtas_data_buf
to a local buffer before parsing.  This allows us to only hold the
rtas_data_buf_lock around the RTAS configure-connector calls.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 arch/powerpc/platforms/pseries/dlpar.c |   42 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2010-08-05 10:55:46.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2010-08-18 11:42:10.000000000 -0500
@@ -129,20 +129,35 @@ struct device_node *dlpar_configure_conn
 	struct property *property;
 	struct property *last_property = NULL;
 	struct cc_workarea *ccwa;
+	char *data_buf;
 	int cc_token;
-	int rc;
+	int rc = -1;
 
 	cc_token = rtas_token("ibm,configure-connector");
 	if (cc_token == RTAS_UNKNOWN_SERVICE)
 		return NULL;
 
-	spin_lock(&rtas_data_buf_lock);
-	ccwa = (struct cc_workarea *)&rtas_data_buf[0];
+	data_buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
+	if (!data_buf)
+		return NULL;
+
+	ccwa = (struct cc_workarea *)&data_buf[0];
 	ccwa->drc_index = drc_index;
 	ccwa->zero = 0;
 
-	rc = rtas_call(cc_token, 2, 1, NULL, rtas_data_buf, NULL);
-	while (rc) {
+	do {
+		/* Since we release the rtas_data_buf lock between configure
+		 * connector calls we want to re-populate the rtas_data_buffer
+		 * with the contents of the previous call.
+		 */
+		spin_lock(&rtas_data_buf_lock);
+
+		memcpy(rtas_data_buf, data_buf, RTAS_DATA_BUF_SIZE);
+		rc = rtas_call(cc_token, 2, 1, NULL, rtas_data_buf, NULL);
+		memcpy(data_buf, rtas_data_buf, RTAS_DATA_BUF_SIZE);
+
+		spin_unlock(&rtas_data_buf_lock);
+
 		switch (rc) {
 		case NEXT_SIBLING:
 			dn = dlpar_parse_cc_node(ccwa);
@@ -197,18 +212,19 @@ struct device_node *dlpar_configure_conn
 			       "returned from configure-connector\n", rc);
 			goto cc_error;
 		}
+	} while (rc);
 
-		rc = rtas_call(cc_token, 2, 1, NULL, rtas_data_buf, NULL);
+cc_error:
+	kfree(data_buf);
+
+	if (rc) {
+		if (first_dn)
+			dlpar_free_cc_nodes(first_dn);
+
+		return NULL;
 	}
 
-	spin_unlock(&rtas_data_buf_lock);
 	return first_dn;
-
-cc_error:
-	if (first_dn)
-		dlpar_free_cc_nodes(first_dn);
-	spin_unlock(&rtas_data_buf_lock);
-	return NULL;
 }
 
 static struct device_node *derive_parent(const char *path)
