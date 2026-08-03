Return-Path: <linuxppc-dev+bounces-25314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B5CC55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:40:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDY8P6p3Sz3080;
	Tue, 04 Aug 2026 09:40:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b135"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785800453;
	cv=none; b=F1pkBeAMDvSKCd+9RwFAy4i1CVTiYoUoyNuEnNrDfttsmQ1Gj60yYkpWXjFp1nKDbFbZhkYGJvCvfYbc68NOLa0PUOYaQPVT8oombBlnFxVbBBj6+HWSDfzzQRdCQ0PR/lKucK2K46SKVaYij4MWcxE02xXrmd2W623IHa2VICELR9xPFGWkoFkLSwjI2dUAk6+JnQlmzE+LQibLJGsA0an50JyAXELbYH7WLSr0E1t8cVTUtByj0TkoRf3YZlwiIMqt1BjTLf+DyocYshsbxpzT8n6sdpj/Mk0A4ywauMlagM3F4tLXUxNmQMYWCvaKESAJ6C4diD4h1vNuFbe9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785800453; c=relaxed/relaxed;
	bh=iXt2lHl6V6DYOxKrsChpRVwvJNwCDOvF3knLtupIoSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6L0J4lMcPaJoV4eCxwa9u6mLJK/gDHbUXvMBXvfxvc2JCOmGP1uJrv2Qj+jNPA+gi4og8RDSonhQXiWdEbb/ZGqZq1bV7xOqAyejpG4DSLH09y/hugqTqVLNiGlauR/EAC+o8e2hngSwIQfmtdnQ0Bo4g8cvSjg0Y5UIFm8MIePGqs9qyiCIYBe7qFh8SUsZda31xjxxFp86JQGCtWnaAw7d58FGO6E9NECBhzxf2/VHmZ+4PgFh2iTwUOyeCEdjJlm4k8+hK2IDD4OUju5l/vs/GIrlGOdYmj5ZK6X4zLRScVl6G6T4K2gztIUua1apVAhTtjNNOA6De5vmRQz6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cD3MEx9J; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cD3MEx9J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com [IPv6:2607:f8b0:4864:20::b135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDY8N1SY1z306N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 09:40:52 +1000 (AEST)
Received: by mail-yx1-xb135.google.com with SMTP id 956f58d0204a3-6682259cae6so4003422d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800449; x=1786405249; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iXt2lHl6V6DYOxKrsChpRVwvJNwCDOvF3knLtupIoSg=;
        b=cD3MEx9JhwiExDeGzO1uv5eGA0P4CdpPlq+OHH5r2E2wsR1j4uVX3b31G2lOGg1O/B
         XHIejt4Uwl3pr8FbkCgo+G+LXnP9YjJO6cc4Lq2+vcJVcEUErExBg1iyH7skrgH06MaG
         6uNcqdO++UfEPKPPmiijN8bxAxw58/mz1oKyaWbZWokFEEeZZ60OuL6MtYruruVhpa5h
         sagfq7jqUJRLYQbHpkYHW8iIJGvr6/2MRXGT5qY9myct6Hhd0T1BkR5X8EytWeCMi65c
         NHLo7TsNsS3Uc9kiCvYWmXcxy3AL07fgLqoLcpJV4Z+Uj2Z77XeHiJDhG51jTy3w9639
         Bu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800449; x=1786405249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXt2lHl6V6DYOxKrsChpRVwvJNwCDOvF3knLtupIoSg=;
        b=fvifGUrCkJOrvA4v1AVLuPqHotCtbuaBqbNyYc2ELIz/NIWXuOHc4WmSJOqcVbuhWg
         MpqTdqsnYdrB8w+EZfN0N3hjOGDJVth2e+JBmiLj/UDVXT7k7g6Ab4btYBvYDE1ZIjrq
         BSfysp13NtNFZrvzC3V5UBggwSeREM7S7sIUMRMhNdvhy6Ox/G+DE9RGoN0iVeTzOurT
         gy8R2WldUa1ZqfVvHEt6/VMFhcHLGwEkR5jfKvlj9mySilrp8uSuusOIY55glnPm1KML
         2Nb/FXB/+lJ9ILS+bgxiyoiJfgNC4Mho0N8CmQeH8d88fUrMT8ELLfNZbsutLkPXh8Du
         JLvg==
X-Forwarded-Encrypted: i=1; AHgh+RqViwxyNN3WV/gAUneZJThvh9oB7AkZIlwVRpy4lNAUZ8QIg1QTGErNWIstgwQpXA5G4GMoT6+IQNBQHAU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzOpOvFZlDZ7xSo34epcNid0Ua7KKDOqxvIHKCvg+sDnqqmeSBQ
	bvT8eN5Bl3zRsyYl0eJXsMFbtWzf/pP6U0LPnGoAVswTcTNmpWgpemyM
X-Gm-Gg: AR+sD11gxef3pjPU+N42T0Xal3g3/Zlxin4E5+xvYezuMC5/1cphzxgoFs7MmMe2/4S
	IzfUc3nhxHg390G4gPD9ydTvpG6hBLpz5sLozFF4sbUav2y9VWHLdhEWXO1Xzy4Y6N3CW91ZFl1
	Uk7XZyzZOIFSZwpOOrkjuFelTqCycobrj/D+8AJHJx/HvDYCfCyxSXEWAPUbuoS7OHNnNgqKecN
	h9ApYeQv/ZynjyA5X+MoLuinnajWoeLagWZXV6rdWA6d5iU2f8f8bKInGI4EjLjiMAZJa2J6sqV
	H7635ssrx1xbQeWvM2WDHAcac2Y6BQFACeuUnN+1xYaRy1CJlkaeSVCBEmAsdNpssWiCwbshYie
	mC+bU8eDLlejiRt6v2Mqo34MKopKPpRMYdmajvUxoxIkELgOBp/DxSazeGYftHe7zGm5+3Qanqm
	jABhv/8B07Dvt4Q5Gtbk96eT5P8S29DZG0px2Qu/5c9jMyklCCIqj2HHvTsmrpT2p4zH71+jA=
X-Received: by 2002:a05:690e:480a:b0:668:8f89:762 with SMTP id 956f58d0204a3-6694efd03bamr9722268d50.1.1785800449430;
        Mon, 03 Aug 2026 16:40:49 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948b98babsm6681712d50.0.2026.08.03.16.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:40:48 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 03 Aug 2026 19:40:45 -0400
Subject: [PATCH 1/3] alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD
 unconditionally
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-alpha-fp-exceptions-v1-1-c99d75608e60@gmail.com>
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

ieee_swcr_to_fpcr() converts the software IEEE trap-enable and status
bits kept in thread_info.ieee_state into the hardware FPCR format.  It
contained:

	fp |= (~sw & IEEE_TRAP_ENABLE_DNO) << 41;

FPCR_DNOD (bit 47) disables denormal operand traps: with it set the
hardware handles a denormal operand itself, treating it as zero, instead
of trapping for software completion.  The intent was to set DNOD when the
user has not asked for SIGFPE on denormal operands, but
IEEE_TRAP_ENABLE_DNO is clear by default, so ieee_swcr_to_fpcr(0) always
set DNOD.

Instructions built with the software completion suffix therefore never
trapped on a denormal operand.  The hardware silently substituted zero
and produced wrong results, affecting every program compiled with -mieee
and default FPU settings, glibc included.

Set FPCR_DNOD only when IEEE_MAP_DMZ is requested, which is exactly the
case where flushing denormal inputs to zero is what the user asked for.
DNOD then encodes MAP_DMZ, which ieee_fpcr_to_swcr() already recovers
from FPCR_DNZ, so drop its attempt to recover IEEE_TRAP_ENABLE_DNO from
DNOD; the DNO trap enable lives solely in ieee_state.

Both functions are in a uapi header, so the encoding change is visible to
userspace, but nothing outside the kernel is known to depend on DNOD
carrying the DNO trap enable, and the kernel is the only writer of the
FPCR.

This must not be backported on its own.  Re-enabling denormal operand
traps exposes a second bug, fixed in the following patch: those traps
usually find an exact result, and for an exact result the emulator did
not write the FPCR back, leaving hardware-fabricated exception bits
visible to user space.  Taken alone this change would make spurious
exception flags more common.

The bug predates the git history, so there is no commit to reference in a
Fixes tag.

Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/uapi/asm/fpu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/fpu.h b/arch/alpha/include/uapi/asm/fpu.h
index cea9eafa056f..d28dc36786e2 100644
--- a/arch/alpha/include/uapi/asm/fpu.h
+++ b/arch/alpha/include/uapi/asm/fpu.h
@@ -101,7 +101,12 @@ ieee_swcr_to_fpcr(unsigned long sw)
 		      | IEEE_TRAP_ENABLE_OVF)) << 48;
 	fp |= (~sw & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_INE)) << 57;
 	fp |= (sw & IEEE_MAP_UMZ ? FPCR_UNDZ | FPCR_UNFD : 0);
-	fp |= (~sw & IEEE_TRAP_ENABLE_DNO) << 41;
+	/*
+	 * Disable denormal operand traps only when denormal inputs are to be
+	 * flushed to zero.  Otherwise they must keep trapping, so that /S
+	 * instructions reach the kernel emulation handler.
+	 */
+	fp |= (sw & IEEE_MAP_DMZ ? FPCR_DNOD : 0);
 	return fp;
 }
 
@@ -116,7 +121,6 @@ ieee_fpcr_to_swcr(unsigned long fp)
 			     | IEEE_TRAP_ENABLE_OVF);
 	sw |= (~fp >> 57) & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_INE);
 	sw |= (fp >> 47) & IEEE_MAP_UMZ;
-	sw |= (~fp >> 41) & IEEE_TRAP_ENABLE_DNO;
 	return sw;
 }
 

-- 
2.54.0


