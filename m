Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400YRy2bn8zF07p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 10:03:10 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2CMwitF038034
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:03:08 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gp1b22x72-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:03:07 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 12 Mar 2018 17:03:07 -0600
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
Subject: [PATCH v2 1/4] rfi-flush: Move the logic to avoid a redo into the
 debugfs code
Date: Mon, 12 Mar 2018 20:02:55 -0300
In-Reply-To: <1520895778-17586-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1520895778-17586-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1520895778-17586-2-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

rfi_flush_enable() includes a check to see if we're already
enabled (or disabled), and in that case does nothing.

But that means calling setup_rfi_flush() a 2nd time doesn't actually
work, which is a bit confusing.

Move that check into the debugfs code, where it really belongs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup_64.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index c388cc3..3efc01a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -846,9 +846,6 @@ static void do_nothing(void *unused)
 
 void rfi_flush_enable(bool enable)
 {
-	if (rfi_flush == enable)
-		return;
-
 	if (enable) {
 		do_rfi_flush_fixups(enabled_flush_types);
 		on_each_cpu(do_nothing, NULL, 1);
@@ -902,13 +899,19 @@ void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
 #ifdef CONFIG_DEBUG_FS
 static int rfi_flush_set(void *data, u64 val)
 {
+	bool enable;
+
 	if (val == 1)
-		rfi_flush_enable(true);
+		enable = true;
 	else if (val == 0)
-		rfi_flush_enable(false);
+		enable = false;
 	else
 		return -EINVAL;
 
+	/* Only do anything if we're changing state */
+	if (enable != rfi_flush)
+		rfi_flush_enable(enable);
+
 	return 0;
 }
 
-- 
2.7.4
