Return-Path: <linuxppc-dev+bounces-22602-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CEACD98C5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Jun 2026 12:38:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcwt23pS5z2yv2;
	Sat, 13 Jun 2026 22:38:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781354330;
	cv=none; b=N/ugTMNcboolj8yQj2TFeFEd/K1egLjImWJ6/E24O4sJcSb31uKpDCjTMZReXtNhtdT58DyRp/tTtH8RDsVwMb+xowbuMfnrN0jriNSv94PdfAMRZrwmZjIw8VGMhmrIow2JtkHnIMWZKD5RMgqxzH6Ahy8agjL715J06LD6KqAaS5N2Qk/qHJ9rVlKLut6Jdcve7O4IfV711KMf7wLXDteUuMYdt9B041rrsYfFcQTWGnAsX+8LdMOMzUpBUVJlBi3TDV87o1hUNECsxxYCyKrYIDgvN3u6BaXYXcMf8Ub3fvJvX2Yygx4Qn/pN4M8xr18CYHGBwYAm4o6NckQhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781354330; c=relaxed/relaxed;
	bh=q/tHHsuQGXJw1mO2ZLUKrxNGuUGVVaEC8U40b9LVZ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FR2IVgeVkjmo7KohPbR/5HlFga6GkjJKsVRv2IX6bH3PviRynmgYTNOzDtJe8LvQAn04/wAcGMxuJK3w+Dh9EEz49WmzFKOZwtt3sLuyM2Zv15x4DpM21K89xc/8euQExDac7q/QH2JO1OLvuowAnlUrYck5mUzS6MOtvcgnqABkAZdDvtoRUcWg825E3Js79oFn9gcMvG+nnbLk+GsR1X1ZmF/UrPgxkZSXaH58Q4D42+xAACjcd/R5+xAzWR+qCxoiB48QS58nK6FZBHJbLyhc9+ElZg1n+kmPpK5HFzCP4NPY+J7/qkjdGeJxylFrt/QbGSuwVS69iKMTRFZsKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jsjsw2Ey; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jsjsw2Ey;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcwt114Zkz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 22:38:48 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-36b900f350fso1655483a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 05:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781354326; x=1781959126; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/tHHsuQGXJw1mO2ZLUKrxNGuUGVVaEC8U40b9LVZ8g=;
        b=jsjsw2Ey9Hwp+j1Dxbw8JV0O16hCJZR5sJAGvCxofxA2wLHSOSF+/LbSGqH4+aOXV3
         Cy6X3uR4hcwmhhxssxXzKk5Wg4TAM3sQGMwdM1kHije2gMUkINfx3nFHG9k1Lg5d6nRn
         MSgj1LxzcGRGHuPpfKFoX20s7FeFa+1RZsIhl9zzFXdbFm1XWBU0hTNIOpfZFZ3FE/no
         LhU9CESTLAWntjYV7jwfshHTbuQVqe3pCDrwe6bHKGOlBnYKM900vzceavHmONhSsiUs
         e1lvLXjny1srevm4kECm+gwxucSpIjCmwl7BWScMg2ydChW1FZKe9cNC346W17UKaWl3
         0UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781354326; x=1781959126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/tHHsuQGXJw1mO2ZLUKrxNGuUGVVaEC8U40b9LVZ8g=;
        b=NnoMB0inpX9yNCGz0+wFjE2Ztt43jDcSwlhGoTLGeqQdpeST4kJ1hJ/JuGdT8ddY10
         gVWgsSD+oBSWV0B8WHa8GqxoS5yiHkeAsJjZStlXzmAm6k9riyWjmi35xNJjFeXrV5mu
         JSNTfywtBV47OaNuVn4XebNZr+TMdcSYlNI18X3oAHM6uP+0JoNj0XDScfWCpLJwblrt
         wgzcIF2nDQO2c05AKwiWgouzFw5diXo8dTUHvzLrutZ4Ab1VFShNiivMjtA/BOXUJLi0
         nxNIm00R/UQoBcCaOmHgqN9h9LKasdnNhQG1TLiMX4k1FB2IIjNII8ijenm7tIzbeOGV
         hrMA==
X-Forwarded-Encrypted: i=1; AFNElJ9v49Gse4hEThLCF1RHkn+zOOOvY9I1v8wlvyRciS18BLNkc/jSujtiQSOuMKORJBZeRJM1n/W7NL+RX5U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywb28H78rmFzs2Lx9OAHhH3/R7jZI5HPjg7Mjz3/x1cQxTrLZEM
	KRwXjOMy2xfYehZ8cmmU24V3Y4M6TjZoTc+JOKL3XBJRTTrgWFeith7u
X-Gm-Gg: Acq92OGJOXMOGS/yq0EZOv0GyLPGrlCidOiH7r0rirXDPhMyowYnuj3qf1byTcNjMa4
	92jxAMuLWH8p9vfWmeYdqZpBMDeGZbDCEvlGfjhZURZp7Ruwz9ApGzFOzts2m+jOo+yLSMXgr7y
	Z9fjjnp18IXfFeRQ4RhXM4Md+1KbsumAU0gJ/mm4ihYu0Lcql4LUlcSlzdKC3A4uKHlxvPmR2z0
	QKbvxketIhxULApcwL92zC5+RExJlhPuuALthQIPRhdOGlQxR35zPiBpWmG7vl+SD9dblXIXHoC
	kzFhwy48cmsh7/Sb0URhS529DenpaT3Rz1h5u8yV3CVAOxsfxH1TZKeetuaigah2IseOfOWDcFp
	m3qlaY11Ab6Dy7UMafMHEYKtmIcXeH39ezBrxBWsrsnv/zezX//kNc3KzrKIXNlkRBuyzdbqiZS
	v7p9Wn6ncjXhalPtxfeG0G41Pi2WiEGOAI6/ExIkhsuoNwSshvy2U5N5Wa4yslY33Q3vEEGbAmt
	EX5
X-Received: by 2002:a17:90b:4ec8:b0:368:7c0f:ebf7 with SMTP id 98e67ed59e1d1-37c2bd06679mr3577207a91.16.1781354325879;
        Sat, 13 Jun 2026 05:38:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a237dadbdsm5292778a91.5.2026.06.13.05.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 05:38:45 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	mkchauras@linux.ibm.com,
	sshegde@linux.ibm.com,
	ruanjinjie@huawei.com,
	mkchauras@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH] powerpc: Restore kuap regs during syscall restart exit
Date: Sat, 13 Jun 2026 18:08:31 +0530
Message-ID: <20260613123831.1510474-1-mkchauras@gmail.com>
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

During syscall restart, we block the kuap as we need to replay
interrupts. Which are not restored when we exit to the user, hence we
get a fault which ends up with `bad_access_pkey` and hence crashing the
kernel.

We have already stored the kuap values during the entry, just restore
them when we exit.

Applies on linux-next (next-20260610).

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Reported-by: Sayali Patil <sayalip@linux.ibm.com>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 89a999be1352..159901d6ba8c 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -165,7 +165,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
 		local_irq_disable();
 		goto again;
 	}
-
+	kuap_user_restore(regs);
 	regs->exit_result |= regs->exit_flags;
 
 	return regs->exit_result;
-- 
2.54.0


