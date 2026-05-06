Return-Path: <linuxppc-dev+bounces-20533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73F5CD3439
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 22:23:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9qf10P7Wz2xSb;
	Thu, 07 May 2026 08:23:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778106201;
	cv=none; b=OT/6ecNS8VCio/zlE+FgUVQkEfWVgZ3upSkL1ODzxpkJ4Y8FzMIFNmC2lRLQAmWqksWqFzDpa4m3q/fOXpkEtM0Lgt1Im9BOi51tJqJodiTu40fA9esnmYJzK3uPP5K4cid5/NxFZKGWxUPRI2DC1+eTMmQUJgqN77VLFJWX7ZyHX73jINsoV9RCgbxgvSl8eyN+vd5HI+0jVtLEITpCgnxBPyXfd1zn44a/2uoRDNkREesDW9/ueSxW3EZiICnFPPtf/AM72O0Swi92bdm9coWDQ/fgXNYacI87l5oHqPmadtgA956F5Kl0Ng/0VwTQnBbEbnpzV28Mut4q9N0VIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778106201; c=relaxed/relaxed;
	bh=YKiIsHsvorfmkWjWxVhsMnyuw9niDeJiHULsuxkpGE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiZ4SybYtiwalow3UjjZAxaOHbAV9RSFmGLhBUSV/79S3CkfAE+zpHd+lPoED2pTWrMS7sUHC14/xgZgrmtXPPLrSgFLB5IS1YyfZ0oVzGUUdaopZw5y+xG4VgkG2NnyqpT1zGd0+FbK/e0FSdlq9jc3oR79nIwoMw4eJGyYGZ1zkIvT2i8AebACbIyjuippF4GLz2DvT55Hjcfzw7EEotx83USCiuVV7O6no/efhhxraKT56sBibCwG4PeYo5NQXdK099Uh3Q5bU0boUbybTOB2bT0vKgSLVkVkzDzPP+J1PqN1rD91+27Be345KS5sJIeImGJyfTfe3iD2F3h/0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kz66T/wT; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=adri.vero.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kz66T/wT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=adri.vero.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9qdz3GD4z2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 08:23:19 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-488d2079582so1555305e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778106196; x=1778710996; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKiIsHsvorfmkWjWxVhsMnyuw9niDeJiHULsuxkpGE8=;
        b=Kz66T/wTthqoc69zULxc7McuOshMtod/JP7WmP0/kseohULwn3G7HEhZKIu0dvSnVW
         b0zrWYa73ilF8GAGdMYXcZgS9AO0SYjaMdaPRTZZRzRMQfGRQWeiPxiAoJk+E8DG+iu4
         KUpHSfEstdrRgu6NbvzSu1Nx8+3AbmT3UttXUp8FMthAeCzLgqL9pRmTRBBi+SL6h4ox
         HgyX0sJzAYD4+lYpQE2OowCEQEWazn+thWuNep9TvKOW014o+wfZAHm+bB+N1C3vfRzX
         nlfmIW84+ewBOfh5T6sVzLTIyrtCFyh7DZ+wskRDPQ+5A/uXyyFxDDlhxz3GVGSUkuZa
         aZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778106196; x=1778710996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKiIsHsvorfmkWjWxVhsMnyuw9niDeJiHULsuxkpGE8=;
        b=ZW/6vKgZZp36ABM9sgnhF6UaEBhVM0EV0X2eRTdCdAavyQTaNnKIinIVWoMSA3uYY+
         QBAq89nq+nkOlV/89Gjz2TDtm9lJm/FVB8YhtDl7TGR49gNii/2rHg+KeZZMi/FldWHz
         7VaR7aKhAVgMiO7FD0a8p7G4sPSEVhmxCCHqwDRWMjoUcFn715lkWcX5iHZiMsLwxoKL
         fkLRtxJ71hAT43ZYspKfCXz5RI1jWhsfrGaqqZYQGpv+6NK0HLD/PBW/CftICdmIfeLq
         yLm1MulQwMCszJ+hoymWQSWxg40tWHh68sGJXpt9ulTzCqyhHXGjh+g0VbpIkYCBQ7o7
         JxIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9t6koQIJ6biWrbnk+a+8OqNntF+TVWLgNZZGWB8/f1iwgEyiKm2NY1lYbv0YPH4N2TkkfMeBYThbC9sOM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxrJlx0TjleSSbbWyrh2+Zogx8k/2if61/3eHCvhyt8Xz5R82j5
	xBGxxK3XuHHafHeWCDFfbdVwX3iknEwUQUhWEeyWrqpOcWOD5IqKQ7UI
X-Gm-Gg: AeBDiesnzQDs6kgajSSnJi9mCRMISxuKMuyxdQZBIvdf6LBzLcgCDZ25RPw9r7eKatf
	6B+55LNsx9lyOxkiZ4MEmblTiehgsLSKRIxa8l5tGzRSQzX7G+QRX2+Iembvs0/4YlafdefKUYk
	fLPdmIwF7qMbeswh+sADm8ievmEotQrQNfa66KJ99zYXWgzaE2r6/rqRipF9piNzzzMLxYUAk8j
	0lzpQoF6iPaKFNEEFvWG6i0Ahq6BPEDognzxv0ZliapMOJD4T30u/1IVw3XzCV44s404UhtMW5F
	6ybr85DTb7TXZzZ48xAytwNFQeqJwiTWGHoES2/bQY8xChd4iurYFET0LH9pF3qNmVQ0sP5XkqX
	LudD4TnbMIL/GeqCcTH0lJphbE8UiSjq15sOGrwY/9Pf8oO3mSKVjZdu281LGmWhg9VbMyvulRb
	9JsazMeFdtJklGuNnmuj5nKK7d43dCbilPa6bPYno6Mw2wvHopEwNv0kUZMBPJsXuL5YXxxHoUw
	Xd5a1cAcQXfW89L0QItVpao8yytkisOfWNCSUfwbvYq
X-Received: by 2002:a05:600c:a305:b0:48a:5970:2005 with SMTP id 5b1f17b1804b1-48e51e08362mr58841715e9.2.1778106195632;
        Wed, 06 May 2026 15:23:15 -0700 (PDT)
Received: from dev.homenet.telecomitalia.it (host-82-48-38-157.retail.telecomitalia.it. [82.48.38.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530d2d06sm25229295e9.16.2026.05.06.15.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:23:15 -0700 (PDT)
From: Adriano Vero <adri.vero.dev@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	sourabhjain@linux.ibm.com
Cc: npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Adriano Vero <adri.vero.dev@gmail.com>
Subject: [PATCH v3] powerpc/fadump: Add timeout to RTAS busy-wait loops
Date: Thu,  7 May 2026 00:20:23 +0200
Message-ID: <20260506222024.30352-1-adri.vero.dev@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260419065039.23495-1-adri.vero.dev@gmail.com>
References: <20260419065039.23495-1-adri.vero.dev@gmail.com>
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

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/rtas-fadump.c | 80 ++++++++++++--------
 arch/powerpc/platforms/pseries/rtas-fadump.h |  6 ++
 2 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
index eceb3289383e..3bb4ac2ab6cc 100644
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
index c109abf6befd..65fdab7b5b8d 100644
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
2.54.0


