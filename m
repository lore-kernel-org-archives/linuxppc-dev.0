Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB23C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 09:26:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3D76054E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 09:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D3D76054E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GtRgW4d2pz2xrZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 19:25:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=188.165.45.220; helo=5.mo52.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
X-Greylist: delayed 1486 seconds by postgrey-1.36 at boromir;
 Mon, 23 Aug 2021 19:25:33 AEST
Received: from 5.mo52.mail-out.ovh.net (5.mo52.mail-out.ovh.net
 [188.165.45.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GtRg10pxBz2xY7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Aug 2021 19:25:31 +1000 (AEST)
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.240])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id E0FDA28F1C4;
 Mon, 23 Aug 2021 11:00:41 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 23 Aug
 2021 11:00:41 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003faa793e4-d8a5-4939-8e11-0b0a392d9b83,
 6C3DA580BFD2A03B9CD9C7EDF86CA127720438B1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 83.199.102.86
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 1/2] =?UTF-8?q?powerpc/prom:=20Fix=20unused=20variable?=
 =?UTF-8?q?=20=E2=80=98reserve=5Fmap=E2=80=99=20when=20CONFIG=5FPPC32=20is?=
 =?UTF-8?q?=20not=20set?=
Date: Mon, 23 Aug 2021 11:00:38 +0200
Message-ID: <20210823090039.166120-2-clg@kaod.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210823090039.166120-1-clg@kaod.org>
References: <20210823090039.166120-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: d24395b4-3de3-483b-ac9b-e7e3d51ed194
X-Ovh-Tracer-Id: 7185774680826743776
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddthedgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This fixes a compile error with W=1.

arch/powerpc/kernel/prom.c: In function ‘early_reserve_mem’:
arch/powerpc/kernel/prom.c:625:10: error: variable ‘reserve_map’ set but not used [-Werror=unused-but-set-variable]
  __be64 *reserve_map;
          ^~~~~~~~~~~
cc1: all warnings being treated as errors

Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/kernel/prom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f620e04dc9bf..44b2cdc0aae3 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -640,7 +640,9 @@ static void __init early_reserve_mem(void)
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-#ifdef CONFIG_PPC32
+	if (!IS_ENABLED(CONFIG_PPC32))
+		return;
+
 	/* 
 	 * Handle the case where we might be booting from an old kexec
 	 * image that setup the mem_rsvmap as pairs of 32-bit values
@@ -661,7 +663,6 @@ static void __init early_reserve_mem(void)
 		}
 		return;
 	}
-#endif
 }
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-- 
2.31.1

