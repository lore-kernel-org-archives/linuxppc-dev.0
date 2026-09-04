Return-Path: <linuxppc-dev+bounces-26586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAC1C624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:08:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNDP5D94z2yr4;
	Sat, 05 Sep 2026 16:08:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788519026;
	cv=none; b=mDGvK7x+kfFcKHbwQ+b8hcwjcx0ZYUVjjodmYOsKFzfsSEMMZQBVZb1sSd8HaBzIeVMndZOgweAZf6QhV9KWbDbh14+17MA28dQjd9UGTDT/8Nh1z5Zn9qc7WjajJQYjE/jvUh+EWake+MjdGiVkHSXr9+koUb+z/U2wrdSGMwN8vG3nvidq5Z/QygcB7rs1h7cNJojabBFYTHB1BIgKZOjMEc5vzvhO8A80k5apS1aOD2PgRsrXIOReglQ+3NLFJKMv/XpNXvDTKgJ1unYC7XPlJK08qOfYGklV5VSqPzka5tQN8lqlEKax3AAEKwJezzhf7dWmKZpQqGNEwVGwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788519026; c=relaxed/relaxed;
	bh=JVe3j7HRHHIhbvIbEK+C2SoCEY61/0kcnS4nfccAWlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM1tMby7PxaNbx/jkx3QHBWF+3jnxAeZ1yhhUJoMljyD9nYEDl+GAqGfoOV7JcWog2lP2XqQbz2CHrjd2fw/tEh+lXPSWmWhfHc8+bricYzaMi2jgn3xa36G9Zt56L2jMjWpGI4/1Lr8rZWyOXxET4/oEdEjWOzJKcZA5zVK8nNpUxzI67+6nxumvu588ASfmr6WiF0Vldeppe2xef828RT1OpsB67CuIwAQreqJ1Z1fl8OfbsymykC7lD2n7NyvQ1SkK5zPPccxJ/CFZeu7WEHuBnd91dgh4SENQE+b4QSjqnFrwjslykHpGQuWDhiXVtT8M7Zj7PlsdZsWtoQOMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J3/rum4Q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J3/rum4Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbtXd4LJwz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 20:50:25 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-39682983a0fso905061a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519023; x=1789123823; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVe3j7HRHHIhbvIbEK+C2SoCEY61/0kcnS4nfccAWlM=;
        b=J3/rum4QRo5Xn4NdGJNRf+RWwZcKRMbq6AgYie8NxVS5aqJDXUG7o1RzRmmKVr5AtG
         h6NG1auEmCFZuNGHytbk3r+8oLVdbG8MV/t5JLnJ9El6dLFVwU6W/vg9EzuG9hoX9WH3
         Kh+SSTNgtmC188NzHtC6Iz7BiG5IOxgMbPVuOB0LR3bl5c3U6HOIWyL5XGVqjINHNae0
         YEQ5onfqHpBJEAvUq4sMmknSGKZ5em3WAP2qsTcMYa46GiVA/SWvwokRoBGzn2iE5NmW
         9jVCw5N+mbdOFrVNZLdiyjkpIQx1Hz25wvpWMEwfzQtBgC3WeYU8Z5k2o1zYIn6p3A+x
         RnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519023; x=1789123823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVe3j7HRHHIhbvIbEK+C2SoCEY61/0kcnS4nfccAWlM=;
        b=acYHkpZ+3lkVFNQOYPyyRKjG64ZGN2Gy3KaiG/Sw5hbVFQPE5CnqfrROh+6RIYzUn3
         PmGS645YpkagBbPIG4+yhl4ctHh7Bk54zyobM/wEAAJFl/Cvt4J8q+IIUNKSa1mxksba
         67bu6W6jenYNgE0cc8NiP3DymcFsS9CSR2UF+K/ceCPsT8b4WbP9fg/qk/Hd8IkacrIf
         9ymR+iE3+dJ0WmLrwLrAYSkNHhrVMmKQaY9CPTONOr4aZgIIEKcKH8Ri/qp3T8LrmyXQ
         PclxkrbFbQ6ZIAU1ssEHIkSYMLOTZ9u3H8ATamjexMKof6nHC+NXE5UUWhRaOiBbBOfj
         MNbw==
X-Forwarded-Encrypted: i=1; AKwUvBzeVX/V5djbGcTbZv7OVE9em0bC8kRi5KfBG/pc+AvNN/yOVt8dNeKlns+wzsbm09eVNR1hIAWFgHETbE4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ngcFaEd40jdCOEISgTLo/A0rVxu0TCCp60ePE6HeRG7ceiE6Rn
	I8xeBZ+YzvvX4OYv7p2X0rKrhGEmJulPgSrBwC6xSctJeaHDexZ2btub
