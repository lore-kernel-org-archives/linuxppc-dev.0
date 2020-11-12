Return-Path: <SRS0=rG8u=ES=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057E9C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 11:00:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAA62222F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 11:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNdpyV7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAA62222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWzD417D0zDqwf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 22:00:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::441;
 helo=mail-wr1-x441.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HNdpyV7a; dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWzB421QpzDqnB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 21:59:03 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id p1so5488895wrf.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 02:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aXOen+8cDvbkQAmhP2VMdvcfueqQPLwH4EHxkqna6XE=;
 b=HNdpyV7aDMczpSDYYNSu8DNyhoanVHdWF1+iMlkeFlWh8Vi59qRbIegaCiJEg7OOYz
 xSOUwM0NQpPHvI10pnr8hkHKkDAdqqBELcAONBmn3UHa61X5sthGM/R0y+SyhtLNPm+E
 gYNiSVovf3bxP2Sa+f1d/PuirJ/qykAjg4kL7LZHruOUvaUUzteXOrtfhanbTfbEm8VQ
 0fiBodMQHy9765SqRK/9bYJUs95xz2kDzfxaLdQchH/N/OEEMM6+/UcgaDAEp7miafWO
 fC2wo+XZMJZNZq8Bwuc4oMFKKhms4XevqlSWLwz5f4ipb20k5qAlS781pND0kvpyLA5i
 1j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aXOen+8cDvbkQAmhP2VMdvcfueqQPLwH4EHxkqna6XE=;
 b=uEL23LtZZFAOGUjN4E/zse+tvh2SnBveO76268RiYzu+LgWIjbgusCTR1i6jahrpRd
 D/16qtydpLRxMWeIqbHwSJW6iXyTuCMCnOyxb1EpTYSYvw9CHVEyVhP240DOlmzTs4uZ
 63rWn2mIzvczWEIroaAz9qaLLbvhJuHwRuAfx9In/ZiAXBytgbGv5CNKc508CFEeX1C+
 6GZEp8nZrZwNVAyH6G9r33YW/Pm5IzIudjVlB78h9zTVafvmDU0fKH1DyhtCxnRRSjUR
 995SMukEm5dNX6J8AxLcQJv9wF+TeJNlp0CLPzQzRnE8n03NhITa7cMTZDb6RI79CIeR
 qVhg==
X-Gm-Message-State: AOAM532OOewXxF4lTTDmYdMJg3YOYxhNOJnl8OqOxqvuP5JciPL/ZVVI
 dBUfHUp4+1yFPiDWWfHNVTfI8A==
X-Google-Smtp-Source: ABdhPJxMBmN1sLHdVutKtUTzgvWnLK6EqMEP7/1MvsJFyNoEdtMm76qKxyP2yshYdjDAU3getCWXPw==
X-Received: by 2002:adf:8030:: with SMTP id 45mr34391429wrk.407.1605178740741; 
 Thu, 12 Nov 2020 02:59:00 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id u5sm1167239wro.56.2020.11.12.02.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 02:59:00 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH v2 0/4] Rid W=1 issues from TTY
Date: Thu, 12 Nov 2020 10:58:53 +0000
Message-Id: <20201112105857.2078977-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mike Hudson <Exoray@isys.ca>, Jiri Slaby <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

v2:
 - Remove unused variable completely
 - Remove unnecessary 'extern' keyword

Lee Jones (4):
  tty: tty_ldisc: Fix some kernel-doc related misdemeanours
  tty: serial: 8250: 8250_port: Move prototypes to shared location
  powerpc: asm: hvconsole: Move 'hvc_vio_init_early's prototype to
    shared location
  tty: serial: pmac_zilog: Remove unused disposable variable 'garbage'

 arch/powerpc/include/asm/hvconsole.h     |  3 +++
 arch/powerpc/platforms/pseries/pseries.h |  3 ---
 arch/powerpc/platforms/pseries/setup.c   |  1 +
 drivers/tty/serial/8250/8250_early.c     |  3 ---
 drivers/tty/serial/pmac_zilog.h          |  8 ++++----
 drivers/tty/tty_ldisc.c                  | 10 +++++-----
 include/linux/serial_8250.h              |  5 +++++
 7 files changed, 18 insertions(+), 15 deletions(-)

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-serial@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Hudson <Exoray@isys.ca>
Cc: Paul Mackerras <paulus@samba.org>
-- 
2.25.1

