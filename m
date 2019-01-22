Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07BBC282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 07:43:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDEC020854
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 07:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oIIzS7rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEC020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kL5H3t0JzDqP9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 18:43:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=clabbe@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="oIIzS7rM"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kL3S5K5NzDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 18:42:10 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id v13so26103332wrw.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 23:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=3q+zgz6TINUxYhFX1orF5+LYZH6pS39Bhg/MHhk1L1o=;
 b=oIIzS7rMWpoMElcWe0PrZB2F4IUehKPk3t2bLeUHfJFqwbH4j1IlQfz4mORdU53e/T
 GRPmx+oHjQGPmvInitOfthq0mKScUFy+Vw9lDH65laQxCplcUT3wTlUTBAEoFahMtCeu
 PTzrhaOmRdoLbc3VCDFn+yO790V8VcJcDnzZ0PP4FEzVbvfA9kHPbJKVuSLMJYr7JvZn
 W4RO2YzXHwViW2H2yRIz5KgE7+lMdLipknPjhcNPzlX6sl481RCBf0oveUTjVEi0RhyB
 7QDl+iM0gUJlp6gFTxA2lr26trRIA1wstVKbYTcvj8sdmQc5VJC3CRqzypUTlDDylitw
 jntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3q+zgz6TINUxYhFX1orF5+LYZH6pS39Bhg/MHhk1L1o=;
 b=iTfeC/l69J2InKvxqtDEFAdzwe1fTBDqBZT5KqOOwoIZYC55AHhbBwWYqvsg+a1pe7
 cHViD27zVb8lDKW70egiAVh9AVHmpX/znstlI98Mvt5D0CV5voBdSeUHW8GBSIYHS3ov
 Mut4fuEH5Fb0P04P2h6jFMb0J5UAnVFmIBItK4Syf2R7XrOe4SCzvBIRlxtWpdpzYkxF
 LtbhO3LkSm4MvuWO4biiS7WfzHCcKAODeV6N9GhGtYECrBrN8SoN8IvXHaDmRvAOKys6
 S326iicfkB3rj79bxrN9u4iRxqJlfaUE52KnpBs7GQEo6awbpvbiU33B5ljYhN9WPhA/
 lVbQ==
X-Gm-Message-State: AJcUukcceCd7BOMSllRk0y9hhhI5ihNLS26qVTrQqC5itYoqXRBOkztQ
 hxG/keseGlSElvUNtdQQaN4lCQ==
X-Google-Smtp-Source: ALg8bN4B/ztsU9j5CtXhKggmiW6wHQvc8WNFHrUXJarGtzUhan47tiOp+uFAv3G/aBbYul59ySIscA==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr31211145wrn.89.1548142927945; 
 Mon, 21 Jan 2019 23:42:07 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id t199sm36969294wmt.1.2019.01.21.23.42.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 21 Jan 2019 23:42:07 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: benh@kernel.crashing.org, mark.rutland@arm.com, mpe@ellerman.id.au,
 paulus@samba.org, robh+dt@kernel.org
Subject: [PATCH v2] powerpc: build virtex dtb
Date: Tue, 22 Jan 2019 07:42:00 +0000
Message-Id: <1548142920-11219-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I wanted to test the virtex440-ml507 qemu machine and found that the dtb
for it was not builded.
All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
COMPILE_TEST.

This patchs adds build of virtex dtbs depending on
CONFIG_XILINX_VIRTEX440_GENERIC_BOARD option.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- squashed the two dtb into one make line
 arch/powerpc/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index fb335d05aae8..1cbc0e4ce857 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -4,3 +4,4 @@ subdir-y += fsl
 
 dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml507.dtb virtex440-ml510.dtb
-- 
2.19.2

