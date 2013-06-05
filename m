Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 199792C03A5
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 04:52:09 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 6 Jun 2013 04:45:20 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 17D472BB0051
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 04:52:06 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r55IpvDl21692592
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Jun 2013 04:51:57 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r55Iq4Bh007797
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Jun 2013 04:52:05 +1000
Subject: [PATCH v4 6/8] powerpc/pseries: Distinguish between a os-partition
 and non-os partition
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 06 Jun 2013 00:21:59 +0530
Message-ID: <20130605185159.25794.87413.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130605184756.25794.43872.stgit@aruna-ThinkPad-T420>
References: <20130605184756.25794.43872.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, anton@samba.org, ccross@android.com,
 keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce os_partition member in nvram_os_partition structure to identify
if the partition is an os partition or not. This will be useful to handle
non-os partitions of-config and common.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 78d72f0..714ed8a 100644
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
