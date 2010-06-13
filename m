Return-Path: <alastair.bridgewater@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id B3F86B7D89
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 11:36:50 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id l26so604632fgb.3
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 18:36:48 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 12 Jun 2010 21:36:48 -0400
Message-ID: <AANLkTimrq40Pd-ulPkfb8T2LJ0NSybd5InviirU7fK5D@mail.gmail.com>
Subject: [PATCH] powerpc: Fix mpic_resume on early G5 macs
From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpic_resume() on G5 macs blindly dereferences mpic->fixups, but
it may legitimately be NULL (as on PowerMac7,2).  Add an explicit
check.

This fixes suspend-to-disk with one processor (maxcpus=1) for me.

Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>
---
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 4fd57ab..28668ba 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1666,7 +1666,7 @@ static int mpic_resume(struct sys_device *dev)
                               mpic->save_data[i].dest);

 #ifdef CONFIG_MPIC_U3_HT_IRQS
-       {
+       if (mpic->fixups) {
                struct mpic_irq_fixup *fixup = &mpic->fixups[i];

                if (fixup->base) {
