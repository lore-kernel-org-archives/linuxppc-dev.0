Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EB4B1A0BB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 17:31:32 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 8 Apr 2015 08:31:29 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 91ADB2190046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 08:31:10 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t387VO3q3211554
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Apr 2015 07:31:24 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t387VN0f015805
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Apr 2015 01:31:23 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: convert OPAL codes returned by sysparam calls
Date: Wed,  8 Apr 2015 09:31:10 +0200
Message-Id: <1428478270-26645-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Joel Stanley <joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The opal_{get,set}_param calls return internal error codes which need
to be translated in errnos in Linux. 

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-sysparam.c |   12 ++++++++----
 arch/powerpc/platforms/powernv/opal.c          |    1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

Index: linux.git/arch/powerpc/platforms/powernv/opal-sysparam.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ linux.git/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -55,8 +55,10 @@ static ssize_t opal_get_sys_param(u32 pa
 	}
 
 	ret = opal_get_param(token, param_id, (u64)buffer, length);
-	if (ret != OPAL_ASYNC_COMPLETION)
+	if (ret != OPAL_ASYNC_COMPLETION) {
+		ret = opal_error_code(ret);
 		goto out_token;
+	}
 
 	ret = opal_async_wait_response(token, &msg);
 	if (ret) {
@@ -65,7 +67,7 @@ static ssize_t opal_get_sys_param(u32 pa
 		goto out_token;
 	}
 
-	ret = be64_to_cpu(msg.params[1]);
+	ret = opal_error_code(be64_to_cpu(msg.params[1]));
 
 out_token:
 	opal_async_release_token(token);
@@ -89,8 +91,10 @@ static int opal_set_sys_param(u32 param_
 
 	ret = opal_set_param(token, param_id, (u64)buffer, length);
 
-	if (ret != OPAL_ASYNC_COMPLETION)
+	if (ret != OPAL_ASYNC_COMPLETION) {
+		ret = opal_error_code(ret);
 		goto out_token;
+	}
 
 	ret = opal_async_wait_response(token, &msg);
 	if (ret) {
@@ -99,7 +103,7 @@ static int opal_set_sys_param(u32 param_
 		goto out_token;
 	}
 
-	ret = be64_to_cpu(msg.params[1]);
+	ret = opal_error_code(be64_to_cpu(msg.params[1]));
 
 out_token:
 	opal_async_release_token(token);
Index: linux.git/arch/powerpc/platforms/powernv/opal.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/powernv/opal.c
+++ linux.git/arch/powerpc/platforms/powernv/opal.c
@@ -903,6 +903,7 @@ int opal_error_code(int rc)
 	case OPAL_ASYNC_COMPLETION:	return -EINPROGRESS;
 	case OPAL_BUSY_EVENT:		return -EBUSY;
 	case OPAL_NO_MEM:		return -ENOMEM;
+	case OPAL_PERMISSION:		return -EPERM;
 
 	case OPAL_UNSUPPORTED:		return -EIO;
 	case OPAL_HARDWARE:		return -EIO;
