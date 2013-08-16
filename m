Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0525F2C033C
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:19:17 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 23:16:06 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3421B2BB004F
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:19:15 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7GD3EaC721234
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:03:14 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7GDJDkW018438
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:19:14 +1000
Subject: [RFC PATCH v2 11/11] pstore/ram: Read and write to the 'compressed'
 flag of pstore
To: linuxppc-dev@ozlabs.org, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 keescook@chromium.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 18:49:07 +0530
Message-ID: <20130816131907.3338.76154.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, cbouatmailru@gmail.com,
 mahesh@linux.vnet.ibm.com, ccross@android.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In pstore write, add character 'C'(compressed) or 'D'(decompressed)
in the header while writing to Ram persistent buffer. In pstore read,
read the header and update the 'compressed' flag accordingly.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 fs/pstore/ram.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 2927223..4027c20 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -131,6 +131,27 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
 	return prz;
 }
 
+static void ramoops_read_kmsg_hdr(char *buffer, struct timespec *time,
+				  bool *compressed)
+{
+	char data_type;
+
+	if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lu.%lu-%c\n",
+			&time->tv_sec, &time->tv_nsec, &data_type) == 3) {
+		if (data_type == 'C')
+			*compressed = true;
+		else
+			*compressed = false;
+	} else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lu.%lu\n",
+			&time->tv_sec, &time->tv_nsec) == 2) {
+			*compressed = false;
+	} else {
+		time->tv_sec = 0;
+		time->tv_nsec = 0;
+		*compressed = false;
+	}
+}
+
 static ssize_t ramoops_pstore_read(u64 *id, enum pstore_type_id *type,
 				   int *count, struct timespec *time,
 				   char **buf, bool *compressed,
@@ -153,10 +174,6 @@ static ssize_t ramoops_pstore_read(u64 *id, enum pstore_type_id *type,
 	if (!prz)
 		return 0;
 
-	/* TODO(kees): Bogus time for the moment. */
-	time->tv_sec = 0;
-	time->tv_nsec = 0;
-
 	size = persistent_ram_old_size(prz);
 
 	/* ECC correction notice */
@@ -167,12 +184,14 @@ static ssize_t ramoops_pstore_read(u64 *id, enum pstore_type_id *type,
 		return -ENOMEM;
 
 	memcpy(*buf, persistent_ram_old(prz), size);
+	ramoops_read_kmsg_hdr(*buf, time, compressed);
 	persistent_ram_ecc_string(prz, *buf + size, ecc_notice_size + 1);
 
 	return size + ecc_notice_size;
 }
 
-static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz)
+static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
+				     bool compressed)
 {
 	char *hdr;
 	struct timespec timestamp;
@@ -183,8 +202,9 @@ static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz)
 		timestamp.tv_sec = 0;
 		timestamp.tv_nsec = 0;
 	}
-	hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR "%lu.%lu\n",
-		(long)timestamp.tv_sec, (long)(timestamp.tv_nsec / 1000));
+	hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR "%lu.%lu-%c\n",
+		(long)timestamp.tv_sec, (long)(timestamp.tv_nsec / 1000),
+		compressed ? 'C' : 'D');
 	WARN_ON_ONCE(!hdr);
 	len = hdr ? strlen(hdr) : 0;
 	persistent_ram_write(prz, hdr, len);
@@ -243,7 +263,7 @@ static int notrace ramoops_pstore_write_buf(enum pstore_type_id type,
 
 	prz = cxt->przs[cxt->dump_write_cnt];
 
-	hlen = ramoops_write_kmsg_hdr(prz);
+	hlen = ramoops_write_kmsg_hdr(prz, compressed);
 	if (size + hlen > prz->buffer_size)
 		size = prz->buffer_size - hlen;
 	persistent_ram_write(prz, buf, size);