X-Gm-Gg: AYBFou2WMy10aM2UPrqVJn8VVt6gUE6qeb8jruysvBJrN3cHf1trfDuvyfy89JHxfSV
	cfSTsd3iGNjFDHmaD8QLuJ5zd5d6TDHiUdPU4G7VurL1rvrKBICTg4uJTPT09HhmwRDu7I0L1JF
	2HMbNqh1vcvbZpUz+o6EmrBeYrIrjYf7kwHtsbLNjqzOY9yHpekxfJgpYNy2PvacQYgxZQ/AEWn
	PMNjG9TGTuUFuyWWbTsQLcpvjKLH3IEOZCR6CSSqiw9ihecrhNW+F9SunJCh8tHcYytpQuCUbI9
	IEVLnDqndYysqQ4ILCud6P/f/DdHchiNMhajgxdKJYBtOVn4HkykMXvzCt6/etyY99liHq23C8B
	i1oknsw3E0ggeRKkoUwh7/qWyCiuiI8gtSGQxbUeZOC/JgW31Z97Tz1b3J1+ivbCI0fbSRBvtnQ
	AHFS7hUJUTAn5UdaSsoQYeUOgIlFO/UE/2e5mZVf0xcuLD4rEagaNKOOcQM8jiz0WCSS4NlA5/k
	zClQFQLStmCq6I=
X-Received: by 2002:a17:90b:3912:b0:398:c724:1bb1 with SMTP id 98e67ed59e1d1-39b26101524mr6786890a91.8.1788519021437;
        Fri, 04 Sep 2026 03:50:21 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm6421454eec.21.2026.09.04.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:50:20 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jochen Friedrich <jochen@scram.de>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] i2c: busses: fix typos in comments
Date: Fri,  4 Sep 2026 16:20:07 +0530
Message-ID: <20260904105010.27405-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105010.27405-1-hemanth.selam@gmail.com>
References: <20260904105010.27405-1-hemanth.selam@gmail.com>
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/i2c/busses/i2c-axxia.c    | 2 +-
 drivers/i2c/busses/i2c-bcm-kona.c | 2 +-
 drivers/i2c/busses/i2c-cpm.c      | 2 +-
 drivers/i2c/busses/i2c-st.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 0555eeb6903a..62dc55c146f0 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -60,7 +60,7 @@
 #define MST_RX_FIFO		0x44
 #define MST_INT_ENABLE		0x48
 #define MST_INT_STATUS		0x4c
-#define   MST_STATUS_RFL	(1 << 13) /* RX FIFO serivce */
+#define   MST_STATUS_RFL	(1 << 13) /* RX FIFO service */
 #define   MST_STATUS_TFL	(1 << 12) /* TX FIFO service */
 #define   MST_STATUS_SNS	(1 << 11) /* Manual mode done */
 #define   MST_STATUS_SS		(1 << 10) /* Automatic mode done */
diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index d4f287b31fd7..0c30821e7b0a 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -12,7 +12,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-/* Hardware register offsets and field defintions */
+/* Hardware register offsets and field definitions */
 #define CS_OFFSET				0x00000020
 #define CS_ACK_SHIFT				3
 #define CS_ACK_MASK				0x00000008
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2cb6a233d313..c8b72f14d179 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -334,7 +334,7 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		tptr++;
 	}
 	/* Start transfer now */
-	/* Enable RX/TX/Error interupts */
+	/* Enable RX/TX/Error interrupts */
 	out_8(&i2c_reg->i2cmr, I2CER_TXE | I2CER_TXB | I2CER_RXB);
 	out_8(&i2c_reg->i2cer, 0xff);	/* Clear interrupt status */
 	/* Chip bug, set enable here */
diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 0a2b43b5577b..873ce2f5a406 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -256,7 +256,7 @@ static void st_i2c_flush_rx_fifo(struct st_i2c_dev *i2c_dev)
 static void st_i2c_soft_reset(struct st_i2c_dev *i2c_dev)
 {
 	/*
-	 * FIFO needs to be emptied before reseting the IP,
+	 * FIFO needs to be emptied before resetting the IP,
 	 * else the controller raises a BUSY error.
 	 */
 	st_i2c_flush_rx_fifo(i2c_dev);
-- 
2.48.1


