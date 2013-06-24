Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DEA7A2C05B2
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 16:23:16 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Mon, 24 Jun 2013 11:47:02 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C16B5E0055
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 11:52:43 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5O6NPes31719496
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 11:53:25 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5O6NBMi032322
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 16:23:12 +1000
Subject: [PATCH 2/3] powerpc/pseries: Re-organise the oops compression code
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 11:53:11 +0530
Message-ID: <20130624062311.12963.26436.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130624061936.12963.72529.stgit@aruna-ThinkPad-T420>
References: <20130624061936.12963.72529.stgit@aruna-ThinkPad-T420>
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

nvram_compress() and zip_oops() is used by the nvram_pstore_write
API to compress oops messages hence re-organise the functions
accordingly to avoid forward declarations.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |  104 ++++++++++++++++----------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 14cc486..0159d74 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -486,6 +486,58 @@ static int clobbering_unread_rtas_event(void)
 						NVRAM_RTAS_READ_TIMEOUT);
 }
 
+/* Derived from logfs_compress() */
+static int nvram_compress(const void *in, void *out, size_t inlen,
+							size_t outlen)
+{
+	int err, ret;
+
+	ret = -EIO;
+	err = zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
+						MEM_LEVEL, Z_DEFAULT_STRATEGY);
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
+	err = zlib_deflate(&stream, Z_FINISH);
+	if (err != Z_STREAM_END)
+		goto error;
+
+	err = zlib_deflateEnd(&stream);
+	if (err != Z_OK)
+		goto error;
+
+	if (stream.total_out >= stream.total_in)
+		goto error;
+
+	ret = stream.total_out;
+error:
+	return ret;
+}
+
+/* Compress the text from big_oops_buf into oops_buf. */
+static int zip_oops(size_t text_len)
+{
+	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
+	int zipped_len = nvram_compress(big_oops_buf, oops_data, text_len,
+								oops_data_sz);
+	if (zipped_len < 0) {
+		pr_err("nvram: compression failed; returned %d\n", zipped_len);
+		pr_err("nvram: logging uncompressed oops/panic report\n");
+		return -1;
+	}
+	oops_hdr->version = OOPS_HDR_VERSION;
+	oops_hdr->report_length = (u16) zipped_len;
+	oops_hdr->timestamp = get_seconds();
+	return 0;
+}
+
 #ifdef CONFIG_PSTORE
 static int nvram_pstore_open(struct pstore_info *psi)
 {
@@ -757,58 +809,6 @@ int __init pSeries_nvram_init(void)
 }
 
 
-/* Derived from logfs_compress() */
-static int nvram_compress(const void *in, void *out, size_t inlen,
-							size_t outlen)
-{
-	int err, ret;
-
-	ret = -EIO;
-	err = zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
-						MEM_LEVEL, Z_DEFAULT_STRATEGY);
-	if (err != Z_OK)
-		goto error;
-
-	stream.next_in = in;
-	stream.avail_in = inlen;
-	stream.total_in = 0;
-	stream.next_out = out;
-	stream.avail_out = outlen;
-	stream.total_out = 0;
-
-	err = zlib_deflate(&stream, Z_FINISH);
-	if (err != Z_STREAM_END)
-		goto error;
-
-	err = zlib_deflateEnd(&stream);
-	if (err != Z_OK)
-		goto error;
-
-	if (stream.total_out >= stream.total_in)
-		goto error;
-
-	ret = stream.total_out;
-error:
-	return ret;
-}
-
-/* Compress the text from big_oops_buf into oops_buf. */
-static int zip_oops(size_t text_len)
-{
-	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
-	int zipped_len = nvram_compress(big_oops_buf, oops_data, text_len,
-								oops_data_sz);
-	if (zipped_len < 0) {
-		pr_err("nvram: compression failed; returned %d\n", zipped_len);
-		pr_err("nvram: logging uncompressed oops/panic report\n");
-		return -1;
-	}
-	oops_hdr->version = OOPS_HDR_VERSION;
-	oops_hdr->report_length = (u16) zipped_len;
-	oops_hdr->timestamp = get_seconds();
-	return 0;
-}
-
 /*
  * This is our kmsg_dump callback, called after an oops or panic report
  * has been written to the printk buffer.  We want to capture as much
