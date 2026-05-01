Return-Path: <linuxppc-dev+bounces-20356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21134FF8864
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:13:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Hgr2H4nz3bV6;
	Fri, 01 May 2026 14:12:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608760;
	cv=none; b=O3p45VoSYCTjUw4k8g8MgXq9OgG8qQw2e+WjAbF+6AkiZiAlJyuPJJFGNVRRl/aWiVXyFReiFsqHzWsx2fkLtSOi/z5iD5hmo/O+BRfImyc39SzNpjgwVSfHiFU3hf9u//+EQRZblEzmCD2zxruVLdTwzjUl0K3rHqF+R+4eJjRRsse8UMqw9jzKSzQZWjlljCoZ9j8ywf+P6BgBA3cnPLLyc3K0/oQP6Ua36muC/xAACZkYNdmoqKwwxN8IA80LSQ7C+neZc/NeF1ol3ycl1dwpEAgK4nljt8iEQU8cM4Nzq95cjI1z724RB3JU0c19nP5QnABIw2WeO2e5ujq0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608760; c=relaxed/relaxed;
	bh=GzTwWKu4/OMgogLdvJRN18BQXd8VP1+UN2ymsqFSQ28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDbuHMgIkIJ3L1y3t/ELaF4WoVT+ZcdbfUnr3cpTZa2H943V9YuqG+PRrBkMGMfc5BBZ1mgxFE+mOo7isxIEA/g0xG8hXVP12nStUnDmzsolguMXr5kLCWNh1UH1ReQIQxL+/4amMraoAAAh1w2ulSmIV8ZBsZd9Ac2mIxiyrq8jDMbGSnsHlsXXUWHmGT0GYxY3fH6mUpkjDc4iR4kBxPa/Z7FJve249aQbvAabWiyLqXIlLamEJJRSP63d8I28VPuumWP0t6USuSsVa2niRd37in+rHJHFbiyvEVfGGeByIiJ0KmsPh9Po0o5UdKVz8Lb9I8hTMkvTGABYeu9vhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SJpvlPnY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SJpvlPnY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Hgq4dgJz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:39 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so1806172a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608757; x=1778213557; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzTwWKu4/OMgogLdvJRN18BQXd8VP1+UN2ymsqFSQ28=;
        b=SJpvlPnYkKou1+bNCLHUgKTOldkDbWnBZ3meQPGcaKmrf8v2LeqLcNzr7BX9zJouXF
         mDKnIL4ntW+ItVf8XBmBf2CIkmZDBlQIBVmKg+mEJdUZcoGUMVXk5LqChJLl+E4KB++W
         RZut+4JZwOj+/gydJPZ3EdZ5i0gaI/Ps3M3sr+nowKfI+82Pk+uPE/8oZQ7d0ATySwSN
         2GcYEaloqzhH2huS5b/0o5A2KAbTb15vEEntzgr1TcNUoXy627rt1YRYrhACgmq7wIwU
         XUXyuMtv/jsm8Dyw1mst/EBioFvEdtoOUDPJCHkVCXt6qAVzhwQY9ZisjvHV+NKzWQt7
         n+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608757; x=1778213557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzTwWKu4/OMgogLdvJRN18BQXd8VP1+UN2ymsqFSQ28=;
        b=kLeU3Qz90iwoytKJaddhyLKuzC0+//MmNRp/wevqVhRpS8f1nXCTnqquCmenzvwSoX
         lgAAcfVCFAgmVcbxyF7n6rMsCkJXjddeQ7nRpeRjpixEKvypwneUjaKxKgRtoSGSlByu
         sBdAc5UhxmBdDpSDQexdC8kZ+zTQajQW+4H+SIMzKXkkE+OBSDVMN3iadLBPC5PF/PX/
         mQLHlvHtH53WR8S2DSKtODwYzWQnoS9IuEJrnBs8yk/i4hqye66kj95rZs5s7LoEcvsY
         cBEmOvz69bDbzCCn1Z9npNA53OlTv5IpHDktOPsMhPl0VXnTpdycvcTyH2HEeUkpBKna
         z02g==
X-Gm-Message-State: AOJu0Ywo4LyfM59RDYElBgEmPNNHRgmf6Fm4T/xPGfitwoX3HpdStzci
	7xziSurDgkEiKSdVFbDRCdIqe3ErDzZsAfqljC3IgE1XDeIZOj6nC44+eTZu01z4
