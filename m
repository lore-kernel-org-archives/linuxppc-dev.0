Return-Path: <linuxppc-dev+bounces-19842-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92474EA7196
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Apr 2026 12:40:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fz7W440VVz2yqT;
	Sun, 19 Apr 2026 22:40:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776583004;
	cv=none; b=JZBkSotvNGACThBcE7kFsOkWJvvbVzwZ2GhhwqqInu+dMqGpSW6llDdEE6MtoyyHIzh83OPXFDcU0NJP3sg198UowEqxHwrDqf12KC9U8mMcSQ/y9E3hmSHOCN4RE2utIGiyoArvihN0zsXyhdPji63yw2OxdysaOlCm3+gypNZrQbVaa5jKEvKl/Jos4/Ax1b8YD9VfPcu5iiIJ0Xt14kKhFWqWFpYuZHGmImgGkWBNrU2QiLxDxayKh+Ty9HOCLBN+VzRowlzR5ep7UECWwZ/L/Ek2iWnZnm6htCgvXhI5LLzoNkDJQcpk9Lpz95THfPupT/o3CSZNAu13WdUQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776583004; c=relaxed/relaxed;
	bh=e633J0iM4T36U0Ykk5jiq+vFzcuBQkCCmEghwzPCf5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onSQk4PLozH3UMIy+jJkmmrEHFntHGb4RvqW3uFsLvWzuJudI+7NGXuHYDGArY33ryjlDG13kw95veinNhGQi5qEUMeM7puLHGgnjUeLd6sPQkpccj0OzAMdOCnPQ82SEE0iFDBJgMuBOizHdnc6ENgEQ/Ar5SXget6beuMkEtC4kvAtVwol2UiDaiaW+hJZdy+5T3SpADOqD+UzieVabXQXS/HGo6G48QxlukEGBlMMZxXJpKEGM8GKqmG1UHL7Ukt+9Ebsp6by88bSrtzu4GvKC+leCLisRAY7+SLei1QOvjI/5murkKuLDNW8i+moCeO1uZxvppRnSNZbvOjlug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FMT/txXI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=adri.vero.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FMT/txXI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=adri.vero.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fz0Kk73d0z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2026 17:16:42 +1000 (AEST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so2189709f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2026 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776582999; x=1777187799; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e633J0iM4T36U0Ykk5jiq+vFzcuBQkCCmEghwzPCf5A=;
        b=FMT/txXIJv8Ccvzw017IqnNJ2Vo5KLE+DDbvp834RNMO5uVq6Jh7IZ+PQPXu+FXudV
         /3xJ2r9Zg6WcEPgECKpj5TsiD9Y4AvZFu9FpzTEBlutKxWdOr0Gp2UYGHxb7fwMvTzMx
         Xubb3YyvD1ySFXL8x8bSPfkUdP25Q69iwPySlepAtjI+cd1EGFw7bSljZB6KDj5v2+f/
         d3Eml4N01djQMH76/ZoWx18p15eUOAsC74Iwm4FtG72cFX7w3P+tCoR4grc7eUsB1ZpG
         qJg/S14MWGPIYBtQsoExB46rFY0Kb9Z2IOjVuLFpJMOzaZsFVDy/E9n0E/aCaIbHjPFS
         msmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776582999; x=1777187799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e633J0iM4T36U0Ykk5jiq+vFzcuBQkCCmEghwzPCf5A=;
        b=QvAlzNebWAo59LpmnYOhSSjG9dkS9Hn0y6xyU6LiJLKAF9XGnE4XaRxaNIgQtacuOF
         ak4tjmx7iB3WaiIE3aHocV9eBmPRIkDjl2YeVUyjRug3GZuunbVUyNvqOvUZ35sndc4R
         nP/KfvzuDAgdFOkVVsiuya/V2tVd+4+hLRp+cAuwXINb4GeCdhuRS4UFKRhznER8HjzG
         SgNLR1/h1xEStxjfUCCKpEkUEP6QFScJBmrSy3i4/OBd7JJhnj7XljXqawHLtU/CJECZ
         W+MpX4uf3rRqIoqKuHxp/jg4rTqbKIW+b3PqwGhlb7MTH+u035QJxdZhBM+rvJ/z1DpO
         OtZA==
X-Forwarded-Encrypted: i=1; AFNElJ8jZCg46+JoRR3nKb8OvpipQFGnYzAs3qg8J3NiCr7EZDNFm9xP5TEsIimkXqj/TyL0dlPIiQLZAfS5+s4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx77Bk/ooTV3fE3PpEbRvGbOTME8jAE+14IkfCogfVeUW1lsQ5O
	ACjyqNwqyYbovliBTfGW0DmcUd4FZfs/4w0Lap/6kijmdPcXXcnEDbWFMbntPGOnsRw=
X-Gm-Gg: AeBDiev0FNHbFoKxS7k6i03i532nkC4eEWZhp5Fmi3fdpbI/5CJIA5p8ThoNAO5Rw60
	WEzirEjuQzPQseKJvFe6zr4l68NGp3BlhFSAjwdJBWhTf3KpOwZOV+jBcrUO51rQCEGjtKPagLJ
	usxzkSbVmeVB/HoI7aqbUFyx/1vUJewcZ1WAVpKfHv98GEQTUSMWlAQFw0IPBZBLt1FU8bSyUlO
	2WuZS97ldebIIVKT36sQMCmTpgryNYFV2baTPqmdlxjou1gGJaa72WNPnxzNRNnnYrl2oPeDkQi
	d84nX9tdGINZ6Mq7/pSysyqmtt/Q/hZYlbHvauyna+cSrnaXmRG/gqSjcdtN1m0yQaEHrps1s+3
	Li7geowJl3XLpQux4qAWzvoZ143m4WLVHKj6KunD/yEES1R3KtNYYwMHH9adGpXGtCLtHub9B2B
	m21AEv/iyAYWP84h/gPRe0jKA3FEThdpVkVPMWSAxsbJ4zC9n1FQgZIQ7SlwmSMLVus1q4mENf/
	LIsr9HDE+M7ethquHNc9svSNk569CS7rKPE/T/VRr9lNuOLWfo5bakfmaFwvwqDiRS3
X-Received: by 2002:a05:6000:40df:b0:43d:7af0:3a93 with SMTP id ffacd0b85a97d-43fe3e14f29mr13287642f8f.34.1776582998733;
        Sun, 19 Apr 2026 00:16:38 -0700 (PDT)
Received: from fedora.homenet.telecomitalia.it (host-80-117-127-126.pool80117.interbusiness.it. [80.117.127.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0f31sm18865676f8f.12.2026.04.19.00.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 00:16:38 -0700 (PDT)
From: Adriano Vero <adri.vero.dev@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	sourabhjain@linux.ibm.com
Cc: npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Adriano Vero <adri.vero.dev@gmail.com>
Subject: [PATCH v2] powerpc/fadump: Add timeout to RTAS busy-wait loops
Date: Sun, 19 Apr 2026 08:50:39 +0200
Message-ID: <20260419065039.23495-1-adri.vero.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406061542.22354-1-litaliano00.contact@gmail.com>
References: <20260406061542.22354-1-litaliano00.contact@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ibm,configure-kernel-dump RTAS call sites in
rtas_fadump_register(), rtas_fadump_unregister(), and
rtas_fadump_invalidate() polled indefinitely while firmware returned
a busy status. A misbehaving or hung firmware could stall these paths
forever, blocking fadump registration at boot or preventing clean
teardown.

Introduce rtas_fadump_call(), a helper that wraps the common
busy-wait pattern shared by all three sites. The helper accumulates
the total delay and returns -ETIMEDOUT if firmware keeps returning a
busy status beyond RTAS_FADUMP_MAX_WAIT_MS (60 seconds). A pr_debug()
message is emitted on each busy iteration to aid diagnosis when the
timeout is hit.

Signed-off-by: Adriano Vero <adri.vero.dev@gmail.com>
---
 arch/powerpc/platforms/pseries/rtas-fadump.c | 80 ++++++++++++--------
 arch/powerpc/platforms/pseries/rtas-fadump.h |  6 ++
 2 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
index eceb32893..3bb4ac2ab 100644
--- a/arch/powerpc/platforms/pseries/rtas-fadump.c
+++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
@@ -179,9 +179,42 @@ static u64 rtas_fadump_get_bootmem_min(void)
 	return RTAS_FADUMP_MIN_BOOT_MEM;
 }
 
+/*
+ * Helper to make an ibm,configure-kernel-dump RTAS call with a bounded
+ * busy-wait loop. Returns the RTAS return code on completion, or
+ * -ETIMEDOUT if firmware keeps returning a busy status beyond
+ * RTAS_FADUMP_MAX_WAIT_MS milliseconds.
+ */
+static int rtas_fadump_call(struct fw_dump *fadump_conf, int operation,
+			    void *fdm_ptr, unsigned int fdm_size,
+			    const char *op_name)
+{
+	unsigned int wait_time, total_wait = 0;
+	int rc;
+
+	do {
+		rc = rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
+			       NULL, operation, fdm_ptr, fdm_size);
+		wait_time = rtas_busy_delay_time(rc);
+		if (wait_time) {
+			pr_debug("Firmware busy during fadump %s, waiting %ums (total %ums)\n",
+				 op_name, wait_time, total_wait);
+			if (total_wait >= RTAS_FADUMP_MAX_WAIT_MS) {
+				pr_err("Timed out waiting for firmware to complete fadump %s\n",
+				       op_name);
+				return -ETIMEDOUT;
+			}
+			total_wait += wait_time;
+			mdelay(wait_time);
+		}
+	} while (wait_time);
+
+	return rc;
+}
+
 static int rtas_fadump_register(struct fw_dump *fadump_conf)
 {
-	unsigned int wait_time, fdm_size;
+	unsigned int fdm_size;
 	int rc, err = -EIO;
 
 	/*
@@ -192,16 +225,10 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
 	fdm_size = sizeof(struct rtas_fadump_section_header);
 	fdm_size += be16_to_cpu(fdm.header.dump_num_sections) * sizeof(struct rtas_fadump_section);
 
-	/* TODO: Add upper time limit for the delay */
-	do {
-		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
-				NULL, FADUMP_REGISTER, &fdm, fdm_size);
-
-		wait_time = rtas_busy_delay_time(rc);
-		if (wait_time)
-			mdelay(wait_time);
-
-	} while (wait_time);
+	rc = rtas_fadump_call(fadump_conf, FADUMP_REGISTER, &fdm, fdm_size,
+			      "register");
+	if (rc == -ETIMEDOUT)
+		return -ETIMEDOUT;
 
 	switch (rc) {
 	case 0:
@@ -234,19 +261,12 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
 
 static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
 {
-	unsigned int wait_time;
 	int rc;
 
-	/* TODO: Add upper time limit for the delay */
-	do {
-		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
-				NULL, FADUMP_UNREGISTER, &fdm,
-				sizeof(struct rtas_fadump_mem_struct));
-
-		wait_time = rtas_busy_delay_time(rc);
-		if (wait_time)
-			mdelay(wait_time);
-	} while (wait_time);
+	rc = rtas_fadump_call(fadump_conf, FADUMP_UNREGISTER, &fdm,
+			      sizeof(struct rtas_fadump_mem_struct), "unregister");
+	if (rc == -ETIMEDOUT)
+		return -ETIMEDOUT;
 
 	if (rc) {
 		pr_err("Failed to un-register - unexpected error(%d).\n", rc);
@@ -259,19 +279,13 @@ static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
 
 static int rtas_fadump_invalidate(struct fw_dump *fadump_conf)
 {
-	unsigned int wait_time;
 	int rc;
 
-	/* TODO: Add upper time limit for the delay */
-	do {
-		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
-				NULL, FADUMP_INVALIDATE, fdm_active,
-				sizeof(struct rtas_fadump_mem_struct));
-
-		wait_time = rtas_busy_delay_time(rc);
-		if (wait_time)
-			mdelay(wait_time);
-	} while (wait_time);
+	rc = rtas_fadump_call(fadump_conf, FADUMP_INVALIDATE,
+			      (void *)fdm_active,
+			      sizeof(struct rtas_fadump_mem_struct), "invalidate");
+	if (rc == -ETIMEDOUT)
+		return -ETIMEDOUT;
 
 	if (rc) {
 		pr_err("Failed to invalidate - unexpected error (%d).\n", rc);
diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.h b/arch/powerpc/platforms/pseries/rtas-fadump.h
index c109abf6b..65fdab7b5 100644
--- a/arch/powerpc/platforms/pseries/rtas-fadump.h
+++ b/arch/powerpc/platforms/pseries/rtas-fadump.h
@@ -41,6 +41,12 @@
 #define MAX_SECTIONS				10
 #define RTAS_FADUMP_MAX_BOOT_MEM_REGS		7
 
+/*
+ * Maximum time to wait for firmware to respond to an
+ * ibm,configure-kernel-dump RTAS call before giving up.
+ */
+#define RTAS_FADUMP_MAX_WAIT_MS			60000U
+
 /* Kernel Dump section info */
 struct rtas_fadump_section {
 	__be32	request_flag;
-- 
2.53.0


