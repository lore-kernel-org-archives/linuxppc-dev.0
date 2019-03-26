Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B0AC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:50:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17E52087C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/OyMbMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17E52087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TNZC4WgLzDqP2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 07:50:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="l/OyMbMP"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TNVc3KSgzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 07:47:36 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id q16so14084685wmj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1Yoprl42VcVIg+Or9Xh6MCziR7xSFWDxzJkJwkvYVkM=;
 b=l/OyMbMP6FYtklBeTYh528cFF/MOk837ueO1ug77OIPM3GBz+Av8cEaVYgUXS0HSOu
 Y8hALqPC2q/zcNCsoUdGKxNkLcjr0LwuBJmprNt1wGnzk8KrAexiMxEBxeQ60j17lvgq
 OKoj+cc0pG+YVGpLUZRXNkhDAhxkDut/ahD4UTLuG1Vy4xLNtq5KtBCBdQRRenXicjiG
 FHfQQjAI2KTqqU/6Y496B8xdp8c2k9KMYp859Vc+sMh9j88Pawkc8uT40uHN8YcqQtTw
 nN8LLoYfRTxw8wEHEMJSdbtrLxgMDFI0RaxF/SedB13kJcJQ5103nJXT2VC2I4RB0DsO
 /Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1Yoprl42VcVIg+Or9Xh6MCziR7xSFWDxzJkJwkvYVkM=;
 b=CP2tzAtJahRYsTC7a2nmXkxgzjLgS9ifIxPrUcLMah+86ob3l0NMHDA5iWu96g0Gh/
 2acYO6UkRyD0o8t/7qZRWdszQ+ulgAAI09b2yHpqixtkBfkv8wPFijqM6GMhrgweX4IR
 DiDEDane5IdgRuYnxnHkz+SDNGZi/60PcTHlfwSSX8fsCJuWvXsGzLWcBYHilo8hUqvR
 jDSh1/AlktfdO6CDDmNqczSYaze6uwYBXBkAxEoJFlgHgaLt7Z/XbgaNUkphQJK/ahWy
 35k+h/BF/IqRHP7OUQyglqLD6iDDR6uJG4v7J9v19Mpu25hNWH63EHg55kCZc/fQAUIF
 +SkQ==
X-Gm-Message-State: APjAAAVRB6GBDshCLjwuNqRcL5bck8ZBAPpMUnQdYcAxojIldohRr9ZH
 bIMxI5roVo2l3dumgm/m8X4=
X-Google-Smtp-Source: APXvYqxztKxz/750qXzabQMQ4wEcM+Qcs+la49Os7Vqkfu5HIMAOPr6mJmA9WF1F4Wu2fiB2y6JRww==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr7928405wmg.132.1553633253075; 
 Tue, 26 Mar 2019 13:47:33 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id b11sm107391wru.61.2019.03.26.13.47.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Mar 2019 13:47:32 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 711FC1142374; Tue, 26 Mar 2019 21:47:21 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 1/2] powerpc: Make some functions static
Date: Tue, 26 Mar 2019 21:47:18 +0100
Message-Id: <20190326204720.18882-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312203140.31785-1-malat@debian.org>
References: <20190312203140.31785-1-malat@debian.org>
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
new functions were added. Since most of these functions can be made static,
make it so.

Both holly_power_off and holly_halt functions were not changed since they
are unused, making them static would have triggered the following warning
(treated as error):

  arch/powerpc/platforms/embedded6xx/holly.c:244:13: error: 'holly_halt' defined but not used [-Werror=unused-function]

Silence the following warnings triggered using W=1:

  arch/powerpc/platforms/embedded6xx/holly.c:47:5: error: no previous prototype for 'holly_exclude_device' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:190:6: error: no previous prototype for 'holly_show_cpuinfo' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:196:17: error: no previous prototype for 'holly_restart' [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Split the patch in two operations

 arch/powerpc/platforms/embedded6xx/holly.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 0409714e8070..9d2eefef7b7b 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -44,7 +44,8 @@
 
 #define HOLLY_PCI_CFG_PHYS 0x7c000000
 
-int holly_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
+static int holly_exclude_device(struct pci_controller *hose, u_char bus,
+				u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -187,13 +188,13 @@ static void __init holly_init_IRQ(void)
 	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
 }
 
-void holly_show_cpuinfo(struct seq_file *m)
+static void holly_show_cpuinfo(struct seq_file *m)
 {
 	seq_printf(m, "vendor\t\t: IBM\n");
 	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
 }
 
-void __noreturn holly_restart(char *cmd)
+static void __noreturn holly_restart(char *cmd)
 {
 	__be32 __iomem *ocn_bar1 = NULL;
 	unsigned long bar;
-- 
2.20.1

