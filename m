Return-Path: <linuxppc-dev+bounces-19384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C4DEF4EAE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 06:40:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq07w5C1Rz2yfS;
	Mon, 06 Apr 2026 16:40:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775456193;
	cv=none; b=lHd4YM4pT2PrsdqHPFDJNZ6NTzlJ9VJCwfG+KYNWt352iiKOWch7+M2vh4UflTvIwXFPDoR8ZmpnxVdmxBqaSS2JvxRnsRbmEV+AamXmqzMhrDbI/KpwmzEc7DFBxEc0KwFTGx9/nNpb/EcwDiUMyqZ3/PzU3hbG1cShFvziwHKOBkNqlEHGiP18yHpLhLoy/+kE9Fne8du96vOHLOQQhZWS2AXH7P2JZolo4W59fLP0Ss+k5WJYFeyXBr8H3LDrsDlkKxClCtb4VB23XrVmv39+lwz1j4pJHSek5ohSBrAqG6Hhboh+mTPeRSzXj5DGMLA56POFhWFobJPmw6bnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775456193; c=relaxed/relaxed;
	bh=iazOb18zH09zHtasIHRjBS4gdZV9mNmxJwOYyWl7kAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lX9VcaUFJdTXRow+5fv3VYz12JVUXOze9CnCCSFi0r7AGMt9jZzwBaAZp14Er3ZRLN3CnjIpGPGGbx7lNEtnWtpb6ZPUgLSOGyEPIGnNrBjDKLoQRa4ko45AMqW5aMQ4yighRBVzOucu1daQgD/Rjt9O1Lh+0w3+jiVOH1FcQnqQ+aSMrckNV9jxOfd6Pof3zFYRacQeMwQT+wmevL2y426giyeKYOQ3Eyx12veoXHVH0XWJ1am3uz0h2INb9w7ea1rTQbiXFw0j89748h/mS3CtfFYKhwaMinyosR0ocUuvlb0S9qA4UqKinskMV6hRqF1pAPTepnCW+ziCQkyUIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UKZnLDt6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=litaliano00.contact@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UKZnLDt6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=litaliano00.contact@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpzcH542bz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 16:16:30 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so33435235e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 23:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775456182; x=1776060982; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iazOb18zH09zHtasIHRjBS4gdZV9mNmxJwOYyWl7kAo=;
        b=UKZnLDt6DvkbaKKpMJCu/0GvEIkFQeBCW/+QrWQs36a12d8NjAw9g/eb2zUY5MIRT9
         +eE3/Ok2r0x50Q46abWoZOVbaFsUJE8WKmd3BlWOr9dbp1MQA806XuXaFMLthSV2ghEi
         7EDa2XiB3Cues+HSMiWQxpvZ65cj5bz90yC2F2xaSKXpQrQOBYfwKnhHLGNn7aNPEaYB
         wvjtqkpZLf+wDR+X4DmyiJ6yLinw6bTQfVOenC9hjuwmiQ0rclpqmtEkIHsFN2aRLuzA
         eEL7C0V0F6k5vNbugEHKEX+KLhbLEBRyz508IFePpl8JOziWqv9XIfWYQ0e2dg4xaqBD
         5vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775456182; x=1776060982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iazOb18zH09zHtasIHRjBS4gdZV9mNmxJwOYyWl7kAo=;
        b=izN2p7wmQ7PRqiRzRdoK2yli0fJvdw3+PfEUzIzbDtIpEbh9VHRLU9skkyrEBb7Pfu
         4Ljp0RSS5IYxqPHP0cTP1JCEVfeGudQOrIxLad4XnQerw6lAO6Q/NSRao16HDQPeCT+I
         CPQHuoUSvzjToSUnmXj4Tkb70+kRA6bcVoOo1b/7b9kNov5UsMDEUwgz4GN3jnRJAmkr
         l9zwHjwaDLNu1Fjhd4W6ps94gnmrzOr/oVkh7AQSSJGYzhA4DNhjKWcVe3HRy289PDOR
         XU6z9Zemv1/Dn/dLB4YPD+FQBTGaLyrgDGeh+vTM0sZUMRqFwlq0rH0IdNwaWRgN4Go2
         Ow0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5S8AdMTd+igNApgx8DkVKH0gK7g8Qg5EGJO8Q7m5nf8PMR0UFyDjIu+sJMiSux2fybMGDjsCzmQp0SEI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKB5O11Cefqb4frDtLsx6T2dZIGSHGljxWKqiT4I9VycZeudNc
	ibGsd7YEZPfqsnZhtBV1hhAZrSqcUGRMwKnmcB8RHPGFyaH0poKgcp3O
