Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPLb10NMBzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 08:05:32 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v74M4YWo093376
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 18:05:30 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c4rp8udhn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 18:05:30 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 16:05:29 -0600
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v74M5PK331326246
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 15:05:26 -0700
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v74M5Rpg022345
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 19:05:28 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: linux-ima-devel@lists.sourceforge.net, keyrings@vger.kernel.org,
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
Subject: [PATCH v4 4/7] integrity: Introduce integrity_keyring_from_id
Date: Fri,  4 Aug 2017 19:03:27 -0300
In-Reply-To: <20170804220330.30026-1-bauerman@linux.vnet.ibm.com>
References: <20170804220330.30026-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20170804220330.30026-5-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IMA will need to obtain the keyring used to verify file signatures so that
it can verify the module-style signature appended to files.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/digsig.c    | 28 +++++++++++++++++++---------
 security/integrity/integrity.h |  1 +
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 06554c448dce..bb5328ba2848 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -48,11 +48,10 @@ static bool init_keyring __initdata;
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
 
-int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
-			    const char *digest, int digestlen)
+struct key *integrity_keyring_from_id(const unsigned int id)
 {
-	if (id >= INTEGRITY_KEYRING_MAX || siglen < 2)
-		return -EINVAL;
+	if (id >= INTEGRITY_KEYRING_MAX)
+		return ERR_PTR(-EINVAL);
 
 	if (!keyring[id]) {
 		keyring[id] =
@@ -61,18 +60,29 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 			int err = PTR_ERR(keyring[id]);
 			pr_err("no %s keyring: %d\n", keyring_name[id], err);
 			keyring[id] = NULL;
-			return err;
+			return ERR_PTR(err);
 		}
 	}
 
+	return keyring[id];
+}
+
+int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
+			    const char *digest, int digestlen)
+{
+	struct key *keyring = integrity_keyring_from_id(id);
+
+	if (IS_ERR(keyring) || siglen < 2)
+		return PTR_ERR(keyring);
+
 	switch (sig[1]) {
 	case 1:
 		/* v1 API expect signature without xattr type */
-		return digsig_verify(keyring[id], sig + 1, siglen - 1,
-				     digest, digestlen);
+		return digsig_verify(keyring, sig + 1, siglen - 1, digest,
+				     digestlen);
 	case 2:
-		return asymmetric_verify(keyring[id], sig, siglen,
-					 digest, digestlen);
+		return asymmetric_verify(keyring, sig, siglen, digest,
+					 digestlen);
 	}
 
 	return -EOPNOTSUPP;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9b1762076f38..1f8f1a31d487 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -134,6 +134,7 @@ int __init integrity_read_file(const char *path, char **data);
 
 #ifdef CONFIG_INTEGRITY_SIGNATURE
 
+struct key *integrity_keyring_from_id(const unsigned int id);
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 			    const char *digest, int digestlen);
 
-- 
2.13.0
