Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 33E96DDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 08:36:21 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 5E866221BBF
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 00:36:19 +0200 (CEST)
Received: from mail.denx.de (p54965DA0.dip.t-dialin.net [84.150.93.160])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 4CA1590EC2
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 00:36:19 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.0.0.2])
	by mail.denx.de (Postfix) with ESMTP id 8D1DE6D00A5
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 00:36:18 +0200 (CEST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [PPC] Disable vDSO support for ARCH=ppc where it's not
	implemented.
Date: Wed, 10 Oct 2007 00:36:18 +0200
Message-Id: <11919693783126-git-send-email-wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Wolfgang Denk <wd@denx.de>
---
 arch/powerpc/kernel/vdso.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 213fa31..2322ba5 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -766,7 +766,9 @@ static int __init vdso_init(void)
 
 	return 0;
 }
+#ifdef CONFIG_PPC_MERGE
 arch_initcall(vdso_init);
+#endif
 
 int in_gate_area_no_task(unsigned long addr)
 {
-- 
1.5.2.2
