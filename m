Return-Path: <linuxppc-dev+bounces-1680-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7584DCF6495
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Sep 2024 01:28:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XH3Nk3TvCz2xHP;
	Mon, 30 Sep 2024 11:28:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727659685;
	cv=none; b=ZSLC1SNdkIr7BkkEQ55SetuQK/z6aJ60iB3LJ2u8bnUjlpxTZXoxf72X3+OjZx1vyA4cCks2SF2KfnQNfwj9UCKAQh9pXHcX1BPcfbjz7/LcY5PSZE+xsnT+7Ycysuosx3coTarQg4zk54qY1TczqM8TfRY7I7A+TJJgREcF+9XjiH4y3nj31W0pJspErEXIpcyliJJzG23RpMv5AxCGhZsmpO6Fivd0Li7njj2pcUrtyUWmtNj0MKDPwXDY0DEF1nnxI4QrcDZRYy9efBmajS6UmhmyXcer0zXZVPbznS7FwXEBKPtRKh1aQCO7mtMGGauaLufUUQh9agnX7hMWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727659685; c=relaxed/relaxed;
	bh=leLYvnPd4QPoTPyi+SKUjML8oL1BTNW8rGk+9Y7APic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H3Adf8P+BQ662IgUiOVbvxDhlLjuYrXYcJHKO7Tiv8VytrOcEITZZNeFPfaA4bjO8FtuHOmlrpCZXJxl5zwzOwM/lCaD1Q+RucpB+OdPvaKgaUmnbWSbFwU9Ruzy3eeKysKrmRIbzD/ZmrY8PIgE+JO7l/6ooKHyti4tdvKZdDMcl/TM6Gh68+QudvHWl+4FHfkWz8cfkAF/NFNkuGaNlw5tVpqv3KOG1yTaMsC2xjXeSClaahZk0TLm3VmNeV7ovcR9SMuBylAt9tu+mA5/wHnhmHursjzUMuqS+tCWalSXd4hDnaJxlhfRaW9x3YRfYCPTABKc0ShPhzaZfW91dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass (client-ip=111.22.67.139; helo=cmccmta2.chinamobile.com; envelope-from=zhangjiao2@cmss.chinamobile.com; receiver=lists.ozlabs.org) smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmss.chinamobile.com (client-ip=111.22.67.139; helo=cmccmta2.chinamobile.com; envelope-from=zhangjiao2@cmss.chinamobile.com; receiver=lists.ozlabs.org)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XH3Nh4pWRz2xFt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2024 11:28:03 +1000 (AEST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566f9fe9d3ec-b33f2;
	Mon, 30 Sep 2024 09:27:59 +0800 (CST)
X-RM-TRANSID:2ee566f9fe9d3ec-b33f2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866f9fe9e252-c65b7;
	Mon, 30 Sep 2024 09:27:59 +0800 (CST)
X-RM-TRANSID:2ee866f9fe9e252-c65b7
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: ritesh.list@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au,
	shuah@kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH v2] selftests/powerpc: Remove the path after initialization.
Date: Mon, 30 Sep 2024 09:27:57 +0800
Message-Id: <20240930012757.2395-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

If there were no anamolies noted, then we can
simply remove the log file and return.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
v1->v2:
	Remove the path after initialization.

 tools/testing/selftests/powerpc/mm/tlbie_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
index 48344a74b212..35f0098399cc 100644
--- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
+++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
@@ -313,16 +313,16 @@ static inline void end_verification_log(unsigned int tid, unsigned nr_anamolies)
 
 	fclose(f);
 
-	if (nr_anamolies == 0) {
-		remove(path);
-		return;
-	}
-
 	sprintf(logfile, logfilename, tid);
 	strcpy(path, logdir);
 	strcat(path, separator);
 	strcat(path, logfile);
 
+	if (nr_anamolies == 0) {
+		remove(path);
+		return;
+	}
+
 	printf("Thread %02d chunk has %d corrupted words. For details check %s\n",
 		tid, nr_anamolies, path);
 }
-- 
2.33.0




