Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D24022C0375
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:18:31 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 18:42:09 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D196C394004D
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:48:17 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7GDJrFv39321756
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:49:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7GDIObu017718
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:48:25 +0530
Subject: [RFC PATCH v2 06/11] pstore: Add decompression support to pstore
To: linuxppc-dev@ozlabs.org, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 keescook@chromium.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 18:48:21 +0530
Message-ID: <20130816131821.3338.27923.stgit@aruna-ThinkPad-T420>
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

Based on the flag 'compressed' set or not, pstore will decompress the
data returning a plain text file. If decompression fails for a particular
record it will have the compressed data in the file which can be
decompressed with 'openssl' command line tool.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 fs/pstore/platform.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 6418eb7..0195cca0 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -162,6 +162,36 @@ error:
 	return ret;
 }
 
+/* Derived from logfs_uncompress */
+int pstore_decompress(void *in, void *out, size_t inlen, size_t outlen)
+{
+	int err, ret;
+
+	ret = -EIO;
+	err = zlib_inflateInit(&stream);
+	if (err != Z_OK)
+		goto error;
+
+	stream.next_in = in;
+	stream.avail_in = inlen;
+	stream.total_in = 0;
+	stream.next_out = out;
+	stream.avail_out = outlen;
+	stream.total_out = 0;
+
+	err = zlib_inflate(&stream, Z_FINISH);
+	if (err != Z_STREAM_END)
+		goto error;
+
+	err = zlib_inflateEnd(&stream);
+	if (err != Z_OK)
+		goto error;
+
+	ret = stream.total_out;
+error:
+	return ret;
+}
+
 static void allocate_buf_for_compression(void)
 {
 	size_t size;
@@ -429,6 +459,7 @@ void pstore_get_records(int quiet)
 	struct timespec		time;
 	int			failed = 0, rc;
 	bool			compressed;
+	int			unzipped_len = -1;
 
 	if (!psi)
 		return;
@@ -439,10 +470,28 @@ void pstore_get_records(int quiet)
 
 	while ((size = psi->read(&id, &type, &count, &time, &buf, &compressed,
 				psi)) > 0) {
+		if (compressed && (type == PSTORE_TYPE_DMESG)) {
+			if (big_oops_buf)
+				unzipped_len = pstore_decompress(buf,
+							big_oops_buf, size,
+							big_oops_buf_sz);
+
+			if (unzipped_len > 0) {
+				buf = big_oops_buf;
+				size = unzipped_len;
+			} else {
+				pr_err("pstore: decompression failed;"
+					"returned %d\n", unzipped_len);
+			}
+		}
 		rc = pstore_mkfile(type, psi->name, id, count, buf,
 				  (size_t)size, time, psi);
-		kfree(buf);
-		buf = NULL;
+		if (unzipped_len < 0) {
+			/* Free buffer other than big oops */
+			kfree(buf);
+			buf = NULL;
+		} else
+			unzipped_len = -1;
 		if (rc && (rc != -EEXIST || !quiet))
 			failed++;
 	}
