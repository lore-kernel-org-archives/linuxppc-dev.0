Return-Path: <B29882@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 608B11007DD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 09:54:14 +1100 (EST)
Received: from mail40-va3 (localhost [127.0.0.1])	by mail40-va3-R.bigfish.com
 (Postfix) with ESMTP id 1444F4800AD	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 25 Oct 2011 22:54:06 +0000 (UTC)
Received: from VA3EHSMHS007.bigfish.com (unknown [10.7.14.245])	by
 mail40-va3.bigfish.com (Postfix) with ESMTP id E3E4D20046	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:05 +0000 (UTC)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <kumar.gala@freescale.com>
Subject: [PATCH 3/5] powerpc/85xx: Make kexec to interate over online cpus
Date: Tue, 25 Oct 2011 17:54:04 -0500
Message-ID: <1319583246-6120-3-git-send-email-msm@freescale.com>
In-Reply-To: <1319583246-6120-1-git-send-email-msm@freescale.com>
References: <1319583246-6120-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is not strictly required, because this iterates over logical
cpus and they are not (currently) discontigous. But, it's cleaner
code and more obvious what is going on

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 5b9b901..b830f8a 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -206,7 +206,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 	if ( !timeout )
 		printk(KERN_ERR "Unable to bring down secondary cpu(s)");
 
-	for (i = 0; i < num_cpus; i++)
+	for_each_online_cpu(i)
 	{
 		if ( i == smp_processor_id() ) continue;
 		mpic_reset_core(i);
-- 
1.7.6.1
