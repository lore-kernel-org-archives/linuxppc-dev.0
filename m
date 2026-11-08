Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C8606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wq9Xus+a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNKKv0Bjqz2yMK;
	Mon, 09 Nov 2026 17:16:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794160489;
	cv=none; b=At4vsNs6dqtmM7KcZ4CB3X5zCmk1cP8hACVmQthtZVGOzwUZLnPUiJnIoTH69C1IOjVaj4aEEUOz3vT7c93l7SaUk5i5vZwH4vrET5pZ7w+KTnqGy8q/XBq/NrfzAwlhSSlbbiiV7AGdQOknEnZ0vDmW4Nkx1UWPVOvD0ootNrXZfZAWe2m9rIdi9eL5QkQ/f/e6ceb+GMCVpogRY8JSHOsahlunmZMkA0UUPgmr30kvS+tLVnO/+QX36vz4gVhE4NKose6iLJ0rSB0koZfsYpS+gR5iTbwY6Mhavs3ExofVAWr5wiZ76bLU/J6WtvTOyONFPGfBFXjvb0E0nKQNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794160489; c=relaxed/relaxed;
	bh=XN+82m6XILmToReUZb14mcLlVGl4HvQRUT+BvYNhBMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hxj9tO089zCeBauomVqptW72PejBQpJWaye+uKQ1AvCnOeC5L1ysQ2gAbkzzE4eAhvfHyJ2xcSfEuNpma+NrYKCh1n1gzCOKiqnSV9go4iSUze5rUxW2r8lWJzRtXEib4tdXD5nIagedbn4C4khu+oYekpkc/qk3/PSnEM3GWTJtvoyzlWyiah7LQk4tgEMHHlM7iE+UO/bt0dGZdfoVqi6hhd4uEDPLfyfSZlgVTeWztlKcMjlA9gDi14KMZnQ0NW6OUFm9Zx/euE0LhQsFCTM6J5+yUsKWWNN56GlWwgK5fASo5WL3mR7QMVSfd3NOqMO3U2JCscOKiBQrzZnl8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wq9Xus+a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wq9Xus+a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com [IPv6:2607:f8b0:4864:20::1229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jN0tJ3qvCz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 04:54:47 +1100 (AEDT)
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-1b1ce85287aso160614c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794160485; x=1794765285; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XN+82m6XILmToReUZb14mcLlVGl4HvQRUT+BvYNhBMU=;
        b=Wq9Xus+agYcyWEnns1tOJe8ERmS4+p+8UUmR2MsU9VWZbrAe5dqFEvau+1QVilxPkM
         xI6hzipMlSQCB3LoivogOsQILYV7Z0Gmllqk/HwBCiRFKpdrNZ2rN9YP6Fpsp6pFHt+R
         HGODr6IkfV+H37dqc2lDWZhP7BaeGZ7H+SGDOeSmLtA917nwhE+2AIWhWWv7K7Cb6V1y
         P8ZV7n+huGWwDyKA2APl1fSuB7rqwEigmXoistD1d+WrB3zClwyE5vmJjOHQA/wuWSLE
         xv/1JYq+cFOx4V9KrxHTATFy8At13nI3O8qmzSUyvXTMJAfPJX82fr1cMXpVmjsQBk8B
         TUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794160485; x=1794765285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XN+82m6XILmToReUZb14mcLlVGl4HvQRUT+BvYNhBMU=;
        b=J+XCTzpTg1muT8DRp5hCGzfSK3R15Rrce8McU+n77L9d7dl0RXXg2eRoHOTt92actF
         nlyVqsH6L4ifEt2yhbB65nfaaPR1jEunDY6yKhvqwnU8DQJRGWPnmLC2GV4dws6m57WS
         0ZM0gVw6pLBoNVrbMBe7oelMml1feL/DI5BvDynbiPrCQsrAPmw0hz/Xbv8aSn5dDqyG
         oZ5x+SCobZ65NWpJY09LQkoHsVppE6JcnnN9n0jaeb7cjd4rg0wgyvXP92tsqkL88RvQ
         69a3hepG0SSE0H5ln6BKN3GpXCe3TaYBvJ8FXmACotyCVLFKXGpAEU1IQKPhBWFqAzPP
         vdjg==
X-Forwarded-Encrypted: i=1; AL+hErFSU3sGYswAB+fAm2q4oXU4CYlwQRK9xzowTptJC4/3TX8jbpnL44EZ6TkFz4FBdwba0RWDxcePdAYooqo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+FxXF8/G2fP2mdqnzi1ggmvlC5qdNIgpfyOZO0TF7JquSCJUi4
	JGcv+W/hsDKE7mC9RotI37LaTrd2zgQHybgO36f5ElKLB5s1kCLn2SNO
X-Gm-Gg: AYBFou2Uu4LdEc2VFat03sPNCdGE+OQc4zZdNxfOQrFzVKIrV2an5CrHsBT+jI//obQ
	cT8SxrRSplcnZmok/ltYhp4mAAwat1KdkpE3/1VSdK6ilcUX6H88P+rTR37ZdUgNwrgbHFewDPW
	VhJvKAqup97n6ZZBHQ4aTLRPW+T22+ATSZzVhgRsVGd8IgfqxJfb7e+o29y6ZJ/gw1J/+QIa7rH
	jJF5tWbJ4Y/517u7GfnLiikrmVLxZLaM3bOzc+FZJDOV2yeHBPoqmjj++yAGknG1vLlOfDfVErP
	mVyUifZwVrI1PBH1h0QOnAqJlsvNU/kXljFMa5GR6QsGKYLF4WWAR0GxLaAhpaWOlsg/vgjFtpV
	9hybsdbqJAblfolRx3Y3Bpbw84xm/3Ach3a7EA7ELFjoHfouxWzDDz6YNfKG6pb2yEEpqrd+rdd
	sK5x9ABnUfMY4wR1xgD1GSwparPn1UpWaE6Et1RBEFBbM6ajtX6TsqQFAwXXJZQV2Fal6v7NWT4
	Z7S24NwMSE+BRJN8YGQHWI+yZI8Qfvt8ox3vPuw2pxAKowHUk5FSdyfcYIdp2ZGEEU54K3jceRV
	8lKev1fAtoDsffpB/gwQW6NE8T3iQP20QZq+/hDs4B5xnp4/
X-Received: by 2002:a05:701b:260d:b0:196:7742:3928 with SMTP id a92af1059eb24-1b39fdaf0c3mr2557319c88.0.1794160484955;
        Sun, 08 Nov 2026 09:54:44 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771ea85bsm7386310c88.18.2026.11.08.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:54:44 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] ocxl: cancel xsl fault work before freeing the SPA to avoid use-after-free
