Return-Path: <linuxppc-dev+bounces-20357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33514FF885A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:13:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Hgw2sjzz30DX;
	Fri, 01 May 2026 14:12:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608764;
	cv=none; b=P8hUeu3Y1cyoG5fCaI1DsL2FICVAkeyi6pYswZM+E8xjxavM4mJR1fsr7dgA6mkXJSzDSW1pE324x9nfUkGUZoTwZbo477mb5xcUvKR6aQVfE3YzJh/VbraIfmV/eB6HT1vrZnvm26gioxy0dYEbATORi4OCb1mVVUYoq5a3UBEK2PwUWISFjisuFwmC2cTKFAtMbWG/zPOofXmACSLeZLBphca9PKm1PyJK4s5rFIJJ6zZO9J0FxAWSjJMEUjDu0/NrH8dhjBxZtufbeKPd65C04jOPYbzNr+biFEKal/dj0aSnizINjHLM832qbXjVBFePFHli2RuxZw03VM3LXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608764; c=relaxed/relaxed;
	bh=QbcA+KKAK/mlL4ebrP1t22eLmSo5X81zXX537Har/90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI6JpWtILNK4Us3nhxVJ1IjE63PkTKD1idxdkIiskQl4lgrWkHRG03tZpYHcZWrjExcnR+dNZBUx003uowQG3M2Qz800cAlJ41/lShwWamxochQdwysAvsQgPfcNyayOJHhx+qpt1cob4ycRNJk3v6ZdjZzFwUmv+KeS7BvfYGASfG31P8XEuD4csh35JMcelCEkLk7TGe7AQC4lUvHBNinstqJ6Exr5XFocqM2s8Afp2+bBrAdg5zG0hIL0JYaz5hXMw+XsL02rmtozJ4viN/+6zPA2zT9dko+gAoZj7ZmD0hOwwfmtc08tHUvyQ3l60AEg/H6pw2nZjsMjk+PekA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c3t8by6T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c3t8by6T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Hgv5Hj0z2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:43 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so616768a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608761; x=1778213561; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbcA+KKAK/mlL4ebrP1t22eLmSo5X81zXX537Har/90=;
        b=c3t8by6TQimW5gz4uPaQmyP0pjs4ujJT1crRCyIXje064wRikz+/mxrR+2mLuXZ1GP
         MjKCoc0dopR6IixqSSggcET2ljpGrP0VIHokN2Bl4spGhswkw3H4WGe34haEX2tVmHtd
         Oyxm7XEr0cplg98LNTJTyE4cVQL/ys3YCRU+qpWbu/TFK9QwmEymY59/flowZV/0YQgC
         YMjI849SR+cQuT0VsT7sEE1CHpcb7VJqnU94zr+a3ca2paTErTGeBYmVsNUEpJ7oWW8i
         fLHr0HgmmOWOZa6qOlWkUtxJWFKOaudcEC8TxrlpFBxz3gkYWjTuXIkMU7P5LPJ3mxcd
         /4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608761; x=1778213561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QbcA+KKAK/mlL4ebrP1t22eLmSo5X81zXX537Har/90=;
        b=JzRZv8XT9S/jDoWYosccDnitLKMU6iOM/fOk5UKQBGAPYZdPu0l+owvOsKIPIV7Rt6
         iNreW6KxKiyH2qnAQdpAMXGBtabYOM8/VPGjkLO6W1ejhAH2bXrPC4peidDtM3Ne2mhJ
         KsnqeptVeqt+hgBfJunHHe/6vZ8Q4PEOjKe5lD5+tvNCywfjNbUYmzibOrM5oUPBI7nT
         oN1b6m0jjQ5LqUuebTlrojsiQLlfBhdYUChzvT3IaCVy9xo4H40trUYo7MmUQZGnEEe8
         R6RQ+CvbyMCW9vF3k/rSuU26F9tD9UFIXIdi2GbYH+uDTpiQcZ9jucaU3MXhMEL7+HUm
         I0dg==
X-Gm-Message-State: AOJu0YxC7LMI2TeNQqcOGZR3/pKnv+YTaUqRUjoDz/44sPunr8QA7XrR
	6K257igtFuhbhve72m/Y+FA5ro2908BBHxjxyJKCXZUP4ll5limw2NjCtpTneO3u
X-Gm-Gg: AeBDiesov+m95SsJ1IyhPG+OhJ7ey2zhK05ouxPWDuhi2yq6UHCKCmMZpTLrvHSyGjp
	I2nsRQEubntMDQKKjO75ThFeTtErT+WyuhwQh6UeHsSbsfIgia05VawgD7scEk0G8FK7c97RgnB
	0+C+bW2MeMJCXY6fe/0J1PvLw7ucMbsTDr3R/ZT/gT3hW3y8qf+652MxRHNY1rY99B2tP7BzlUo
	V+TBoUBn871/X6YXc1M+GhXFsLz8szXzZRnPU7YGJpoLBmAKGpJIRbs1tGBdKZguml/U4w9tmjI
	7++O8aCxJOzoPQmS4lNMPQxtoZPRMEbx8XyJg4K/1dPoftmNk7ybIlFsw8dSlZabikPSt3jB4yX
	yx7n3AUBJnmdFq/FA2/ZMwx/Du/fL1Sy8QpnsyP5idCiqZnaLJSdAyPPb/7eFBhwQ5kGcGgGZVZ
	ESRfhykzAbOml48zS04mBIb4jyc+pQ8w2mZSa/i7IoP9v+92k5CHzhiBfQnOP7TAc=
X-Received: by 2002:a05:6a21:33a7:b0:3a3:add5:7bf7 with SMTP id adf61e73a8af0-3a3cf68979amr6497104637.23.1777608761081;
        Thu, 30 Apr 2026 21:12:41 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:40 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 6/9] pseries/papr-hvpipe: Simplify spin unlock usage in papr_hvpipe_handle_release()
Date: Fri,  1 May 2026 09:41:45 +0530
Message-ID: <4a980331557af3d10aada8576aaa16cddc691c65.1777606826.git.ritesh.list@gmail.com>
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

Once the src_info is removed from the global list, no one can access it.
This simplies the usage of spin_unlock_irqrestore() in
papr_hvpipe_handle_release()

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index c007560d2d8c..5aa37f6ad8c9 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -460,6 +460,7 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	src_info = file->private_data;
 	list_del(&src_info->list);
 	file->private_data = NULL;
+	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 	/*
 	 * If the pipe for this specific source has any pending
 	 * payload, issue recv HVPIPE RTAS so that pipe will not
@@ -467,10 +468,8 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	 */
 	if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE) {
 		src_info->hvpipe_status = 0;
-		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		hvpipe_rtas_recv_msg(NULL, 0);
-	} else
-		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
+	}
 
 	kfree(src_info);
 	return 0;
-- 
2.39.5


