Return-Path: <linuxppc-dev+bounces-28318-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D1FC9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:35:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6RS4SGVz30WT;
	Mon, 28 Sep 2026 00:35:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519716;
	cv=none; b=oHqBJo4AaFFL5AZWAG2NVI2EqMtISQCmzmgU8knKwsFpRevTFmMqnScvOwMAEQ9pJawVpC6O4RlwJJjn3nFJRM7PMyb2x9MNgG+4mnQl4jc5f5qLX+khLTfC45UHGtDvo/6K+8oHXYjhEKQSLXxvyjyU3a/CjTFq9kdsZt6nZOqfduQY9z8gWVU/B2eCbdMjWAvoH2UGaQhD692MDRkIyocIaPJZHLjyWuz5IXfngvAugftyJmrO3cnumbUwzL+TbzgQ26lkAXBG0z1BQv9L+r2/OR6XaFMzQTyYqzDloDgjDKYb5zgQVVXFYy6edN0v0LADRpXBp4TzeFOpvGJAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519716; c=relaxed/relaxed;
	bh=OEeeKd8/7R6Ji2+yPy0bODVrPI/c25RCAh5o8xRTnOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LcoQidRWfGIFWb1XN9JL9aTSv7LmIyH2UXUfLesXU4y+r3W6hSh4Og38pQ2VjTwdDqA819tyjRRcLhu/Zien47ImcJDhoAt5I0I4hdgw+HtDQnYDzpwV3P9ftNBmt5hi9MoTxoecx9uh90RMSveEuO/T3Sk31zbQ9Qmhlb1qudnHdqL+ArnVnzKipuAo0Ts35hhziEYmEk7pj/45k++AlJNcaT5vd/fRdurjQbQJAsa0yi0BgJpe20KdoH1Tv/eqK0DZjLVO+q+Z3g9d5Hx9qhmuZPiAbTYhnplxNb13BVwwK5vmP9nzTYa3n6mO8bQorWmeqd9biLGbUQ07B1rfAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T1DYPsKf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T1DYPsKf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0d.google.com (mail-dy2-x0d.google.com [IPv6:2607:f8b0:4864:36::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6RR5X20z2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:35:15 +1000 (AEST)
Received: by mail-dy2-x0d.google.com with SMTP id 5a478bee46e88-34346932d93so720852eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519713; x=1791124513; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEeeKd8/7R6Ji2+yPy0bODVrPI/c25RCAh5o8xRTnOk=;
        b=T1DYPsKfrnPDg1d9V7XYgsy3PjLO6Kzf8LL7ja0Fh7ScVv0g3o+qFc788SyrOMkHFo
         c831w5fabDhAmK4eiYENI4BSC7locb5Hs9gBhgaL9rzrzGcX930QUOVeD2SncNHj2IuN
         FJ5+frJvY1IiATFCtJaiI6H1LlUCeHPXFWSXgdi8H96uN63E+qIcxif3LG8jqGuoRP9/
         GKAxo/M+ZHaHlk9wyb+i+cZ07BgdvmgSevA8L8qhpn/r8tHXfkupCI50M3hDxeNy+0fV
         CEODPrYycn6YRImYYw1IlMVPL1ZuYSoKej1ONS7I4E54RvBhxtve3ny5XVtoLdTlG9/y
         UDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519713; x=1791124513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OEeeKd8/7R6Ji2+yPy0bODVrPI/c25RCAh5o8xRTnOk=;
        b=L+8RrX6rca9d62+F9aAqLrlEbkRdzitbvz3rkOOnvhXzG5J0aEVRhCaMaCf3R4pKqB
         T3CCqM3KYpT8sRK59wPlC+mCEsvXlVJ+LHHNJUrvhYBfqtaigB8K870PXU6f8BI6gUm7
         OrlrrFB1G0zllJcQLzP/Sc7Xr87fHTp0tRMicXduckfMHIgppMCQIqn6nSOWKVdzRmCY
         +/qjSba16mEvNkmzTVXIAIw6713/4M8BntdfmzhXGLVJjZ/rhNjrRnMhMZIsjHRQDSt/
         qvj/Z7nMsF4oy1WFHEkGqeOh6RwTyJlZECqHnG240JhyQpG2dZh/FFJGD1FHZSmMHHUN
         ZtNg==
X-Gm-Message-State: AFq9FYLqbXblzfxiKhV0/ppdNsnfRWVFpnywTu+TrnNLD6jdbgKYkGYh
	WnmZQ3yhEEF41EC2e2CcHhZcqqUmNlBsx0zRca+DU5jSJG9X2dY3UCOKM6Sk9Q==
X-Gm-Gg: AYBFou1vDd2whwxXLBUuleSwNRZR6+JhyUq7zUW19woD/mPyIp8ttxjQHFnQ6SGExhT
	286f08S7+cVZptkFdpNLizDcbaDjINkly3F+lnlq3vZzN3Ry0dUDImM6M0Vm/qpIDnNm+v0TwBj
	MysFKzkGjaPe0XjRcuRs5gGpnU3fWItm5pO2MU/4y66Mszp/8Pke13T/GqS45G9Q9zZFkjqZnm3
	uuqtA/+j1OZCLP62PV8PCIW2ZQX2kBPhqDX+SdAwA7FQ1JNiCnZBLETgv0BKiy1Re1l7JjWbbln
	4NIujRcNccklqiIOJ86ri6xCntyIVUSDLeb0prtUJx2SSCV0rCTnnGAheF6V6M6mp6o9C7HEVH7
	xV7q8silSx671w4EXaT4CHIuCy+T0Yo0YKkRZPrXm16FVYQxc5Ko/+dp8JnfZDuBjhsOyyRaxXW
	Xz0GNLq5LcLQ7t3PaxJY8pJoWwxGlr14Mvwn7aJp2to91hdstNzUm7cMV0IFEyUV6j4CobSbMWP
	XGMLjR+fc2M+zHDus44kxT41+I2aAKflOlRQh8RrgwvXYVZmv67L9UnluuA
X-Received: by 2002:a05:7300:d10a:b0:33b:f062:a674 with SMTP id 5a478bee46e88-34271d8d329mr6641182eec.21.1790519713269;
        Sun, 27 Sep 2026 07:35:13 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:35:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 09/12] powerpc/pseries: Disable context analysis for the CMM hotplug notifier
Date: Sun, 27 Sep 2026 20:03:50 +0530
Message-Id: <39297f9916c1eb80f4835ac33c7200fd7b5ddaa2.1790517984.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790517984.git.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  cmm.c: error: mutex 'hotplug_mutex' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  cmm.c: error: releasing mutex 'hotplug_mutex' that was not held [-Werror,-Wthread-safety-analysis]

cmm_memory_cb() takes hotplug_mutex on MEM_GOING_OFFLINE and drops it
on a later MEM_OFFLINE or MEM_CANCEL_OFFLINE call.

Add __context_unsafe() annotation for cmm_memory_cb() callback to avoid
the reported build error in order to enable Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 38e22125b96f..159efe734785 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -470,6 +470,7 @@ static struct notifier_block cmm_reboot_nb = {
  **/
 static int cmm_memory_cb(struct notifier_block *self,
 			unsigned long action, void *arg)
+		__context_unsafe(/* Conditional locking */)
 {
 	switch (action) {
 	case MEM_GOING_OFFLINE:
-- 
2.39.5