X-Gm-Gg: AeBDieuUyOqv3DFCkMH9V8+Perz5XwD76MEvjeF+af/D0eOl6EcB8H7e0Vx9xeju2vk
	x+Z9y2l71cHVmOuOyZmdoKdmy8s/QJOzLnMDt4hB7jkVjGcr/oMkRzf43I4wdiIyPLhMhEJUab1
	5XwLeY+xdtmEorb75OlZxgPTJduLAj3ClKXEXp0v69/LQHo1JbswjmO4fQ7tIuPAS4cbzKqwzJI
	P02LALXPIBbH2dKLfN1gxvZc37vY2a/29lc1gV7h0s3aqtnd8IlOFjWFulmA6cWuyqvnLV9lPG1
	mCGEfdkcG/tdZnlYUa1oLAXHIADwan27MOy9DRLGdHlBpp7HG7uOdb3jFEFof1Z3AwQ6Mucb3ph
	zpFpeN8vxP/KEtAA6L8g79aWUHo/iGylTjSGxUnhRoaLw7ktzF6+ZTx78soVU0/Zc5HtW6AhjG2
	3aRRUSu5ypDI4/uNV/MOWnIkygH5AVoGJweb0/Gs5w6YKy/uowtJnzQPACDpzYsxj8r8D109UiV
	onJCWHf2OHGss+RdWryZAJTe47qt2xTtdRciA==
X-Received: by 2002:a05:600d:8449:b0:487:1fbf:e0a1 with SMTP id 5b1f17b1804b1-488996a1e01mr127552785e9.4.1775456182266;
        Sun, 05 Apr 2026 23:16:22 -0700 (PDT)
Received: from fedora.homenet.telecomitalia.it (host-82-53-109-192.retail.telecomitalia.it. [82.53.109.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b6ff70bcsm26037455e9.14.2026.04.05.23.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 23:16:21 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Adriano Vero <litaliano00.contact@gmail.com>
Subject: [PATCH] powerpc/fadump: Add timeout to RTAS busy-wait loops
Date: Mon,  6 Apr 2026 08:15:42 +0200
Message-ID: <20260406061542.22354-1-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Track the accumulated delay in a total_wait counter and bail out with
-ETIMEDOUT if it reaches RTAS_FADUMP_MAX_WAIT_MS (60 seconds) before
firmware signals completion. This follows the bounded busy-wait pattern
used in rtas-rtc.c.

Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
---
 arch/powerpc/platforms/pseries/rtas-fadump.c | 37 ++++++++++++++------
 arch/powerpc/platforms/pseries/rtas-fadump.h |  6 ++++
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
index eceb32893..b165f165c 100644
--- a/arch/powerpc/platforms/pseries/rtas-fadump.c
+++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
@@ -181,7 +181,7 @@ static u64 rtas_fadump_get_bootmem_min(void)
 
 static int rtas_fadump_register(struct fw_dump *fadump_conf)
 {
-	unsigned int wait_time, fdm_size;
+	unsigned int wait_time, total_wait, fdm_size;
 	int rc, err = -EIO;
 
 	/*
@@ -192,15 +192,20 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
 	fdm_size = sizeof(struct rtas_fadump_section_header);
 	fdm_size += be16_to_cpu(fdm.header.dump_num_sections) * sizeof(struct rtas_fadump_section);
 
-	/* TODO: Add upper time limit for the delay */
+	total_wait = 0;
 	do {
 		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
 				NULL, FADUMP_REGISTER, &fdm, fdm_size);
 
 		wait_time = rtas_busy_delay_time(rc);
-		if (wait_time)
+		if (wait_time) {
+			if (total_wait >= RTAS_FADUMP_MAX_WAIT_MS) {
+				pr_err("Timed out waiting for firmware to register fadump\n");
+				return -ETIMEDOUT;
+			}
+			total_wait += wait_time;
 			mdelay(wait_time);
-
+		}
 	} while (wait_time);
 
 	switch (rc) {
@@ -234,18 +239,24 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
 
 static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
 {
-	unsigned int wait_time;
+	unsigned int wait_time, total_wait;
 	int rc;
 
-	/* TODO: Add upper time limit for the delay */
+	total_wait = 0;
 	do {
 		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
 				NULL, FADUMP_UNREGISTER, &fdm,
 				sizeof(struct rtas_fadump_mem_struct));
 
 		wait_time = rtas_busy_delay_time(rc);
-		if (wait_time)
+		if (wait_time) {
+			if (total_wait >= RTAS_FADUMP_MAX_WAIT_MS) {
+				pr_err("Timed out waiting for firmware to unregister fadump\n");
+				return -ETIMEDOUT;
+			}
+			total_wait += wait_time;
 			mdelay(wait_time);
+		}
 	} while (wait_time);
 
 	if (rc) {
@@ -259,18 +270,24 @@ static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
 
 static int rtas_fadump_invalidate(struct fw_dump *fadump_conf)
 {
-	unsigned int wait_time;
+	unsigned int wait_time, total_wait;
 	int rc;
 
-	/* TODO: Add upper time limit for the delay */
+	total_wait = 0;
 	do {
 		rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
 				NULL, FADUMP_INVALIDATE, fdm_active,
 				sizeof(struct rtas_fadump_mem_struct));
 
 		wait_time = rtas_busy_delay_time(rc);
-		if (wait_time)
+		if (wait_time) {
+			if (total_wait >= RTAS_FADUMP_MAX_WAIT_MS) {
+				pr_err("Timed out waiting for firmware to invalidate fadump\n");
+				return -ETIMEDOUT;
+			}
+			total_wait += wait_time;
 			mdelay(wait_time);
+		}
 	} while (wait_time);
 
 	if (rc) {
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


