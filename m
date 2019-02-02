Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F5C282D7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 13:07:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AEF2084C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 13:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SclGeF/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AEF2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43sDlj3TKLzDqgN
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 00:07:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SclGeF/f"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43sDjq0qRqzDqgN
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Feb 2019 00:05:50 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id t200so8929449wmt.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Feb 2019 05:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mmywxse0Hot8Qok1gcJfSbINc+XX1/PHxykZhjM3t4Y=;
 b=SclGeF/fMtSsqWRRYr2cVkPnGKKAPYqhx8KtDXcsZ3sfKRaaEeFYgS7WbPpJQ1UcS7
 J1NLgoEed1xdzLE1FRw9+xCADRGPT7BpR8sBIzYXVZXIiSNS7guLIUHI1iX+k1MZfu37
 kFccBbBf7DhQbdUp8woaFkb52weSuf9ssF4OC1O5m5EX38n7XihtxPuORmr0Bvic02/B
 4ewekMIypjosT5gjRXC2qxtsuI+U2biqGBLRslZKsyQ+qnqd5iOvQc8Z17pVTy5hD42H
 B3wbIFnlAFHWguCPx2RHDj6a864BZj7cpF6KCzAuAZz0OlJ5vVoZB7UCpSd7AOmkR0wP
 igcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Mmywxse0Hot8Qok1gcJfSbINc+XX1/PHxykZhjM3t4Y=;
 b=hqk+i3XBsAVxDDHvj8l8Kaq7pxkaW4YtiUAtUOlUKDGdC141EYmZpIgicoYai0hmC/
 c7EDuU4ncKV5rqUfHPgT1ivbfiI9ZarZWkOWFsuvG9X1QW74HCr6sYptIg3i+3N9AT09
 d08VzojPkgENotZvmoFgRHgjaf+0YPs13ZMBxVPGPNLysTO27R18H+bu+ZOypNJ8gZ4u
 d00Ydv0IHnIz4O0R2EIBcuz+BVZFUbTvICYwwDQJw0MDnJ9x0OsPg2CIzmWQbLOhSq3P
 foH6FF+tC5/w8K5+m/FFoM5nCQnf1uJaeyVUfIGvtKAklxs0pV8IvI7Li8r2GKEMYSyx
 +6vg==
X-Gm-Message-State: AHQUAuYtdAeb4DPjnhnFJji14Y91vb9uLcf2+A8zBaFVHEfZ8snKL4Zo
 ESq+DzoZ1MHmCcHogZI3X/BKzybn
X-Google-Smtp-Source: AHgI3Ibq4KM1CZA5ZzLxN0XUjm+gY9XEXL37FRimAMjX/t4wyIC1gWkO2vEABpxB2LtllcVOQjxRjA==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr6225509wml.121.1549112747734; 
 Sat, 02 Feb 2019 05:05:47 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id s5sm3784900wmh.37.2019.02.02.05.05.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 02 Feb 2019 05:05:46 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id F00851146681; Sat,  2 Feb 2019 14:05:40 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] Move static keyword at beginning of declaration
Date: Sat,  2 Feb 2019 14:05:35 +0100
Message-Id: <20190202130535.2761-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
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
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Geoff Levand <geoff@infradead.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Move the static keyword around to remove the following warnings (W=1):

  arch/powerpc/platforms/ps3/os-area.c:212:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]
  arch/powerpc/platforms/ps3/system-bus.c:45:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/ps3/os-area.c    | 4 ++--
 arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index f5387ad82279..4d65c5380020 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -205,11 +205,11 @@ static const struct os_area_db_id os_area_db_id_rtc_diff = {
  *  3) The number of seconds from 1970 to 2000.
  */
 
-struct saved_params {
+static struct saved_params {
 	unsigned int valid;
 	s64 rtc_diff;
 	unsigned int av_multi_out;
-} static saved_params;
+} saved_params;
 
 static struct property property_rtc_diff = {
 	.name = "linux,rtc_diff",
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 5cc35d6b94b6..7c227e784247 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -37,12 +37,12 @@ static struct device ps3_system_bus = {
 };
 
 /* FIXME: need device usage counters! */
-struct {
+static struct {
 	struct mutex mutex;
 	int sb_11; /* usb 0 */
 	int sb_12; /* usb 0 */
 	int gpu;
-} static usage_hack;
+} usage_hack;
 
 static int ps3_is_device(struct ps3_system_bus_device *dev, u64 bus_id,
 			 u64 dev_id)
-- 
2.19.2

