Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F2BC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:50:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2D3214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkC6AO6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2D3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pMGP600mzDqNs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 07:50:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=brajeswar.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rkC6AO6r"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pF4r11xmzDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 03:11:52 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id w7so7382572pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 08:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=CV388ilkjL0NcLVI0uaGKJeYDzVKBWBY5OcOpufxxPc=;
 b=rkC6AO6rkKbgt9CB/wiM/aYiYfQuXpg0AmcKVo3Z0suKBF7QQlqbUFhNYmFmOtSDjL
 gG9iBres8z+hERqnTMH8AB0qRmEA62RZGHi3enK2okgQZaZY8AU59Duen8DxmLRI/2qY
 VN7QmeR4Jng7XT+7P2HRCwGAmgOn4Zzd9ZVkF9oARXn/FEif1YCtP7u9qL982S4l3zab
 qEj9d1PP+2QqdZx2PAXOQfLLibt3DgU926iBmJN5cZQT4sS4lvSS2PD4G4qv9gsIiI4k
 cQmdWO0ughG0V8CvBYV+UW6XuV06jp6pg6d9gMyq0TPUBAOdHbvRRhetRqwEPuBdu8FG
 YL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=CV388ilkjL0NcLVI0uaGKJeYDzVKBWBY5OcOpufxxPc=;
 b=GFuJ3jOuXWIpATxTA4KRbeF3027rRA9n8YJ59hj9ij9yyUrUPaL10yWVzOR9p+RsRa
 ExiQCc3JLGSrUYH0jm63WfQSHfQpWqAUT82iltNy/2C/qPNtKghIGiXzvx/j9XYCTphT
 Hg9QQNQgZOudwHBC/h0cy9FDWYgJKtL9b8EUh+UnOK6NeuKkGq0Vrc3qA6+Wed5M+HDk
 tr8Qpv99hXvpLshm25dGrXh/EdhbJtdApPBdQod9lUT8kvXDqVXySEZRCPBNKFThD5Z7
 tXEllkBrNGu8rn64E59q1ES9dmC5UpxFB892xvsN9xZJ6RlQ0gJ94l+LMS/wRve7u9dc
 LhsA==
X-Gm-Message-State: AJcUukffo/BQ/HGbIHw5Hz+2cgd10YrWvdBjWzbDuPycFSXfzQOBS65I
 GSNlkkmVtc/fVjPTLywHl0w=
X-Google-Smtp-Source: ALg8bN5oiB7c+yXgt6FEtfawuyFcw+R/BgttdHCUnb3PSB26onItgOqrnKhAkZj1bs/uAv6zqfka/Q==
X-Received: by 2002:a63:4384:: with SMTP id
 q126mr20174469pga.160.1548691909813; 
 Mon, 28 Jan 2019 08:11:49 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([47.11.154.113])
 by smtp.gmail.com with ESMTPSA id p2sm41647731pfb.28.2019.01.28.08.11.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 08:11:49 -0800 (PST)
Date: Mon, 28 Jan 2019 21:41:36 +0530
From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@c-s.fr, arnd@arndb.de,
 anton@ozlabs.org, aneesh.kumar@linux.ibm.com
Subject: [PATCH] powerpc/kernel/time: Remove duplicate header
Message-ID: <20190128161136.GA2266@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Tue, 29 Jan 2019 07:45:22 +1100
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
Cc: sabyasachi.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
 jrdr.linux@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove linux/rtc.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/powerpc/kernel/time.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3646affae963..bc0503ef9c9c 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -57,7 +57,6 @@
 #include <linux/irq_work.h>
 #include <linux/clk-provider.h>
 #include <linux/suspend.h>
-#include <linux/rtc.h>
 #include <linux/sched/cputime.h>
 #include <linux/processor.h>
 #include <asm/trace.h>
-- 
2.17.1

