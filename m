Return-Path: <linuxppc-dev+bounces-28313-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6622CC9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:35:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6R36P2hz3bbY;
	Mon, 28 Sep 2026 00:34:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519695;
	cv=none; b=UP5pZtNz/iiXl3LE7w3ko0tEtTqvrnBZ3cmUmSvG1jocuX0n9ITROwR+rRAVRWbRqd9HTG9ordGalDCrZn3w5HD/4Z3rfdEeCrPg9ShuRMkUYcJI0LS0gHkCmZuD6NiY8CqVxhCs3U3wp0vWhfkAQEb5KX31JHerUb5KLWcKyImPxsztwCicze2is7OotTm1rfVE78JWqbCpiIxZiPINZGdnFfHt6HsSfTdlOhKQyYFdneVuvAkG0JVnSqWdoYH7NICzYfJ5ag/LU2eMSjHaIwSn2Ji549JjPCdANo0erU9ilsN12pa8b1NrNru2SI7Hz4cxYeNDflt0yNNIWLSKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519695; c=relaxed/relaxed;
	bh=io+CTWk+B5zCdv2jhfadGeS4AMrXIMCEILzj93M705I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNAxehySNGmYDt/dIOZXrbAh9pjpoFrkkP9A6Z++DK+K7eBZ5WPoI/7m4dlnZkPRX66DThZwO385vFl056hnd2QZ565aMwTNlCX2naJBpW7H7R2L42bv6idSK31OlNmnIDi1c5SBEuYgg6ty9fdDJYGxfDvzu2FnK0serI6YlwINbSNH9s8zWKr8ZQBi51ksf/Dm9dU7qPROd+8NaagrnnYWfqslfdrFRCnjO+gIq0PDv9+x1L0cCUqUbJYU38gHeDKNKG8UI+aj7RejFX+GA9bPn9YtyMJ5sq11KJWUnqRTKgMeeD5+AzQ6yout0Wt+28tO3BjvzDw15bDYtJiwAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ikaEbJps; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ikaEbJps;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com [IPv6:2607:f8b0:4864:36::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6R30wjyz30Vm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:34:54 +1000 (AEST)
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-328664dbe2dso1200879eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519692; x=1791124492; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=io+CTWk+B5zCdv2jhfadGeS4AMrXIMCEILzj93M705I=;
        b=ikaEbJpstEWDT+bJ1U/bwUEqzx/rUxLQWC8y/JjruiRleyeNJhsb89LDlO4pTlMqS6
         U3T+Ukb0FW55mXLWI8jzmhp1NHze7B0dsDSZWy7DH/rS702ZJUXCB8QbOOCXbanKHrFw
         7HJ3Ddf2EESF3VVqeIAsKkhSVsHpC8n2Dh2CLLGkV/giGLDen4Cnpatj7luD6g2nUhiS
         7TypOkqckrpnqOLxho1D9IMZOfDUSNg6+6cq90WIHXIDbZHPzmoOmpy1ZBgG05p5OLzI
         Jvw/KXr8zHZUk9mHnvQ3Sqn2JkDVHrgr+aHqr71qp7PyV/G+nQUDr60BXE6EXw0JtCDB
         67fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519692; x=1791124492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=io+CTWk+B5zCdv2jhfadGeS4AMrXIMCEILzj93M705I=;
        b=O/Nmc++K9jglw3N/W7sKCbVdvCq2ulnojclrehrrHVb3Finrea6RBCjt2RqSkLIDIF
         VmS8RWMD3vgvtoWLA7mUkal1/szlHJ19j7SnxOhnCBNwXs0orqO79aVfZl+M9sVJnC9a
         VMHRvThq8NeMCAJNhnpXtD9RMry7p2GtcO0g9FvCOtTzi+MQaB3nXkwCsoDdgpFwfj5u
         Cg7XQissv4E9suV0JJijRxnw9XREORWZstk54pl6yTN5oG3j02ZfyyO5pldDB7EGAvLH
         VnwAdTwUPmJ6QcEToRosI1+vEsw78uFqrFCqQViursHfxFTJnwMpE/33MQ4X9QAdw74V
         9cyA==
X-Gm-Message-State: AFq9FYLFEX/J9YzwwW+js4ommzFkW815cg7hjOb1Ra63ASzL+VPYwgsM
	W3op6JTv/pkwLPE4uIyRr/WOlBCDNQC2QS4jI+PLmtbxPAPtHb/2Qe1jYNc5Tw==
X-Gm-Gg: AYBFou33JKigxqliQXC1dHlAGTRbCK4gvZ45W5TjNqQv5tOBo6h24HRCJbSyVuHrTCi
	NKrXKgUaOwai5+HGCVRbJu2zrlyuwnyUij4x9wv++d021j2lTZNjh9E9E8+K6+fdnnR0DrxHklG
	xky3ZXZ9S7YodNwtQWexOhH0fb6gJLTddgrqd/U9S3tY5pvQUAFbzAGoc0mraprEj8XtXUhJvyX
	+YPbVg3pNYyi/5YpNyRQ6kofFoUPX9shHFBaD0PyZPQ0SpVoSNDTjxMAbRpxxJKx16fQoBkqSFL
	5Pl4Pc58XnnoKwuL//8lp1vzGFcLvvys5nDCN65vprWdw3766WDTa79yl6TsmDvny4A7/WLN9J8
	85gBEkelWgUV9n2zX6Y7luXToTACqzedebfsamjseajoTWgF2BQCrByDBJxrar812wegAcTiHvO
	cIxq7NqhOVC2Zs3wUbFfUMdAFu6RnNE7N4TYnrFbfKAwRHvjf8pxKD//nKKOSWX91jAs7sgiA4K
	Klr4YHDNf4H/QGQ90uzL19CXGolNWDDxRNDDhj0g069IYjt1KlqSOSFxxMZ
X-Received: by 2002:a05:7300:b54b:b0:33b:e586:ba81 with SMTP id 5a478bee46e88-3427265fed0mr7784905eec.8.1790519692224;
        Sun, 27 Sep 2026 07:34:52 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:34:51 -0700 (PDT)
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
Subject: [RFC 04/12] powerpc/pseries: Add context annotations for the DTL worker lock
Date: Sun, 27 Sep 2026 20:03:45 +0530
Message-Id: <20a3dfd2d68df0c3bf2bd24d51496a4a238a8456.1790517984.git.ritesh.list@gmail.com>
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

dtl_worker_{enable,disable}() needs annotations since they acquire and
release locks. So this adds conditional annotation based on return value.

Let's also disable context analysis for vcpudispatch_stats_write(),
since based on received input, it can leave the lock held until a later
write of 0 unlocks it. So we need to mark it with __context_unsafe().

Otherwise we get following error on enabling CONTEXT_ANALYSIS on this
file:
  lpar.c:490:9: error: rw_semaphore 'dtl_access_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  lpar.c:498:2: error: releasing rw_semaphore 'dtl_access_lock' that was not held [-Werror,-Wthread-safety-analysis]

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5dbf447d3a83..9965ead1e93c 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -461,6 +461,7 @@ static void reset_global_dtl_mask(void)
 }
 
 static int dtl_worker_enable(unsigned long *time_limit)
+		__cond_acquires(0, &dtl_access_lock)
 {
 	int rc = 0, state;
 
@@ -491,6 +492,7 @@ static int dtl_worker_enable(unsigned long *time_limit)
 }
 
 static void dtl_worker_disable(unsigned long *time_limit)
+		__releases(&dtl_access_lock)
 {
 	cpuhp_remove_state(dtl_worker_state);
 	free_dtl_buffers(time_limit);
@@ -500,6 +502,7 @@ static void dtl_worker_disable(unsigned long *time_limit)
 
 static ssize_t vcpudispatch_stats_write(struct file *file, const char __user *p,
 		size_t count, loff_t *ppos)
+		__context_unsafe(/* dtl_access_lock is held from enable write until disable write */)
 {
 	unsigned long time_limit = jiffies + HZ;
 	struct vcpu_dispatch_data *disp;
-- 
2.39.5


