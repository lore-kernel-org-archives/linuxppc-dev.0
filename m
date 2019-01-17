Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B265AC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 16:12:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A2220652
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 16:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhq0zpy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A2220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gTcM5zTXzDqw9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 03:12:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=sabyasachi.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nhq0zpy7"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gTZW3KMfzDqck
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 03:10:40 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id gn14so4935670plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 08:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:date:from:to:cc:subject:mime-version:content-disposition
 :user-agent; bh=+tNCWTeDwzAR3YkgECYwqVXsz06QLCwhxiwZmg0mLHo=;
 b=nhq0zpy7CVbt8BtUMsl3SFOh9hobIjopS1v8B8UGdfNfXLjGDT76Vfa3z8aSOMKXYe
 SHFIfoPLtXPy9k1drVLx5zsPxmmA/bvDJt8Rv8TG4PAO/gwTMGijJRQLreRIWMVwJWG7
 Uhby+UBLk3kzTiZaKirq+f9n17wwLTcqaLD7nR9US+mbm4M6OWtKFdN/SmIbASyfxf9/
 aSdMlZ/8wnblNos5jsgKnOzL2ue1rdydzRhkeuXmGVIh1ngiuiZoiWvPtMciOlUFW3zb
 mhZKJGoxB06D7hEQXO2phMnJL2qsNdKXLy4CkHkgnqpG52jNki5N2pYuXh9PnLHser+9
 EPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
 :content-disposition:user-agent;
 bh=+tNCWTeDwzAR3YkgECYwqVXsz06QLCwhxiwZmg0mLHo=;
 b=kUuFz87pvP/eeXe8V+5VTMOy8SZIabUtl+TwruElt6g5VkFfbGW0jugCAEvSbS2vIP
 ieqE5G/vxoMBAOWijfq26B1zSuriqXba4aO3Pvp2o7XyF8oYnQ7lT6+0sqIF7MqgH/O0
 Pbeyq48/rzt7pBXISmkhQBCgxELDQLP+Zl3dspc7e+G4ddwDyVZAECfLk4TDOdMXM4Tj
 8b89ctXeCUezJEfBjLMgrlkM+jjBr1N0o68IrOb7BngQvtW6BOelJtiS93J5ou5EO+1g
 CNQYUCqJiLHeODiEqm+MZVD14cL8Sy/mY0zPUmr1POXUQMHsg1niJom00ZDiWMW0JzUo
 xtcA==
X-Gm-Message-State: AJcUukeMRnYxvs3IKr8l3nPZe1MKnWy8YzSo9WC0OyPpaSjYowypVhN6
 PyUQJCh8ldxXrrbk8IH1TZw=
X-Google-Smtp-Source: ALg8bN7kFkfPViNgA1x2DGpCEn7e5448U+Rnj/+2QUhCifWghKHeJbACGlJFWV9SepnpHy4cUIffAg==
X-Received: by 2002:a17:902:12b:: with SMTP id
 40mr15311747plb.72.1547741438424; 
 Thu, 17 Jan 2019 08:10:38 -0800 (PST)
Received: from sabyasachi ([45.116.191.230])
 by smtp.gmail.com with ESMTPSA id l184sm3859384pfc.112.2019.01.17.08.10.36
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 08:10:37 -0800 (PST)
Message-ID: <5c40a8fd.1c69fb81.e4b1b.8f85@mx.google.com>
X-Google-Original-Message-ID: <20190117161032.GA22958@sabyasachi.linux@gmail.com>
Date: Thu, 17 Jan 2019 21:40:33 +0530
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, msuchanek@suse.de, haren@linux.vnet.ibm.com,
 oohall@gmail.com, bsingharora@gmail.com
Subject: [PATCH] powerpc/powernv: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
 jrdr.linux@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove linux/printk.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index beed86f..802de0d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -26,7 +26,6 @@
 #include <linux/memblock.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
-#include <linux/printk.h>
 #include <linux/kmsg_dump.h>
 #include <linux/console.h>
 #include <linux/sched/debug.h>
-- 
2.7.4

