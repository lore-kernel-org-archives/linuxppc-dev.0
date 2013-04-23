Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0E032C0160
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 00:23:07 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 00:13:39 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CC4752CE8053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 00:22:39 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3NEMXKF60031164
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 00:22:33 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3NEMdYF014623
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 00:22:39 +1000
Subject: [PATCH v2 2/2] powerpc/rtas_flash: New return code to indicate FW
 entitlement expiry
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 19:52:22 +0530
Message-ID: <20130423142103.25932.3677.stgit@hegdevasant>
In-Reply-To: <20130423141958.25932.5791.stgit@hegdevasant>
References: <20130423141958.25932.5791.stgit@hegdevasant>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add new return code to rtas_flash to indicate firmware entitlement
expiry. Strictly we don't need this update. But to keep it in sync
with PAPR, this was added.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas_flash.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index bc97a21..a3e4034 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -77,6 +77,11 @@
  * T side will be updated with a downlevel image
  */
 #define VALIDATE_TMP_UPDATE_DL 6
+/*
+ * The candidate image's release date is later than the system's firmware
+ * service entitlement date - service warranty period has expired
+ */
+#define VALIDATE_OUT_OF_WRNTY  7

 /* ibm,manage-flash-image operation tokens */
 #define RTAS_REJECT_TMP_IMG   0
