Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0D4FE2C00C3
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jan 2014 06:00:59 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 05:00:58 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E53D03578055
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jan 2014 06:00:56 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0UIfheF62980308
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jan 2014 05:41:43 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0UJ0tAC020157
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jan 2014 06:00:55 +1100
Subject: [PATCH] powerpc/pseries: Disable relocation on exception while going
 down during crash.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 00:30:45 +0530
Message-ID: <20140130190044.19305.63111.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Steve Best <sbest@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Disable relocation on exception while going down even in kdump case. This
is because we are about clear htab mappings while kexec-ing into kdump
kernel and we may run into issues if we still have AIL ON.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index c1f1908..3925173 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -430,8 +430,7 @@ static void pSeries_machine_kexec(struct kimage *image)
 {
 	long rc;
 
-	if (firmware_has_feature(FW_FEATURE_SET_MODE) &&
-	    (image->type != KEXEC_TYPE_CRASH)) {
+	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
 		rc = pSeries_disable_reloc_on_exc();
 		if (rc != H_SUCCESS)
 			pr_warning("Warning: Failed to disable relocation on "
