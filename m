Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC78606A320
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G3ZTZd0U
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1tt4YLQz3c7q;
	Fri, 20 Nov 2026 15:04:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147478;
	cv=none; b=MunjqEOwVLwWCZXJQ8vIbdK+gMmDtJikFNFri+hjBiigNpNQr6/7O3aWAMA2hw+1Ln5dDmHYldWdYktlTsmJLtxcYqdQxfWEjRt04ZDtwcgMipO+frjaETf+fTK0QKYgK9OGG/x/lyKDg6bOeB0YUYYF4vbyCacNa6tWzxSzo3/Et7p0Hlz8Ve86HNntCEVXijRZDUFYzj2Ezh5N7L3+ak5Yu53pJMupzkBrMRA5FZ8unKwqwmWuzs+7qJue9R/UzZEricwOLB0rUE9vAMQUsiMLKeKGquiICdtM+DEBFcMvnJVpEVf/pY1s6R95Qp5UgDYCpLo6oQ7Q7Ww+xp9LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147478; c=relaxed/relaxed;
	bh=OEeeKd8/7R6Ji2+yPy0bODVrPI/c25RCAh5o8xRTnOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ax29wfpOGJUwjPO/GDBroHqWZoGrrh4tzKRKNq1qjGoe0WzzDp1eO36KE1cPEEEvpe/Es/W3C4SuOKsDgZqN73R8KZX21TH+Syboh7wxkTVH5FKTIQbxPNOg+BrLBY2LZHpZ9HyB7VEqTuCE0zFHDeVELCXBHss+FBDmmKymwIBPKJ96hfaJrH+0/+La6+U546cBjWJtYOaiXbwRXYyUBdQKNUX7bMvpflQX9JUSEaunde/c8umGkHhnHKueZo0nHyYs4g2kPgzRdOn7Ng5BK6qXgA2EUKytnpVuHmlCsi3gKZd6rQqYT5S9Nto8qHILCWdcq8l9NXdCvLar5GpsZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G3ZTZd0U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G3ZTZd0U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tt0JCcz30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:37 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-381f65e4e4bso703877eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147476; x=1795752276; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEeeKd8/7R6Ji2+yPy0bODVrPI/c25RCAh5o8xRTnOk=;
        b=G3ZTZd0UeWcfKA/Lj47mwM9XGn2Ay7XFnZ7pWXpUGtp45PyfWK9fn04cgrQm/DDGOt
         4H3sgp1NtvVVOBR01fMoCTja9HMajHC+QcMkXXnpO0zOM/DY3gumTsU+KSqzXTSxJ4PB
         BHyMB9zPA1HLvXGbCAPI/o7OQl/cxYHjhepDXsuEplGnxln0xxbZK/2H4RLq8mrvYlFZ
         wPwxzQL5zDCub28JZ+l3h7uEAfiUBHatjrZiVcXdAW1hK9uNtNRR8WLrJmbrXgN6jST/
         1b2pWA5TO+Ad3VWJlYyGk0JEC6imYYA8OHZvG2XLFSb56Qc3A3+RDFGth/Vfg7Lr7D6d
         98lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147476; x=1795752276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OEeeKd8/7R6Ji2+yPy0bODVrPI/c25RCAh5o8xRTnOk=;
        b=L4y73T/Zm2k0Ersw86lAbKO7YQZSXcXbNFZ8uh0gAxnYYTTIh1jTG+reZ2WDq3t/QZ
         ov5RPUV15sUvKb6xugxsGvRSVLufd98s95sGMN2l4itl7G9XaxuQn6sy1uEDPWyQ3xK0
         l8r3xmizPgBlV7XEav2vWe1uVqnr0WtjuJh8gQNrOVC4G7Xcel9Xt9t09ZNPEXWRTInt
         tiigpp7vEw6PkUeJfhc96zm5cJuO8uQR1TAn5+Cg/H5QiHrBOpwRsGutiBMR/VJYvJhk
         /2dYEypS5YdyQUaw1EwB1I7h/LRbYWUdQh4XtQuOlBX0QLRKRBlgNWHEBD9bqok7OAgG
         UQVQ==
X-Gm-Message-State: APuU4Z9nk9eXEcark3J9ifcJaq3ZbFz0jfLdRYrmfDc5cB2d6O4upNv5
	ftp6SeN+uwi/02kQmkEOzecgy+AIXXvsjUeXaPL0VgbVUvl974FY9n7ScyHd9Q==
X-Gm-Gg: AZFdTZcwMsDR67EGz8ZI8TCOWuoQApPL0t3YqJM1VDCZL2wFK7wUzK3q0baOQ4nn0eM
	dk7dUpxTUolT8IYqOENMe0p1lBpJOa/rq6EJlYD31dz0AnPOtzgFY3pYM0SOx6ywWmBfIvAcX2v
	ZVSlIkS+fcrblxHEB5GsMyMLUu9tEqFFtPUCCUhedzvaPO4NDkPYa6vePNRkpN2gXp7Im7knvh9
	PDGZ/M9wNYyvgec21mLj3Foqzm+OlByqB1TOEbfJmIG+cbzMPAtlzbz92NYEdJLARvu6jpMEdvw
	bLBP/0R8ZeJuAPXGDBFuv6GJInhgmwqIAHIV1AEQL+AoHSJdI7E2GTMcbw+YDXFVTV3/6tsDqHt
	vIjfjYDz5fKShpXTwnO03iHJEOK36CXZdNcJDcElZMYbSfvooNX8mQCABbvVW8kRoC8VpSdi/rT
	9ExKO05JR25JgP/rPS2zM9hcEKIB95VEG4Elhsij9GyBIwxSQ2zisGRa3vyFLVmLj1f5q6g5EkV
	hhh4X8vInw/cwI7kL26+6OzVCxwDr1cxJfQfG7ewXfbo/AFwLb4xnbBX4+QV/cQ8a53aHWJ659J
	7ngDV0KM4PnFHX8nzbWLVFAnuKZ4uVnnOQ==
X-Received: by 2002:a05:693c:8951:20b0:384:ce59:5e19 with SMTP id 5a478bee46e88-3856f257bd6mr1332465eec.6.1795147475927;
        Thu, 19 Nov 2026 20:04:35 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:35 -0800 (PST)
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
Subject: [PATCHv3 16/19] powerpc/pseries: Disable context analysis for the CMM hotplug notifier
Date: Fri, 20 Nov 2026 09:33:15 +0530
Message-Id: <b898fdccf40809f4d18aa302ee3feabe27b89151.1795147055.git.ritesh.list@gmail.com>
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


