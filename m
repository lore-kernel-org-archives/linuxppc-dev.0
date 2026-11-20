Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD46606A320
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R2W2aAbX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1v269VTz30Ng;
	Fri, 20 Nov 2026 15:04:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1232"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147486;
	cv=none; b=IipyNbLWPJet4qe1gWntETAr2K6lZNFWRdPJE0pop9vraYgo7YoJD7Tfv8rm5JYkNS4oa5sHGZAO9bS6wZNrMaHEvRUpoGvfrhEWdm6pILnBY9h/A3dpHFm+H+bM1Fo+gZpSkmK6/f6mVyDxYWHL4/YRBr75uK567SgbmfSl30HCgfmDEQD+lKubrH+/Lpm6AQW6POFkJplDRRrfee/GdNRgfUys+w0xmA4YpGIpRiprrdXb0O7gxRl5GUMTitK6M4VEz7AzOMl97KaRjRsnuTMAVsZORAfqMu80M0DL0Cvy2r16FqVucEVjH9J1+cExhhokNN/QM+In3zJzyYbYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147486; c=relaxed/relaxed;
	bh=A0MBPJOKvnLE5rP9NIQzyUeRKGazCi9hDA+IfnK6LUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fg+SpNubGffHtGZ6cL7i9350AwXdPUkBgRl6rgQS/Q+6htF3gAMUphAHT9Z/OE+yrlgTfP+UVBSt/c33ukvUPxBokeiuhUorhSRyZNbm66Tr58Z7cnAje5WvF5sgCUSEvZ5yBHX/VUUS+y2TfvmF+7Zv2+Fdnv6kjucIK9ElLB2ayRLBTZAQ2l7Ip4KlNUrGE11ifkFsUzPUkVH6vs1zYRjeAkJsen12SVfyxuy40h+TjqIOvJ7Xmq8KERlhryyhEJggQh2JWRfQwUpqTMGfbVl3UiHVIc+uLUYo7GIeBu59Qq3oaIPKnfKNRalLwH7hHJHs8CJS962cJMHLgRs5zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R2W2aAbX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R2W2aAbX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com [IPv6:2607:f8b0:4864:20::1232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1v21CDYz30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:46 +1100 (AEDT)
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-1a8cc11ac42so664759c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147484; x=1795752284; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0MBPJOKvnLE5rP9NIQzyUeRKGazCi9hDA+IfnK6LUo=;
        b=R2W2aAbXoEFtVhGGniI8VNfxInip/a89nccxmsGz95n3uC2tfkuH4sJThqaUaThovc
         qsHFOSBrjJyef/NXk+N5dg+mVvjV/EYBkZZMFcR4wLYVRF1656leyyge8diFlqpabpfK
         PFeeKbD7eeg6N1/19pRMkdkKpmZHISYIzJFZdjmd6iUFeHIqNa1HiSm/8A8AOsrV8cJm
         eme0v2H06k+cF4AONfa1W66E2m+z6M90NFopRhomda/V63P1KHkQnJezyjL6uYK9ReZu
         TndleoEIfD28JTgOrD/wKmKrWf7mrS/xeMLgU0FHwYwaRqrRQTsw8/S0TRKyB81hg1TM
         CNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147484; x=1795752284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0MBPJOKvnLE5rP9NIQzyUeRKGazCi9hDA+IfnK6LUo=;
        b=TaGc7a6c8ix/dBnwnujrGlE8YjJyP9JEXjBg6J+0MPXGHiNSz5IaWISgmreC2nodjC
         40eDJ245fiAns52ZCLUzNAuFHDetCJ6X/607MWM1ov399NSNE//qN5UwnjW2HaAGktzq
         xbMxxBUE41ifu9FNzWLqY2egcGTE6lTjROjxgfIO+JqH7nHNNr69IFOqhEVL89R3NtHb
         EJXKlu/5/9AM3ZDCUISUwow0DWqzEFAKJQz9KdGaH+sT3KkYXlQT2iaPB2VLp/gd8owB
         OuvbjOJOHzFGpSao1FOd9gzKLslNvrlMVTuiOB3ssZ6uSzr3RVH/vQMMoK6tle+geR7K
         45/g==
X-Gm-Message-State: APuU4Z8DPef029pHNbbIo8F5gbAgky76lbACzUO8zqmHzqJKwaXzbLQL
	yuoetXq/DiIN8rif4JaXzO1CKBMRLlcEYbx0rXskRWMD7tKS9AiyZ2YRdoii2A==
X-Gm-Gg: AZFdTZcA8rcU023jr15XiF8mgbknry0pduEOxONIhe/u12fBk7/IJYXnD1ZhAC0Ut6r
	u8K8KuYf/0O5MMsd7hME3m0Vp7MvjVpkuWO9Yhc8jrlIYbvsSHAddo9+Ao9OmIO7HYP13Jr+q3i
	dw8TXVRDaNTHiGdCHFeKcdefOPL6cv2wwLPyms7r2jZ0tN0+5VZnrQuIBb0qrjLU3axY7sN3+DZ
	SPiauPVeRZ1858AKI8VOSqDtUymGx4+KRjm7C1AXqez+QBa44BeajPJkxVfyDt6/UBdSWr4Kgrp
	EisdxK/0zNob8znr806rQNlkhyE9O3CN9Gye4msYVOpeTmI+0TUKw613q/eAXfgFokjBYh/xKOZ
	LK7ix3K1N449tCdR0FZkEqWC+/1Csw0Yv+4L88DGKUlHls+vlGDaZ96gUdQKEWxEp6OI4ka/p34
	Cm5VIdHszvtwsK0WVmWguUOleMTQhQ5iK6GK2pigzPkBgYhCAcuTr1JCrrZz+yQlSFlr7dfQXWL
	5/GPqGPU0NrNE+qgDBo7x2uB4WVhdk+cwTqj6wBrDy5J11WsK59QMM88vQ+Fq7yUG/tQBJVL092
	Bjgn2OPKCJUb97wPLNJBZ1rRpec+qBd51iU=
X-Received: by 2002:a05:7301:a0d:b0:369:fa21:ba0b with SMTP id 5a478bee46e88-38570847a85mr1610871eec.33.1795147484154;
        Thu, 19 Nov 2026 20:04:44 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:43 -0800 (PST)
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
Subject: [PATCHv3 18/19] powerpc/powernv: Rework OPAL console write to remove conditional locking
Date: Fri, 20 Nov 2026 09:33:17 +0530
Message-Id: <2dc60ffe2b5c0d7e6dba3216b4c040ec9788e6c2.1795147055.git.ritesh.list@gmail.com>
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
  opal.c:454:7: error: spinlock 'opal_write_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  opal.c:493:3: error: releasing spinlock 'opal_write_lock' that was not held [-Werror,-Wthread-safety-analysis]

This patch rework the OPAL console write function to remove this
conditional locking to fix the reported build errors while enabling
Clang context analysis. We could have marked __context_unsafe(),
but this anyways simplifies the locking a bit.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 30 ++++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1946dbdc9fa1..aea83c4be76d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -438,19 +438,13 @@ ssize_t opal_get_chars(uint32_t vtermno, u8 *buf, size_t count)
 	return 0;
 }
 
