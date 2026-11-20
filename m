Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD59606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V/l0+Vg6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1tp5GMwz30FP;
	Fri, 20 Nov 2026 15:04:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147474;
	cv=none; b=eDWNptdNHDugLbq6/U06Pp5juYOnHw6/AIHoZqXz6Wk2oJUTTExYFKImon3jgVkRYgF+fs2/VcEvpopsEvMmq9qiDi9EXtgor6JE2hDCg1TbWZJYng/xJllIyPXPqbZ8Gxm0ibmZ7LQaLz6koo35uY+T66gxiRRYzI/YTepaKEq9uqcOe75iQSlveIBiyDV5vyAn8ob1Ftx9YSJwHoIaqT28qRoIGEmwsEKndBHW12jmwGsr6x0/7AOfWMYPBzmmVXd+jfdBm6KAQ8uUMbnOCpJxyI/ciF1wn16E51PsAVohZtEYNS0iTdWOB4a74P91RKfjNhU/RXFiVHZZs3I3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147474; c=relaxed/relaxed;
	bh=Yek7TewnI2aK5YoR43fTNF1BZ5xqsmq3IxR2HR2rn7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8VpQ1apJ2OkGTFacin5ef9bcpYl0bPoauKQ0fwQeBMJs78XPRXBWSH4yA6DnLUJeThuv+bVrkUpxOVMa42GuP4DZMMCiFycys119c8jONChYS8XXp982V7BqUoR++rIvN77RdxVZEU5q7Pdsea4IhD1kM7I8wi2ro857elVl5latEZHiNlHGFbOXgM6kOGNlItJtnyr/Z7fE+IdeLiDpg8K8akJlmz51aXnIOGB7tyZ5Z1GXDRc6xPM2/hqPEb+0E9ZAnVV79fMFT3yAE9bj7Ly8xtMlRoRjPaaUL1JnBlkvMRTuLAcHWrDdRjbLEyp02H4sL4uV3sQraQA38acTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V/l0+Vg6; dkim-atps=neutral; spf=pass (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V/l0+Vg6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tp1mt4z30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:34 +1100 (AEDT)
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-382ecd5cf2cso464030eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147472; x=1795752272; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yek7TewnI2aK5YoR43fTNF1BZ5xqsmq3IxR2HR2rn7Y=;
        b=V/l0+Vg6LVvxcNpeOOkI9FzngeFOLywGcFX2RQWAbJF+38BpxHK3RPytLt/eiVJIux
         SVsTTfq9sEWpYxG10Y6q/+T+eWzY6udDy5agjt8W+AaLjv8A3dD9kjYYQPqnSThTiVAn
         G9JP+tWYqYSsehFzEiVchLXjIsyQyqc2HGN1Z9w5Tq3AI7b10RKJEoKgGER3K1dMUCKm
         w13zef5eCPOr9KAWxPFvbrLdGkAihSGk33/n1GNMIpDRos9L/768vsj2hYVcUo8+DdUO
         STgXJhjuNEEwzmFGSEzAp8ws16ocQxCpIcBRPY7EV586xT90qKJoM3ASoMCsdxP8RMQI
         2MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147472; x=1795752272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yek7TewnI2aK5YoR43fTNF1BZ5xqsmq3IxR2HR2rn7Y=;
        b=njyLIWUD+U+oiI3N9SvWgmMCqbO8iWCD2INzVu6dwXPwwwFAs0Skbcu364FPMDzif8
         cozOyZZsi+xoaWSNxzOwb+SVaRXyGK2hUhmKnCPf8aaFjihuxqkFl1ZJeoiohY314Yby
         KaQqADhkszifyqEIQDi7/2DWYP5w/u/filwGYl41Nmamw4F88xexw570/6Qn3yrgY2mD
         tF7GXNmHOnw0dZ/XjK00jpF4AcrWslk8NZJKeIvZVrewdJdIXTuT2qw/+K+Py3cDSnsM
         rEiOFxcbssr454QMReR4akmJArE2XjrBdOWkJwkllNvmygy5MhTbVj9LNXFjMbgpNOLh
         G3bw==
X-Gm-Message-State: APuU4Z/UWF6XqpxLcSHQPujVeDlnvJ5qnkXGV7NERT+WYWG0U3tJAlQs
	jvtuppPpQFrrVHf7mtTJKGAmN6Qh9haOUxWAQP3JqJc2/JSDVurB1mwyO1jfpg==
X-Gm-Gg: AZFdTZdKa0eVsrlwgZfuqdfGORs8QDhojPmoUPEQHCJykS8dF82GHui5WM7H2jwiIgD
	7XIzri3OpM4I30WondlQzTtP7TDfjYwtQ7zkjaQeEhGgzm9MOQbPIxi8mBOgjntSmqzpIuaZbAK
	IMXDIsbCN647r5qJ4HT22m0yi6k2usFHN3Dphp/52LywjoqmAS3M/A04zTwX97Pxqc4+F5ay7lh
	pPjgj8uTVPO7yhI5SDP5pIqusBnCwB3ahnHbGRaKYPaPCyxehRTB9lJnbX0e3ewQOkdAnslPJNf
	GC7ejxpovMCmW26IhsM2hCQS8hpQoiU7ulEyjce2IE2qI8+gDrcNoOto5cNq1mhIxvk43bfh285
	FpgjI7ZLMYp+78iDVL3/MHReIg4dl+sJquCIvdVJu6UawVPSn8d3FzTa3JkbhNQJA+VlOtcXgkS
	d29Zs3qOS0v2Zk5DjYNNsyThyVnhZNA0nnK+MveXnk6pa/MTzN/ACAeKWRlIF3iuy92FOhT1W8+
	6oD0mZxG9UIla7E4D5Q/PLu7Qx+O2+mJ3HRAAFAM2joISQASFvtZuUOI9amVkHpgG/9vTQ7sod0
	+U1L8k7BI7Heno5N9CpZH5EC69zzJRM7Ow==
X-Received: by 2002:a05:7301:1403:b0:385:5297:573 with SMTP id 5a478bee46e88-3856f25fae8mr1480843eec.4.1795147471843;
        Thu, 19 Nov 2026 20:04:31 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:31 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 15/19] powerpc/pseries: Annotate the DTL debugfs read lock context
