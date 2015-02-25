Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AAA51A0140
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 04:43:42 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 25 Feb 2015 17:43:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 06C5117D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 17:43:52 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1PHhZ6r9568706
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 17:43:35 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1PHhYuD002604
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 10:43:34 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: mpe@ellerman.id.au
Subject: =?UTF-8?q?=5BPATCH=5D=20powerpc/powernv=3A=20check=20OPAL=5FREGISTER=5FDUMP=5FREGION=20calls=20exist?=
Date: Wed, 25 Feb 2015 18:43:08 +0100
Message-Id: <1424886188-32068-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Open Power systems, such call fails in OPAL : 

   OPAL: Called with bad token 101 !

The check on the OPAL_UNREGISTER_DUMP_REGION call is added for 
symmetry. I did not see any errors for it.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux.git/arch/powerpc/platforms/powernv/opal.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/powernv/opal.c
+++ linux.git/arch/powerpc/platforms/powernv/opal.c
@@ -665,6 +665,11 @@ static void __init opal_dump_region_init
 	uint64_t size;
 	int rc;
 
+	if (!opal_check_token(OPAL_REGISTER_DUMP_REGION)) {
+		pr_warn("Firmware doesn't support dump region buffers\n");
+		return;
+	}
+
 	/* Register kernel log buffer */
 	addr = log_buf_addr_get();
 	size = log_buf_len_get();
@@ -794,6 +799,9 @@ void opal_shutdown(void)
 			mdelay(10);
 	}
 
+	if (!opal_check_token(OPAL_UNREGISTER_DUMP_REGION))
+		return;
+
 	/* Unregister memory dump region */
 	opal_unregister_dump_region(OPAL_DUMP_REGION_LOG_BUF);
 }
