Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B162606A332
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMoqCRIo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzlX0CKdz2xlY;
	Wed, 18 Nov 2026 22:24:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795001079;
	cv=none; b=MnBsVUWsmL3sdO5PhFwep41MB6U++kFq132ANAXQ42CRL77pOf+RubJgyBubADIHxsaHAhtzosHQh86AdEm5MyWRjKw6Gc3oDZuj0+9/6xI3cVXhwSUtaY6IYd/Xp/VMg8+jxqgzC7jfEjAKG/uDxtlux+D1k7f1XzKE5T2xK34qWKMbGurrBrvfOXdULHCMdbuO39+9RJ1/ThGQS66PCwYDHEf3RiV9hGIkYzLdryj72ch1qAi/UkJV5KKP6UZUy/LPyhPZxB4XKdZ9hnnW4LJAut9rsfwSGQK4DvDxTP//2XskYQZd7g55intIU5QajADT0SCxs+PwWwHh3VOlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795001079; c=relaxed/relaxed;
	bh=CTu2kT6vY540i2vTNL/lOCMqwCzR7YfsabNtoI8JhQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WhGpOZO6WSgQfGha1R1aqNl9jD1TWzLCek74xBQnD+rGf3+OC7t+KEzJvyGQ9B6OPozMCCq1bTMpwpdJa8MMwnUasVfs7rCdaytX3T2BFv0xc9i5shf+8vvlutQdrtq7tZ0WEZ3kaFpkdBOqtRduCjyeADUiAoijXvyXC4efz2MH6Q2ndLyZUMieAhODv0wnC5kKihIAD/IYHMZuO7uvKBQN9po6LXSK3NpbRpVtFm+D8MDV/fm4Vv4AwRmEuJS1lobwFKOVFZ9GifahPcEibodCckQIfY4i31P7mJLb11ix6sHUKM8QD6VerRBoMw5fy1d4+LKJKQMfvO6k4/O38Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMoqCRIo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMoqCRIo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzlW0RPBz2xdV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:24:38 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so486277a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001076; x=1795605876; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTu2kT6vY540i2vTNL/lOCMqwCzR7YfsabNtoI8JhQ4=;
        b=AMoqCRIobspklow4uH2qusKmfwqvt3e08iUK2j8jHtl7SCUzvokGxNvkymocf0j0Y0
         3KpJ3oKO0IA5KhUjJL+UlaYL8hFqlhQ8Sr+SYcAVzUAKe/HriAxpd71r+NhgdRZiK78h
         uXHC/WDPjV+Nw87TZWzZ1MhqZEyTcGsYda4k8r6nI9SzpbamS7oipJPIWzp+vHYLvI7y
         SSzkIzceBz4Wdu+VOpZN6cXNZAo/tHTnxTKD4Eg1RzjSXxynDqhthnkHOx2xJkSuLpad
         aZqmUPsMcKpJo++rDtx27dB9Cjgush9L7f8UDROu3j8AxQibQ5ZLmTgYRqPTXMe/0GCP
         nfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001076; x=1795605876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTu2kT6vY540i2vTNL/lOCMqwCzR7YfsabNtoI8JhQ4=;
        b=K8ifo80UoIvv9QVa9q0P9a4LNna292S4OEm3KKHZqg8uBxRjyEQiiD7vdHfI1Ds/f6
         Ty2ax84a2+lbyvF+LnBpCu998JjL0PkBmwjVAdbtgVCWL3yi/FQ3cImFtXc92UmT2dfB
         DNS86i3c6/UY0kCq4dfHnlm+Jebwlf8XGPySF5KzNsOKcR8NLgazCE4aG8WY7MaqW5Fp
         d4JD9q8vfi1U+SAez6wC6Sb2s1iYnUs+JW6Flkhs/4aLFrv+SHHip78xyC8h9r2gNqAu
         JsWj9S5MCdjBPHxqXN3usJeuEblfZgENsZZfdJEGVt218QnxXQHZshbf1nIw6QM7c1fp
         9WDw==
