Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE1606A337
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n17v4hr4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPPS07QNz2yVB;
	Thu, 19 Nov 2026 14:40:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059627;
	cv=none; b=Nvq9JAivZdlPNHrXwB+RQJj3pxDuPzBdOQb5gGfTCYDY7sWkfZrfj4zH+l9ZmNG4smT1rPs8yXqoUFRIHB8ifT2dA4OeSF6vr2L924tMIKDhq787hmo4C8qpYZPMaIfD1hkBt013D1MRFL4CNWq6tqzKacH07qqG74nVskuncTDxRGHRwQ5qMX9X2bJWHZmAJOq91tBH9Xl55E89PbeAqWje8tcsFELzr+JOsxXBX/86pK+UKm+dryJRIgk8WpolrL8irB2o/iYj6kPA1oaS5RG/QJo0RZGWO18rkT1ADvED1vt14ClHTAN6KmxIqltu5CbFh054XDGBx8NBpfpMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059627; c=relaxed/relaxed;
	bh=Yek7TewnI2aK5YoR43fTNF1BZ5xqsmq3IxR2HR2rn7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbV6UW9A2iEHSMOw3coGzsAlO+a+2TXmPVVqrkS9tqIgi1oSCL/Jk1OeBbi+NG25zk08xw3MTeJIwI/L7uOO2EO8GoSjbi6daA44IKwALIQutuABTkGujmLYwydzFiOcik9WojtdbiZDwnOYj5o/jtPfMfUNW/QPvoQmemhAVXjjv8P9rB3/q6vGgyDDEd+o54iinG3hEYnLJCnjby3vawnrXBK6ZxdQ7VH9JKZUUo82IQWRtQjOVTslQjqsZMhBTwuFuTWjgihSMEiCBt4b3N+miBW4yyp0oZ57otmnJ+OKh3Sl51If/sYlYQ/EnXP9pRVx9A72S+8lqMfrE6E5sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n17v4hr4; dkim-atps=neutral; spf=pass (client-ip=74.125.82.179; helo=mail-dy1-f179.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n17v4hr4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.179; helo=mail-dy1-f179.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPPR2WGVz2yR1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:27 +1100 (AEDT)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so4767457eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059625; x=1795664425; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yek7TewnI2aK5YoR43fTNF1BZ5xqsmq3IxR2HR2rn7Y=;
        b=n17v4hr4zZc7tDLiD7O6xNZBp2yOrju47s3hM1Ui2rXdBiKawupkokWRky4trh/meI
         eg0BRb9YJbjrIjVwyUFpgjk3oCwi/5/b6ZghHeMtiusfDK1fJS11jlSPTGbOjS+zK+tg
         XtOOhlxWhg/pZQeZRj1jkibC96IyN0gdtvBLAsKIlicIgtLLpTPKsky7osz3/dLnu3yl
         N8A0RaTkfdVIHDT2hAL9WLw14JhHdTyB3cIzKIRDdc/DpWzYc7P7Pn3f6NZOwBlOHQfa
         2COVxb0n7MRWz5qnOvGyXRObynGAoCYikeVpQpFfmE8mK1VE9R2u4MqDcLeE2hbjxDQ3
         9WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059625; x=1795664425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yek7TewnI2aK5YoR43fTNF1BZ5xqsmq3IxR2HR2rn7Y=;
        b=zx/9PuEXXx4Gt0q2ZtG0OuwlqD4tC5Ywz/dpc8Om621LkafE2tFZL2Rn2/+f9Tv288
         WyJfea80st6fRuvw0C08Zlg7IWqZli9wDM4OGTuVO9ww6V2khZOe10bVznuboyATXJ7a
         9yWKJ92QYAU8jZCweG/vv/J1TrlOG9bUDfSiS6yAC43cMt1dG0cZHnI5ZVR33u7i1E+J
         7usxGTfel2NQzS8gzWVEwfHrpsKtG3SdCdM+SSWlw2Xf9LPRCaewY/VdS0dD8cLYCqB1
         MQI3xy4gHzSxp6Pxi/Pdwmri6pYfWrgnvXWkrqKKFSSXkMYNp+pZ7h8/M6BMnjlNBVP4
         VyRA==
X-Gm-Message-State: APuU4Z9LCdCcdFNz70fmMO4EXxH98X8fH7mFn4HiJpgEme7xsCVEzxtz
	6L9A671RtAStSi2yHLk+oLh5lBz4JOgAAHY/mXYmAFxLLleuxVwUJ0bt47x9GQ==
X-Gm-Gg: AZFdTZefG9cWKr4QNEK8YUVFUUFbOBkuZz8kklW1jL+eiKx4FDCi/l5ALCk67GQFSaL
	sCBq2MFuCzE24to9tLnhulbhUPnvBlpd+xOAvsN3RLOdKZH3LW4mBWB9UvhfKeZXfBlrP8yCQfy
	yAmqcBFmq0hnbLs7EIphtLziCpey3ZYDLCARo16wwGVHtMt6AFBOWJokvgw2peT1zRuBFiZpEVd
	Amkwl+mHScPIlHT/uH47iHzr8E0IEWNUVnHPxN+L4Ga6noLe6nckGtjkjj/FgeceKiqVuEh2+xY
	O9pTon4GTK/Hq1FrLLhWgYSkjqkHdV/GhmPfyDyynp31MVmnqedVX+lMJAQWFtN3RR8TYsHlECx
	6kulHXuRGhF6aUswZ9IYGFGNeitUwiFulie7O8oJkdRqn3IQeuJ1YWx7WnDLSCNs56MifnV7vbV
	BVELSyFI0QLF82PmbOW+pZTRegyvEBE7qvgE7mJqYaVLFhfCkOef6hoewnLf9m0KXOy/vmereHu
	Ek1QK88EtYEU9tgU3nlJIL2X36y1D6Z2SQHKC2LIDIcJoQ9jhc2Ai6CRNBQKmk+pMwSrmr4veol
	vbRCDa1DpcQoSvFMOAokp8iGN7gfovCKmYA=
X-Received: by 2002:a05:7300:fe09:b0:382:4c1e:1c1a with SMTP id 5a478bee46e88-3828151fe38mr4027686eec.40.1795059624746;
        Wed, 18 Nov 2026 19:40:24 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:24 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 14/18] powerpc/pseries: Annotate the DTL debugfs read lock context
Date: Thu, 19 Nov 2026 09:09:09 +0530
Message-Id: <6d09c4ca6a515ca5daab5e45695e63de0040ceee.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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


