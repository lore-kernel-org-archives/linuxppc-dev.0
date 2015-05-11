Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 104A41A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 18:24:47 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D5EF51400B7
 for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2015 18:24:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 11 May 2015 18:24:45 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 26D372CE8050
 for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2015 18:24:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B8OX1x49479810
 for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2015 18:24:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B8O9oD024704
 for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2015 18:24:09 +1000
Subject: [PATCH] nvram: print no error message when nvram is not set as
 pstore backend
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Mon, 11 May 2015 13:53:43 +0530
Message-ID: <20150511082343.31385.39300.stgit@hbathini.in.ibm.com>
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

Pstore only supports one backend at a time. The preferred
pstore backend is set by passing the pstore.backend=<name>
argument to the kernel at boot time. Currently, while trying
to register with pstore, nvram throws an error message even
when "pstore.backend != nvram", which is unnecessary. This
patch removes the error message in case "pstore.backend != nvram".

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/nvram_64.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 1e703f8..bfdbcab 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -582,9 +582,10 @@ static int nvram_pstore_init(void)
 	spin_lock_init(&nvram_pstore_info.buf_lock);
 
 	rc = pstore_register(&nvram_pstore_info);
-	if (rc != 0)
-		pr_err("nvram: pstore_register() failed, defaults to "
-				"kmsg_dump; returned %d\n", rc);
+	if (rc && (rc != -EPERM))
+		/* Print error only when pstore.backend == nvram */
+		pr_err("nvram: pstore_register() failed, returned %d. "
+				"Defaults to kmsg_dump\n", rc);
 
 	return rc;
 }
