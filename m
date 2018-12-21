Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437DC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 04:30:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392912186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 04:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqrQbOTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392912186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LbKS4xk9zDrB2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 15:30:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MqrQbOTh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MqrQbOTh"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LbGY1JgzzDr7h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 15:28:20 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id y1so3762881oie.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 20:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XKweS4GW1BIp+RvifjPjdoyhvxRXzKsBjTo78PoyZuM=;
 b=MqrQbOThobGtz3zLvdy52CYxtoObtqdBoyApu3bjs0eGdzIPAY9KGLHhbGUI5rgRrd
 MkiBirsYPutEDjeapKjrtHZzd8i/6w7iVKMOvPVZG7t5jpjAquNR75G2ld5bSkJWj9HQ
 Z5l+EjTx8IuPWqxTCRC+B0iwSrVcORvXPwhlEBWJMYv8kpCgnk6NiWnzTQjaogvdf80q
 CMkvHZs0aYgvoZ8WTEOWk5DkBmH3w+thxIUCX4v8LlzncvnmHTudYjW2MLJ3VlgQLVj2
 UDRDjb8CbVumHkoFrPTCt8iplPjRTjO8rWIT27v88R13gLir59AFmGFOyhR+im19/Kpk
 +WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XKweS4GW1BIp+RvifjPjdoyhvxRXzKsBjTo78PoyZuM=;
 b=FzCrrmj/nnsIRBo8jF8+3eBBYs9ew390kHf6ORHkccumgEH5YXiM9GeTSt8vvA0IkC
 0uUZyx9s/hwv9vHj3RoaWShfzxvzAyF1LQCrXpcGFWktt7niK//3j1yAXUTk3Wf9EKev
 8lcvRyJSdNgaf/V1oQBa4RTnbbI4ry12KUdzY9LjE6XZzUFfhNsBPTCKETaJAN6lNNm1
 YbTDQa5M3rgxBIgodS5B1cbcSFf1oH/CCfvRurlhfYCqrzgnoaDfr4DNoftdq3E0CnqY
 d8HBhw/UMvFYZnTxCMnD2lY/AVWBqUVnLB9axkMjqlZVP5JtI2Di5eKLPK3Dd4xwA/oH
 IoWQ==
X-Gm-Message-State: AJcUukelKtFfYzIIw69cqEadDPDzQfsWMeKTY96gHRyrR5KyvPvtZa2U
 4zA1gOYj0r+AbdBLRkxszGs=
X-Google-Smtp-Source: AFSGD/XXCjzD7Q9TlsZmRc5xxIb83Qi4Xw3zxilJX9iEBNavgHkjZdK9xtNvrLwsQ8xTzAStxl8LJg==
X-Received: by 2002:aca:5946:: with SMTP id n67mr385623oib.268.1545366498569; 
 Thu, 20 Dec 2018 20:28:18 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id t12sm12501429otk.61.2018.12.20.20.28.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 20:28:17 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-vger@kernel.org
Subject: [PATCH] Revert "serial: 8250: Default SERIAL_OF_PLATFORM to
 SERIAL_8250"
Date: Thu, 20 Dec 2018 20:27:16 -0800
Message-Id: <20181221042719.29954-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220173844.GA5838@roeck-us.net>
References: <20181220173844.GA5838@roeck-us.net>
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
Cc: Nishanth Menon <nm@ti.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vignesh R <vigneshr@ti.com>, arnd@arndb.de, gregkh@linuxfoundation.org,
 Tony Lindgren <tony@atomide.com>, Jiri Slaby <jslaby@suse.com>,
 open list <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>,
 paulus@samba.org, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux@roeck-us.net, Michael Moese <mmoese@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This reverts commit 6d11023c345e369bcb9d5a68b271764e362c1f6e ("serial:
8250: Default SERIAL_OF_PLATFORM to SERIAL_8250") since that breaks at
least mpc8544ds (PowerPC) using arch/powerpc/kernel/legacy_serial.c.

See https://lkml.org/lkml/2018/12/5/1491 for discussion and analysis

Fixes: 6d11023c345e ("serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/8250/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d7737dca0e48..15c2c5463835 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -484,7 +484,6 @@ config SERIAL_8250_PXA
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
-	default SERIAL_8250
 	help
 	  This option is used for all 8250 compatible serial ports that
 	  are probed through devicetree, including Open Firmware based
-- 
2.19.1