Date: Fri, 20 Nov 2026 09:33:14 +0530
Message-Id: <b4efabdcaf62c35b3fa0ffbd93aadef11e43479b.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang's context analysis reports:
  dtl.c: error: rw_semaphore 'dtl_access_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  dtl.c: error: releasing rw_semaphore 'dtl_access_lock' that was not held [-Werror,-Wthread-safety-analysis]

Add the necessary annotations to
	dtl_{enable|disable}(), dtl_file{open|release}(),
to fix these errors for enabling Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/dtl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index f293588b8c7b..18c597210103 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -177,7 +177,12 @@ static u64 dtl_current_index(struct dtl *dtl)
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
+/*
+ * On success the read lock stays held until dtl_disable(). That covers
+ * the whole time the debugfs file is open.
+ */
 static int dtl_enable(struct dtl *dtl)
+		__cond_acquires_shared(0, &dtl_access_lock)
 {
 	long int n_entries;
 	long int rc;
@@ -225,6 +230,7 @@ static int dtl_enable(struct dtl *dtl)
 }
 
 static void dtl_disable(struct dtl *dtl)
+		__releases_shared(&dtl_access_lock)
 {
 	spin_lock(&dtl->lock);
 	dtl_stop(dtl);
@@ -238,6 +244,7 @@ static void dtl_disable(struct dtl *dtl)
 /* file interface */
 
 static int dtl_file_open(struct inode *inode, struct file *filp)
+		__cond_acquires_shared(0, &dtl_access_lock)
 {
 	struct dtl *dtl = inode->i_private;
 	int rc;
@@ -251,6 +258,7 @@ static int dtl_file_open(struct inode *inode, struct file *filp)
 }
 
 static int dtl_file_release(struct inode *inode, struct file *filp)
+		__releases_shared(&dtl_access_lock)
 {
 	struct dtl *dtl = inode->i_private;
 	dtl_disable(dtl);
-- 
2.39.5


