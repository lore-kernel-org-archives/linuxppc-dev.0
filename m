Return-Path: <apopple@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3AAB1A0615
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 19:28:11 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8601814028F
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 19:28:11 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <apopple@au1.ibm.com>;
 Thu, 11 Jun 2015 19:27:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 289C1357804F
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 19:27:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B9QXBk62652650
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 19:26:41 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B9QApf011504
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 19:26:10 +1000
From: Alistair Popple <alistair@popple.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/powernv: Bump opal_init initcall priority
Date: Thu, 11 Jun 2015 19:25:29 +1000
Message-Id: <1434014729-12068-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

opal_init() is called via a machine_subsys_initcall(). Due to a hack
in the eeh code the eeh driver is initialised with at the same
initcall level. This means depending on link ordering the following
error can occur because the opal irchip has not been initialised:

irq: XICS didn't like hwirq-0x9 to VIRQ17 mapping (rc=-22)
pnv_eeh_post_init: Can't request OPAL event interrupt (0)

This patch solves the issue by making sure opal_init is called prior
to the subsystems that may need it.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Reported-by: Daniel Axtens <dja@axtens.net>
---

Michael,

This fixes a problem in your next tree introduced by my opal irqchip
series. I encountered similar problems when moving some of the other
subsystems across to the new interface which was the motivation behind
the first patch in that series (powerpc/powernv: Reorder OPAL
subsystem initialisation). I missed this one due to a quirk in the
generic eeh code.

It seems that initcall dependencies are not well defined (or at least
my understanding of the dependencies isn't), so I'm not overly
comfortable with this fix. To be honest I don't have a clear
understanding of what side effects bumping this up a level might have
- it boots, everything seems to "work", and a quick grep reveals
nothing obvious. However I'm open to suggestions for a better fix...

In the meantime this should fix the problem in your branch until I get
a chance to dig further.

- Alistair

 arch/powerpc/platforms/powernv/opal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 9e9c483..cc3ba5f 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -718,7 +718,7 @@ static int __init opal_init(void)

 	return 0;
 }
-machine_subsys_initcall(powernv, opal_init);
+machine_arch_initcall(powernv, opal_init);

 void opal_shutdown(void)
 {
--
1.7.10.4
