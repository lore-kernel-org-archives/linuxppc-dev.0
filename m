Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A00272C00C6
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 17:24:03 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 12:49:32 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2549E1258023
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 12:55:23 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A7NqQv9568646
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 12:53:52 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A7Nvnd013157
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 17:23:57 +1000
Subject: [PATCH 6/8] Distinguish between a os-partition and non-os partition
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 10 Apr 2013 12:53:41 +0530
Message-ID: <20130410072341.20150.2360.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce os_partition member in nvram_os_partition structure
to identify if the partition is an os partition or not. This
will be useful to handle non-os partitions of-config and
common in subsequent patches.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index d420b1d..6a3a7cd 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -53,20 +53,23 @@ struct nvram_os_partition {
 	int min_size;	/* minimum acceptable size (0 means req_size) */
 	long size;	/* size of data portion (excluding err_log_info) */
 	long index;	/* offset of data portion of partition */
+	bool os_partition; /* partition initialized by OS, not FW */
 };
 
 static struct nvram_os_partition rtas_log_partition = {
 	.name = "ibm,rtas-log",
 	.req_size = 2079,
 	.min_size = 1055,
-	.index = -1
+	.index = -1,
+	.os_partition = true
 };
 
 static struct nvram_os_partition oops_log_partition = {
 	.name = "lnx,oops-log",
 	.req_size = 4000,
 	.min_size = 2000,
-	.index = -1
+	.index = -1,
+	.os_partition = true
 };
 
 static const char *pseries_nvram_os_partitions[] = {