X-Forwarded-Encrypted: i=1; AL+hErFGOrinlI02CaPEaqO4ol10iZNsvvOtBzlATKyYX57SWG1mTt3pwLbXAc1TajbgsqhHpwzbcQeeTDuv7cI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9vG+HKvs+aEmhb18x8Rkrl0W9aHZ6RqCPUFPyDOJ+MpUmzr5YK
	Oqdp/LUv4FMOSGsnfugnu16LX4NulKju3Hf9hELsoAu7Ncwojqw+TJT5
X-Gm-Gg: AZFdTZewX4EPIOfjZIOt2cYmjU6CGdHD6kMkwbqUv8d+5NMHEtFHYpqwlZ0dDVWIHia
	moihI38VMNRbcbHF7T7FiMNAeWkQPP5J5nmwyVVUtVH78jHAHxeMA0xtxXt++rcD2ymcFy514oV
	Sxa6hVJ/t/S/2VZ83WJypL1yJxDoF/v4h6t0F1GsNj5IBRF2NnEASChTdzT35aUh2q/opW/sEND
	S65CAJ8RST3yIEZD1MabT+4h/7pQd9C0VOnarS6Bc/IW+uEEq3+/OTVhcXLl+FqF2oJINO+fHna
	A5rzSEBbWJDIpsnfV49odbouhqF+LBTsYVSuUFC4LQRvYrGDOTVO+UNQ6juxFiEh7gkBlXc+VxI
	wD/8lYJqzfXUFCG5Toa/7EU5GzEwNthgTCZeI4ucIb5S5BisZjmqAJAxh5TKzeKjccF9dg0fr+0
	2Q8C80v1Auo+rX6uHJLBtiHJS/sxuGE4v3Sf9AwwpCop1AwHodaUm8uPAkN+gDYAYzCg7f7m3kr
	NqneToOZPI+Ye0w+d9TPgFs0g3S2C/eLpGz2PdnbGY7fgdwp4mOv7OIl2RlNc0Nv+nhRWE8d7JY
	xabMdPOl6X6iCyyTkJ2iDp/tWXFsxGAKP3l4QDjxPqo4BnMPCQ==
X-Received: by 2002:a17:90b:4d04:b0:3ac:8af9:4a77 with SMTP id 98e67ed59e1d1-3b3d07597a9mr1914378a91.10.1795001075580;
        Wed, 18 Nov 2026 03:24:35 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62842b6sm11510395ad.60.2026.11.18.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:24:35 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] tpm: ibmvtpm: don't call tpm_ibmvtpm_resume() under rtce_lock
Date: Wed, 18 Nov 2026 20:24:18 +0900
Message-ID: <20261118112418.1009785-1-hj351016@gmail.com>
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

tpm_ibmvtpm_send() holds rtce_lock (a spinlock) and, when the hypervisor
call returns H_CLOSED after a Live Partition Migration, calls
tpm_ibmvtpm_resume() to re-enable the CRQ before retrying.
tpm_ibmvtpm_resume() sleeps (msleep()), so calling it under the spinlock
sleeps in atomic context.

The in-flight command is already serialized by tpm_processing_cmd (other
senders wait on ibmvtpm->wq), so the rtce buffer stays valid without the
lock. Drop rtce_lock around the resume and retry.

Fixes: eba5cf3dcb84 ("tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 51c7e2add3d2..e06c4db2e138 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -247,7 +247,14 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		 * ibmvtpm_send_crq() once before failing.
 		 */
 		if (rc == H_CLOSED && retry) {
+			/*
+			 * tpm_ibmvtpm_resume() re-enables the CRQ and sleeps,
+			 * so it must not run under rtce_lock. The in-flight
+			 * command is already protected by tpm_processing_cmd.
+			 */
+			spin_unlock(&ibmvtpm->rtce_lock);
 			tpm_ibmvtpm_resume(ibmvtpm->dev);
+			spin_lock(&ibmvtpm->rtce_lock);
 			retry = false;
 			goto again;
 		}
-- 
2.43.0


