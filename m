Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18EC11A08CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 10:41:56 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 9 Oct 2014 17:41:54 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CC9803E4003D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Oct 2014 17:41:50 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s99Nfo9Q53084176
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 01:41:50 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s99NfoGQ002561
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Oct 2014 17:41:50 -0600
Date: Thu, 9 Oct 2014 16:41:28 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/numa: check error return from proc_create
Message-ID: <20141009234128.GB30604@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

proc_create can fail, we should check the return value and pass up the
failure.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d7737a542fd7..e28c21ba862d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1808,7 +1808,8 @@ static const struct file_operations topology_ops = {
 static int topology_update_init(void)
 {
 	start_topology_update();
-	proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops);
+	if (!proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops))
+		return -ENOMEM;
 
 	return 0;
 }