-static ssize_t __opal_put_chars(uint32_t vtermno, const u8 *data,
-				size_t total_len, bool atomic)
+static ssize_t __opal_put_chars_unlocked(uint32_t vtermno, const u8 *data,
+					 size_t total_len, bool atomic)
 {
-	unsigned long flags = 0 /* shut up gcc */;
 	ssize_t written;
 	__be64 olen;
 	s64 rc;
 
-	if (!opal.entry)
-		return -ENODEV;
-
-	if (atomic)
-		spin_lock_irqsave(&opal_write_lock, flags);
 	rc = opal_console_write_buffer_space(vtermno, &olen);
 	if (rc || be64_to_cpu(olen) < total_len) {
 		/* Closed -> drop characters */
@@ -489,10 +483,26 @@ static ssize_t __opal_put_chars(uint32_t vtermno, const u8 *data,
 	}
 
 out:
-	if (atomic)
+	return written;
+}
+
+static ssize_t __opal_put_chars(uint32_t vtermno, const u8 *data,
+				size_t total_len, bool atomic)
+{
+	unsigned long flags = 0;
+	ssize_t written;
+
+	if (!opal.entry)
+		return -ENODEV;
+
+	if (atomic) {
+		spin_lock_irqsave(&opal_write_lock, flags);
+		written = __opal_put_chars_unlocked(vtermno, data, total_len, true);
 		spin_unlock_irqrestore(&opal_write_lock, flags);
+		return written;
+	}
 
-	return written;
+	return __opal_put_chars_unlocked(vtermno, data, total_len, false);
 }
 
 ssize_t opal_put_chars(uint32_t vtermno, const u8 *data, size_t total_len)
-- 
2.39.5