X-Gm-Gg: AeBDieuoeX+zsUBp5rfhop8tDiAE0oKNUhKMg2Uxb7v6XPqOReda5x616jcH1ODeVEX
	MeT2UP0IotWSyXP7pPeAV62TfpN+ngULMYrc2qmowaBmnYaLk51gRLxTyXNi7Ma0+9P2qfFaQ3P
	4euPGjv1Hi9tHXNPMvgNH3muIrzJZk9ENRAfdkIWKSrnRNcaUyGpa163xjEKg8nifgL8bzsHkln
	vyMoShFY5z8bN+zsW+jfUnaXokyx3wqK5hVHfiXHHF1oKNKc9/peEGNQ/CWSILZLuTVbIaRqZDi
	VqrUtVWEalySMA69dOZYqiKJ87vddd5uG73bTOy/gjAN9ISgs9vxbEuzsjqU16iuwErVerKzOcf
	i4ZGPTshHKULOlqWOgjApMzrujbVmt9hbHT4WBTX4O+E0sDrJdceh63ytPjyIk9pAXipDwptv8r
	brivnL6gTKrRTP3JMpY00h3U1bgI7L2KoWGpzaDMKAF2re71jCcSkvop4nnv2h57k=
X-Received: by 2002:a05:6a20:2444:b0:39f:a42:9247 with SMTP id adf61e73a8af0-3a45fe026bbmr1846152637.37.1777608757090;
        Thu, 30 Apr 2026 21:12:37 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:36 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 5/9] pseries/papr-hvpipe: Fix the usage of copy_to_user()
Date: Fri,  1 May 2026 09:41:44 +0530
Message-ID: <8fda3212a1ad48879c174e92f67472d9b9f1c3b7.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
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

copy_to_user() return bytes_not_copied to the user buffer. If there was
an error writing bytes into the user buffer, i.e. if copy_to_user
returns a non-zero value, then we should simply return -EFAULT from the
->read() call.

Otherwise, in the non-patched version, we may end up mixing
"bytes_not_copied + bytes_copied (HVPIPE_HDR_LEN)" as the return value
to the user in ->read() call

Also let's make sure we clear the hvpipe_status flag, if we have
consumed the hvpipe msg by making the rtas call. ret = -EFAULT means
copy_to_user has failed but that still means that the msg was read from
the hvpipe, hence for both cases, success & -EFAULT, we should clear the
HVPIPE_MSG_AVAILABLE flag in hvpipe_status.

Cc: stable@vger.kernel.org
Fixes: cebdb522fd3edd1 ("powerpc/pseries: Receive payload with ibm,receive-hvpipe-msg RTAS")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 23 ++++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 800649f309a5..c007560d2d8c 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -206,10 +206,11 @@ static int hvpipe_rtas_recv_msg(char __user *buf, int size)
 					bytes_written, size);
 				bytes_written = size;
 			}
-			ret = copy_to_user(buf,
+			if (copy_to_user(buf,
 					rtas_work_area_raw_buf(work_area),
-					bytes_written);
-			if (!ret)
+					bytes_written))
+				ret = -EFAULT;
+			else
 				ret = bytes_written;
 		}
 	} else {
@@ -328,7 +329,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 
 	struct hvpipe_source_info *src_info = file->private_data;
 	struct papr_hvpipe_hdr hdr = {};
-	long ret;
+	ssize_t ret = 0;
 
 	/*
 	 * Return -ENXIO during migration
@@ -376,7 +377,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 
 	ret = copy_to_user(buf, &hdr, HVPIPE_HDR_LEN);
 	if (ret)
-		return ret;
+		return -EFAULT;
 
 	/*
 	 * Message event has payload, so get the payload with
@@ -385,19 +386,23 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 	if (hdr.flags & HVPIPE_MSG_AVAILABLE) {
 		ret = hvpipe_rtas_recv_msg(buf + HVPIPE_HDR_LEN,
 				size - HVPIPE_HDR_LEN);
-		if (ret > 0) {
+		/*
+		 * Always clear MSG_AVAILABLE once the RTAS call has drained
+		 * the message, regardless of whether copy_to_user succeeded.
+		 */
+		if (ret >= 0 || ret == -EFAULT)
 			src_info->hvpipe_status &= ~HVPIPE_MSG_AVAILABLE;
-			ret += HVPIPE_HDR_LEN;
-		}
 	} else if (hdr.flags & HVPIPE_LOST_CONNECTION) {
 		/*
 		 * Hypervisor is closing the pipe for the specific
 		 * source. So notify user space.
 		 */
 		src_info->hvpipe_status &= ~HVPIPE_LOST_CONNECTION;
-		ret = HVPIPE_HDR_LEN;
 	}
 
+	if (ret >= 0)
+		ret += HVPIPE_HDR_LEN;
+
 	return ret;
 }
 
-- 
2.39.5


