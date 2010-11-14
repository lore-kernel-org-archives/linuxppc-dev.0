Return-Path: <jkenisto@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 213D2B710C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Nov 2010 15:15:42 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAE3xOo8026491
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 22:59:24 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAE4FSw3437412
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 23:15:28 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAE4FSv5024365
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:28 -0700
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAE4FRif024340
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:28 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 3/6] nvram: Always capture start of oops report to NVRAM
To: linuxppc-dev@lists.ozlabs.org
Date: Sat, 13 Nov 2010 20:15:27 -0800
Message-ID: <20101114041527.9457.8308.stgit@localhost.localdomain>
In-Reply-To: <20101114041510.9457.92921.stgit@localhost.localdomain>
References: <20101114041510.9457.92921.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we don't have room to capture the entire oops report, capture as much
as possible, starting 150 chars before the "Oops:" line.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/platforms/pseries/nvram.c |   91 ++++++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 6c88cda..e1bc1a4 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -446,6 +446,87 @@ static size_t capture_last_msgs(const char *old_msgs, size_t old_len,
 	}
 }
 
+/* Find the last occurrence of needle in haystack, which is haystack_len long.*/
+static const char *strnrstr(const char *haystack, const char *needle,
+							size_t haystack_len)
+{
+	size_t needle_len = strlen(needle);
+	const char *haystack_end = haystack + haystack_len;
+	const char *prev, *next = NULL;
+	do {
+		prev = next;
+		next = strnstr(haystack, needle, haystack_len);
+		if (next) {
+			haystack = next + needle_len;
+			haystack_len = haystack_end - haystack;
+		}
+	} while (next);
+	return prev;
+}
+
+/* The preamble is the last bit of messages logged before the oops. */
+#define PREAMBLE_CHARS 150
+#define OOPS_TAG "Oops: "
+
+/*
+ * Find the beginning of the most recent oops report, back up PREAMBLE_CHARS
+ * characters, and copy up to captured_len characters from there to captured[].
+ * If we can't find the oops, just capture the end of the printk buffer,
+ * if we haven't already.
+ */
+static size_t capture_oops(const char *old_msgs, size_t old_len,
+				const char *new_msgs, size_t new_len,
+				char *captured, size_t capture_len,
+				size_t already_captured)
+{
+	const char *poops;	/* Points to the 'O' in "Oops: ..." */
+	const char *preamble;
+	const char *old_end = old_msgs + old_len;
+	const char *new_end = new_msgs + new_len;
+	size_t nc1, nc2;
+
+	if ((poops = strnrstr(new_msgs, OOPS_TAG, new_len)) != NULL) {
+		/* Oops starts in new_msgs -- the most common case. */
+		preamble = poops - PREAMBLE_CHARS;
+		if (preamble >= new_msgs) {
+			/* preamble is also in new_msgs. */
+			nc1 = min(capture_len, (size_t)(new_end - preamble));
+			memcpy(captured, preamble, nc1);
+			nc2 = 0;
+		} else {
+			/* Have to get some of the preamble from old_msgs */
+			nc1 = min((size_t)(new_msgs - preamble), old_len);
+			memcpy(captured, (old_end - nc1), nc1);
+			nc2 = min(new_len, capture_len - nc1);
+			memcpy(captured + nc1, new_msgs, nc2);
+		}
+	} else if ((poops = strnrstr(old_msgs, OOPS_TAG, old_len)) != NULL) {
+		/* Oops starts in old_msgs. */
+		preamble = poops - PREAMBLE_CHARS;
+		if (preamble < old_msgs)
+			preamble = old_msgs;
+		nc1 = min(capture_len, (size_t)(old_end - preamble));
+		memcpy(captured, preamble, nc1);
+		nc2 = min((size_t)(capture_len - nc1), new_len);
+		memcpy(captured + nc1, new_msgs, nc2);
+	} else {
+		/*
+		 * Either there was a VERY long oops report that scrolled
+		 * out of the printk buffer, or the "Oops" tag is split
+		 * across old_msgs and new_msgs, or oopses don't start with
+		 * "Oops" anymore.  Just capture as much of the last messages
+		 * as we think we can squeeze into NVRAM.
+		 */
+		if (already_captured)
+			return already_captured;
+		nc1 = capture_last_msgs(old_msgs, old_len, new_msgs,
+					new_len, captured, capture_len);
+		nc2 = 0;
+	}
+
+	return nc1 + nc2;
+}
+
 /* our kmsg_dump callback */
 static void oops_to_nvram(struct kmsg_dumper *dumper,
 		enum kmsg_dump_reason reason,
@@ -457,6 +538,16 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 
 	text_len = capture_last_msgs(old_msgs, old_len, new_msgs, new_len,
 						oops_buf, oops_buf_sz);
+	if (reason == KMSG_DUMP_OOPS) {
+		/*
+		 * Ensure that we have the start of the oops report,
+		 * and the message(s) leading up to it.
+		 */
+		const char *poops = strnrstr(oops_buf, OOPS_TAG, oops_buf_sz);
+		if (!poops || poops < oops_buf + PREAMBLE_CHARS)
+			text_len = capture_oops(old_msgs, old_len, new_msgs,
+				new_len, oops_buf, oops_buf_sz, text_len);
+	}
 	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
 		(int) text_len, ERR_TYPE_KERNEL_PANIC, ++oops_count);
 }