Date: Mon,  9 Nov 2026 02:54:35 +0900
Message-ID: <20261108175435.725507-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

The XSL translation-fault interrupt handler schedules
spa->xsl_fault.fault_work (xsl_fault_handler_bh), which dereferences the
fault and the SPA (via container_of) and acks the interrupt. free_link()
calls release_xsl_irq() -- which frees the XSL interrupt so no new
fault_work can be scheduled -- and then free_spa(), which frees the SPA.
Neither cancels a fault_work that was already queued by the last
interrupt. As it runs on the system workqueue with no timing bound, it
can execute after the SPA has been freed, dereferencing freed memory --
a use-after-free.

Cancel the fault work in free_spa() before the SPA is freed. By that
point release_xsl_irq() has freed the interrupt, so the work cannot be
re-queued and cancel_work_sync() is sufficient. The interrupt top half
takes a reference on the faulting mm that the bottom half is expected to
release, so if cancel_work_sync() cancels a not-yet-run work, drop that
reference here to avoid leaking it.

Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/misc/ocxl/link.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 7749dcd..1c2a89e 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -376,6 +376,15 @@ static void free_spa(struct ocxl_link *link)
 		link->dev);
 
 	if (spa && spa->spa_mem) {
+		/*
+		 * A pending xsl fault bottom half holds a reference on the
+		 * faulting mm (taken in the top half, released by the bottom
+		 * half). If we cancel it before it runs, drop that reference
+		 * here so it is not leaked. release_xsl_irq() has already
+		 * freed the xsl interrupt, so no new work can be scheduled.
+		 */
+		if (cancel_work_sync(&spa->xsl_fault.fault_work))
+			mmput(spa->xsl_fault.pe_data.mm);
 		free_pages((unsigned long) spa->spa_mem, spa->spa_order);
 		kfree(spa);
 		link->spa = NULL;
-- 
2.43.0


