Return-Path: <linuxppc-dev+bounces-22652-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C09CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:26:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfFqq0zn6z2xSb;
	Tue, 16 Jun 2026 02:26:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781540791;
	cv=none; b=fzEf40uhpwncd228qWmwlCs38WtXWmjhTGuBKHlQKzu1LfP5e/DNwLuKmno0rSlYth0q0d+c3ME1FZwsvyUaTSrV7hJBphiHuO0roQfekQg2gmFLBUVX5FYFDxixjefxuw8UYrSk+cdcqHPzGSCz57CyZ/TNNdCq+O6jkTrhB316SnaegRQwuj9jGKnkFUjCDHkAswhVsLyE+Aq5Q46sAF696VsAOG7uqoY/viMjVsq5VxD1/dNrnz8NrVl8hM9+PyM6rRpVFokWZfJJUWOxC9VDY+++KoYPnrbyCPxHbpThT7hLPSXWAJcP4e/p/MQNvuvzbU9MHlHtEpqK014zMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781540791; c=relaxed/relaxed;
	bh=/kq53XBMXwwpeWSUuJdvcoCP4keKFn7d1L/6qu3gGAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8gINwBwPHRpjW64k1JTK7So3X6P1Y/7H1MuoB6OihQTFp38hn/FZI8miDaHrVcNmmSeLi/JG2kEmX68eMSivMUv2CmrogvG5UnTLIds6XgMf5mnWikQMBlWaUcWVWUPN7940CT+zXWTZCaelusReaxj/hT7+IyVCJrp8vkFt99gLS/LQmKnT6yBnpHbBZJ2O3N9hF7e8QOx04KGasqNGqTUz6KXXgx2iT7OlEabvznVL/GqdBIsg0/oO6D5BFxj8yjkUBxAU0/PBT0qv1dwpenL/EShsAhkvsmn8Vrnp1efC29hSrkqzm3ziGREshXOuPzyP7s04Izl9TKGHGQk3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kuXmWid9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kuXmWid9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfFqn6RWSz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 02:26:29 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c855599a77aso1752568a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540787; x=1782145587; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kq53XBMXwwpeWSUuJdvcoCP4keKFn7d1L/6qu3gGAk=;
        b=kuXmWid9rarCsW8PjBOx3i6txrj3+dBAvtpxtLk5u3SZeHeV/nfXlnb1+1krRGT9Dh
         nIgmIMPMx54F9E13Z+1PCQ3ESX14pYnY1+adoPBkFAVbKrTe7at3KvPlmak53JWX7hAx
         EBykpCLcXdTUWvpz6NkD5wnGqLj+O1LgLttEiUL6mZ9yE5vqJ41kNOoGVPGrxreqFKzv
         8qUJko5u/1S8b3vWEufiqPWJlIndIxIGpWcIeU0zvdfX2ZiPrf3ViwYNplE63Z7SeokY
         x4lgcBu0Fc8YsJ6NpzY58vxdBef7RRGS5EuCvG0YVUYO+PRprXahh+l5jV07pnceXYX8
         1dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540787; x=1782145587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kq53XBMXwwpeWSUuJdvcoCP4keKFn7d1L/6qu3gGAk=;
        b=V2/R4tYfEptqFd86KSTJECcLASNEqAtRMkSG8ETFAj+d2Kh2t+dX7srrbqIvi8OLrq
         qgNp4NnDcGjlQOUIXREI5KCEydKQbPR6r7DKfYdu965xPzeeRaoH2zrGqoUXrA0u1QuU
         URZFOZ7AmTGzcQZc4Q5nKD7UFZl6CYRxi3o4c7hn/5T8JAH8/60rgdKNra/eAuvryQJc
         uO2pSTyvBMYpLzpebp+9ASfy8Hui1hxkVbkvQhtD6BatAMAAz/W/vK4EDE7eBwTdMrhN
         ZWpT0QIBror852vLgEMrn7tCDkf/oQ1kOfM86x2/YZt9DsoqFKsixbxaVMmTdOnrnAc5
         CCzw==
X-Forwarded-Encrypted: i=1; AFNElJ8KG1FvGt9/DVWd11LqxH4Ov/7F+oEfdW/XPKma59O1odjR41CtfY+47MQFOxOdLZ9XmeX1igXP+FSyuk0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxaMlO+sjn8H5DwRS6Y8KRN7NWg5XL3aX5KjhWtIJ2N56tmGZ7o
	BQjeLbG4PAOdm8e4Gb9k/eF5JmALAQJ4+vWYCGRgBVhCs1w0oNU0Mzmr
X-Gm-Gg: Acq92OGdafH1KEtU/rPpR0kEASiln4k8OtpT0JSw4sFfPHEXu2ueb0GGpe5kq3+8Oe5
	8PvduaYNoiCVINZkksxDG0f2zAtGTdewgMrigwklgPZHEKStxQFq+4LcK1vcy3s5cUDqcy+f8b7
	P6KfXD+3tzzZ8ssQMh4tpnAwGy7fc2KraLETE20v5a/9HH6ghxVb9vdbNBxFBg6jrT1SQ785j3C
	IFIMeuzBztzq8/YVjwQ1cU1EdnX0DUnvrtYx3Gj7W6A8SSmKyC2NHOhgjz/CNb/sw3Wf7/RoZ78
	8tUofxaGkcXe4PR397UG0TMiQ1EmN5g4ahbJmwmWPZWATA3hk1YnXbN2nQR+K87YdLSFftwx690
	s+Vq/sP+lDuiSuCKB+uFlpRTYCkD4PHH4CmoyILpBHlWNQoMPVys1IvQEhSYmEIBNKNQBSAGzSG
	FQ3U9ft7QRAOH8NR7fFTPqoYhWteVEHOemi4NI2LU31XsIOoBP8ZEbW+KEBk/YPa97ye8/rs6KT
	SbQpKndVA==
X-Received: by 2002:a05:6a21:7d02:b0:3b3:216b:274c with SMTP id adf61e73a8af0-3b783f1bd60mr17547127637.22.1781540787455;
        Mon, 15 Jun 2026 09:26:27 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651af080sm9502388a12.29.2026.06.15.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:26:26 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	sshegde@linux.ibm.com,
	ruanjinjie@huawei.com,
	mkchauras@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH V2] powerpc: Restore KUAP registers on syscall restart exit
Date: Mon, 15 Jun 2026 21:56:17 +0530
Message-ID: <20260615162617.2861795-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
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

During a syscall restart, block KUAP so that pending interrupts can be
replayed. The original KUAP state is not restored before returning to
userspace, causing subsequent userspace accesses to fault and eventually
trigger bad_access_pkey(), crashing the kernel.

The original KUAP register values are already saved in
arch_enter_from_user_mode(). Restore them on the syscall restart exit
path before returning to userspace.

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Reported-by: Sayali Patil <sayalip@linux.ibm.com>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
V1 -> V2:
- Commit message rephrased
V1: https://lore.kernel.org/all/20260613123831.1510474-1-mkchauras@gmail.com

 arch/powerpc/kernel/interrupt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 89a999be1352..f04978080837 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -166,6 +166,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
 		goto again;
 	}
 
+	kuap_user_restore(regs);
 	regs->exit_result |= regs->exit_flags;
 
 	return regs->exit_result;
-- 
2.54.0


