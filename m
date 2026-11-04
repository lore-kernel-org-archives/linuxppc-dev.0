Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDD606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rTd1MCH0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKNRj5Yk5z2xSF;
	Wed, 04 Nov 2026 22:26:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793776821;
	cv=none; b=g9o5bMBoTqugbpZNlERpMTHsliwxhUnQvmwEKJ13jiZEdjVcDG68PuAyFhstSH1I6scwylPK9pOYarBg7afMoyBX4zPF0s/TugVXQb9vrnFErUmIPloNZxLBLDc9D49JiDj00liZ2JaT1bLXfuUQxV5OKcPKXSBD+JtMb+10vzDhBQfkQdptUVtJdqgX0Gyl/fvdYy5lto8PElDq8nCk1nsZ9FxfYX+4KpbaVZmGI605NZ7oOqIu3Ur0BWMbK4oI7pYU9SCnRftDrfk8GOfKDMYLKB4sV2q2RvaA9IweVuzDaREFuS5RgDnkV/fblfbtpwn4YMW2Z+a4lu31ub8z1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793776821; c=relaxed/relaxed;
	bh=QJkn9B/LfIOPR4jFGJ7IeRxoY4pfs1XtIuRVOo50MGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xk4b3U5yOof41Ugqont3vTmUKK7ZaTJQEj1+Dr+W86lXDaY+d397GeZgWYTccANeCI2aIvi7fGTc7Z+WkGrVaZ0ynjpj8eeeJjo6EOCtyXE+tGAeGEf54sOSRMjCC4/T40UijTWM4iV6FdtzJ/LJDRA4h56ULDOD9BdHlPhRBZuMkBXM26mgKX+ma7uXx+pB1DmMn8aH98r/1QowdVncKuFMaVGKgf9zLDmtQq8oOB0qN2pihTHor+rz2TLQAFZUOP6GGjwDD8IusnJv/P+3NqiqDyyR2IdIOwcY7xnP7Hi/gETToa7Lrld6QurGyte6Geiv0M6bDUstt3/AkD49tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rTd1MCH0; dkim-atps=neutral; spf=pass (client-ip=111.22.67.151; helo=cmccmta8.chinamobile.com; envelope-from=zhangchujun@cmss.chinamobile.com; receiver=lists.ozlabs.org) smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rTd1MCH0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmss.chinamobile.com (client-ip=111.22.67.151; helo=cmccmta8.chinamobile.com; envelope-from=zhangchujun@cmss.chinamobile.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 183 seconds by postgrey-1.37 at boromir; Wed, 04 Nov 2026 18:20:17 AEDT
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKH012j4Xz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 18:20:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rTd1MCH086dUweHC+6jNloMDVfF7QlH3MDQDMFEPJrwc54Hoih5nqaiUBtQ3YUxC4uGMs74J5W9Ub
	 qXggK5gj71LD+tHn6Oo1oTrVnGd/N3/rGGQfhTUpZOSkqDL4f1xL5wuo7NEBpXXYhjF3jAOy1bUmey
	 KkR1on6+w0TM6oOQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aeadbf1107-678ff;
	Wed, 04 Nov 2026 15:17:07 +0800 (CST)
X-RM-TRANSID:2ee66aeadbf1107-678ff
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-eb75daa8a6be458c-20260816004526035 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aeadbef1e6-186ba;
	Wed, 04 Nov 2026 15:17:06 +0800 (CST)
X-RM-TRANSID:2ee56aeadbef1e6-186ba
From: zhangchujun <zhangchujun@cmss.chinamobile.com>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	zhangchujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] selftests/powerpc: papr_attributes: fix file descriptor leaks
Date: Wed,  4 Nov 2026 15:17:01 +0800
Message-ID: <20261104071701.1591-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

verify_energy_info() opens multiple sysfs files for each attribute
but does not close them, leaking file descriptors during directory
iteration. The directory stream opened by opendir() is also never
closed.

Add a helper to check file contents and close each file after
reading. Check the return value of opendir() and ensure the directory
stream is closed on both success and failure paths.

Signed-off-by: zhangchujun <zhangchujun@cmss.chinamobile.com>

diff --git a/tools/testing/selftests/powerpc/papr_attributes/attr_test.c b/tools/testing/selftests/powerpc/papr_attributes/attr_test.c
index 9b655be641c9..892aff137644 100644
--- a/tools/testing/selftests/powerpc/papr_attributes/attr_test.c
+++ b/tools/testing/selftests/powerpc/papr_attributes/attr_test.c
@@ -55,6 +55,21 @@ static int value_type(int id)
 	return val_type;
 }
 
+static int check_file(const char *file_name)
+{
+	FILE *f;
+	int c;
+
+	f = fopen(file_name, "r");
+	FAIL_IF(!f);
+
+	c = fgetc(f);
+	fclose(f);
+	FAIL_IF(c == EOF);
+
+	return 0;
+}
+
 static int verify_energy_info(void)
 {
 	const char *path = "/sys/firmware/papr/energy_scale_info";
@@ -71,11 +86,11 @@ static int verify_energy_info(void)
 	FAIL_IF(!S_ISDIR(s.st_mode));
 
 	dirp = opendir(path);
+	FAIL_IF(!dirp);
 
 	while ((entry = readdir(dirp)) != NULL) {
 		char file_name[64];
 		int id, attr_type;
-		FILE *f;
 
 		if (strcmp(entry->d_name, ".") == 0 ||
 		    strcmp(entry->d_name, "..") == 0)
@@ -83,28 +98,34 @@ static int verify_energy_info(void)
 
 		id = atoi(entry->d_name);
 		attr_type = value_type(id);
-		FAIL_IF(attr_type == INVALID);
+		if (attr_type == INVALID) {
+			fprintf(stderr, "[FAIL] Test FAILED on line %d\n",
+				__LINE__);
+			goto out_fail;
+		}
 
 		/* Check if the files exist and have data in them */
 		sprintf(file_name, "%s/%d/desc", path, id);
-		f = fopen(file_name, "r");
-		FAIL_IF(!f);
-		FAIL_IF(fgetc(f) == EOF);
+		if (check_file(file_name))
+			goto out_fail;
 
 		sprintf(file_name, "%s/%d/value", path, id);
-		f = fopen(file_name, "r");
-		FAIL_IF(!f);
-		FAIL_IF(fgetc(f) == EOF);
+		if (check_file(file_name))
+			goto out_fail;
 
 		if (attr_type == STR_VAL) {
 			sprintf(file_name, "%s/%d/value_desc", path, id);
-			f = fopen(file_name, "r");
-			FAIL_IF(!f);
-			FAIL_IF(fgetc(f) == EOF);
+			if (check_file(file_name))
+				goto out_fail;
 		}
 	}
 
+	closedir(dirp);
 	return 0;
+
+out_fail:
+	closedir(dirp);
+	return 1;
 }
 
 int main(void)
-- 
2.50.1.windows.1




