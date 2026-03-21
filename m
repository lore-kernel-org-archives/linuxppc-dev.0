Return-Path: <linuxppc-dev+bounces-18546-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105121094474
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 12:12:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdJGn2MlPz2yZN;
	Sat, 21 Mar 2026 23:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::834"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774064298;
	cv=none; b=gbMiQY11cwPMdIJZh8g/jGbQUKN3fvd/cyaAMxPJ3c9adoAd9/1A6L365HjaCHVaI34BE4ewmyuIRkm9pA39XKaxc27SXsisyiY/0VQ/hKQP/pRCKzKg9pjpsBeHxEMRV+9Dzp86BfJIxjS29o3wBI6lk7xT0E0nXA4xqNQVEjqwZlCrshcGEbiDEVsbQmqf3RFKBKlMhp7n9tfRLeDXt/6UKMooTowe/GrlxMpAuvm6JkHFRWUfPG10VmhZ3Mcg9wg+ILOq59SZcth2rYfGXp3XduaVMdwKne+Rp3rdtSCOjjrOf/ej0HkN1x89IPHibsto4m2nwUZBDEf1Qz/lvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774064298; c=relaxed/relaxed;
	bh=6B2CDNY7UG/sAWansjMq2Hcz4vu6SmMLIBCAlbIfga0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erJzN98L7va3sMMy9lSY+GvBPddpjndChHmjBA1s9Xld71QqMN2DC5hr9G8y/K4MGD4fTb50S9qz+1c2ZHBaslPqLIi3ygkZS7wLkexO2E0d72UWma6URkjytar94zAkCAT3lFKQkm9KvWQGUEEEsjTxkZRMKkSsL4argi/eu/I/iaEDw2eYuWub5TLl8hn62D3nxqO1i2/yIZ5Rtg/DIaadFKNLeZORzQmB76zwaPsxODrOaeeYzV75LT3tWTxhWfdLRTGsYETkxfn0lb/Iy8lcA9Hv9mjJbAmIVxrq75Ai6ewKFQD4TLxlvKdDpEICVT9T8yZ/kxEhRS1Y499vDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hacyz1q2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=livelycarpet87@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hacyz1q2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=livelycarpet87@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd4s44v5Xz2xN2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 14:38:15 +1100 (AEDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-509134ab2d2so22096611cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 20:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774064292; x=1774669092; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6B2CDNY7UG/sAWansjMq2Hcz4vu6SmMLIBCAlbIfga0=;
        b=Hacyz1q2M0LIFRU8+zisS7QoYx+IEOJL0iuVQ6BVTn/gORVDipPsLRCRnYrO/SBf1T
         PQPfIrzQqrQTTkGuuXWXZXFkCUf4E1K0v8zVe5vWGMYRP3E7eORDPJnreOiOi3PRhB1B
         XPTcLWlmePXjeXKXo1r/LN130V8B8VCvuQxmYYX12LmnN9zgXw4p87UXWFzZwDtWXYPQ
         ysLq2LUU9w9G/PsqRcL7srg1fQQx7NWwdoAsZWHiGWhGf1GhUCxncxsRj2TpxAgSVOm+
         F+p4J65kPJq1fcPoCbtvB9x4FOew1okxNVFQ6zZGvflv0k1WMpmBkCe+GfxDYiezxvT9
         2YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774064292; x=1774669092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B2CDNY7UG/sAWansjMq2Hcz4vu6SmMLIBCAlbIfga0=;
        b=fssExAYSKaIWX1ox8PiNY938st0u31xnR79LsUC+wwRxzk/OzAOE7ZPfvdRgruZSdX
         V/FMsd4CMPE2sJD3mptbzfqzGqTKWFHCHosvwnCgtcOckXKKj0NJIXFjqGKoPF8QKI5E
         ONYHHVvLGEfPRofH/LzIE3z233LLAM1LdCD2O+Onlx5uXkjG4ezwq/i/Gz3JkLKKSP7n
         dOexsCZcDao38epER94ARnUsUMbysJPQBHwC2MEQUk0EM0ghaj/9ECW4Ep2tfrgMDdoG
         uqxZ4N7aj6C0CWeZTrjuWmRxTTgL/vAAi6R+LMzx0hb8dCnMrouC9dBrFZVBrnjjJjL1
         yr5g==
X-Forwarded-Encrypted: i=1; AJvYcCWcLISLshvNiYW2aFHah7ZTK5iE0KlhMTc9Eb7UdpVstATOOszDPnXT4goJ+HEtKg5a7ItOTOQkVt1Qom0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz3qbFBzBAC3+v92idkVo9cyUa2tXTGFyAtRUVfovIeHajE1mQ9
	ZfeslHOq9gPxRK/aOG2FgCC+/rvVyLKGvmHcenqgtZI9pSOYPIhvhls/
X-Gm-Gg: ATEYQzyx9ahE2YxNS5J20rcNzJmo6iFRmJwx2t0iZ87i0RfDzFYJU3dWHJBr5HMgKaO
	mgg6CkeTg0/G9+G8OknR9h7F58NKv0MuwIOrT0PjV7EpRL4ys8gwNghLACckQWq5EMcdsEN2BKj
	lVMmEUSyojIOappZlzsGhiJuHWouu40hocdYH6GBewuSMF+8SBT1dWuYT4sRN21Gtv3LwtwV4JZ
	ECNCfwbmFXDyV0KDo3WnfUaZzS2XnKrEhP01FrLQmE+kJ25WQYvZWeF0yQpIpjPiR582pwEiVPY
	Ka06kUJhtt+iVUAoO0lhj3+XCcVMYlwJYMIuPM9VGHjQ9xkse8mM5HmkV/5frM99UFICl3PxwTT
	+cokCoCg+UROAbmq1YoBSWE4wDF3UjGgSLXjaP0dia+CiR9jiDZzweFxhd3m7qNl43DDrtxVCcE
	Ku28+jVBYt2fXSltGX3YIC9M7EpHP7jtouPTN4nJYdwlIR5z5egld6zBoVrqrjj1VEphN4GG+sk
	pJg
X-Received: by 2002:ac8:5a91:0:b0:506:8738:651d with SMTP id d75a77b69052e-50b37599714mr83159151cf.62.1774064292055;
        Fri, 20 Mar 2026 20:38:12 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e9abd8sm32406071cf.27.2026.03.20.20.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:38:11 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: tyreld@linux.ibm.com,
	martin.petersen@oracle.com
Cc: James.Bottomley@HansenPartnership.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	danisjiang@gmail.com,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH] scsi: ibmvfc: fix out-of-bounds write in ibmvfc_channel_setup_done
Date: Fri, 20 Mar 2026 22:37:54 -0500
Message-ID: <20260321033754.899928-1-LivelyCarpet87@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ibmvfc_channel_setup_done(), the firmware-supplied
num_scsi_subq_channels from the MAD response buffer is assigned directly
to active_queues without being validated against scrqs->max_queues, the
allocated size of the scrqs->scrqs[] array.

A malicious or compromised hypervisor can supply a value larger than
max_queues, causing the loop to write attacker-controlled 64-bit cookie
values beyond the end of the heap-allocated queue array and corrupting
adjacent kernel memory.

Use min_t(u32, ...) rather than min_t(int, ...) to clamp active_queues.
The firmware field is a __be32 whose decoded value is assigned to an int;
a value exceeding INT_MAX would produce a negative int that min_t(int)
would pass through unchanged, storing UINT_MAX into the unsigned int
scrqs->active_queues. Using u32 arithmetic ensures any out-of-range value
is correctly clamped to max_queues regardless of sign.

Fixes: b88a5d9b7f56 ("scsi: ibmvfc: Register Sub-CRQ handles with VIOS during channel setup")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index a20fce04fe79..5694530c4b2f 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -5039,6 +5039,7 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
 		flags = be32_to_cpu(setup->flags);
 		vhost->do_enquiry = 0;
 		active_queues = be32_to_cpu(setup->num_scsi_subq_channels);
+		active_queues = min_t(u32, active_queues, scrqs->max_queues);
 		scrqs->active_queues = active_queues;
 
 		if (flags & IBMVFC_CHANNELS_CANCELED) {
-- 
2.43.0


