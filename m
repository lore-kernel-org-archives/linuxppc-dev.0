Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 402D12C00D3
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Aug 2013 03:04:10 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 9 Aug 2013 02:47:45 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 16AA2357804E
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Aug 2013 03:04:06 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r78H3tc965470592
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Aug 2013 03:03:55 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r78H45Ri029084
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Aug 2013 03:04:05 +1000
Subject: [PATCH 2/2] powerpc/pseries: Add backward compatibilty to read old
 kernel oops-log
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 22:34:00 +0530
Message-ID: <20130808170358.9914.98084.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130808170253.9914.25346.stgit@aruna-ThinkPad-T420>
References: <20130808170253.9914.25346.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: mahesh@linux.vne.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Older kernels has just length information in their header. Handle it
while reading old kernel oops log from pstore.

Applies on top of powerpc/pseries: Fix buffer overflow when reading from pstore

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 893f360..6a5f2b1 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -720,15 +720,25 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 
 	if (nvram_type_ids[read_type] == PSTORE_TYPE_DMESG) {
 		int length, unzipped_len;
+		size_t hdr_size;
 
 		oops_hdr = (struct oops_log_info *)buff;
-		length = oops_hdr->report_length;
+		if (oops_hdr->version < OOPS_HDR_VERSION) {
+			/* Old format oops header had 2-byte record size */
+			hdr_size = sizeof(u16);
+			length = oops_hdr->version;
+			time->tv_sec = 0;
+			time->tv_nsec = 0;
+		} else {
+			hdr_size = sizeof(*oops_hdr);
+			length = oops_hdr->report_length;
+			time->tv_sec = oops_hdr->timestamp;
+			time->tv_nsec = 0;
+		}
 		*buf = kmalloc(length, GFP_KERNEL);
 		if (*buf == NULL)
 			return -ENOMEM;
-		memcpy(*buf, buff + sizeof(*oops_hdr), length);
-		time->tv_sec = oops_hdr->timestamp;
-		time->tv_nsec = 0;
+		memcpy(*buf, buff + hdr_size, length);
 		kfree(buff);
 
 		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ) {
