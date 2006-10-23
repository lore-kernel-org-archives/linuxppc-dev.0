Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id B991C67BEB
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 02:35:26 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k9NHuChh020542
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 11:56:12 -0600 (MDT)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k9NGZNPi023767
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 11:35:23 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	k9NGLVHO027637
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 11:21:31 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 664444B92D
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 11:35:22 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	k9NGZMom016027
	for linuxppc-dev@ozlabs.org; Mon, 23 Oct 2006 11:35:22 -0500
Date: Mon, 23 Oct 2006 11:35:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] IPIC: Don't call set_irq_handler with desc->lock held.
Message-ID: <20061023163522.GA15901@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch causes ipic_set_irq_type to set the handler directly rather
than call set_irq_handler, which causes spinlock recursion because
the lock is already held when ipic_set_irq_type is called.

I'm also not convinced that ipic_set_irq_type should be changing the
handler at all.  There seem to be several controllers that don't and
several that do.  Those that do would break what appears to be a common
usage of calling set_irq_chip_and_handler followed by set_irq_type, if a
non-standard handler were to be used.  OTOH, irq_create_of_mapping()
doesn't set the handler, but only calls set_irq_type().

This patch gets things working in the spinlock-debugging-enabled case,
but I'm curious as to where the handler setting is ideally supposed to be
done.  I don't see any documentation on set_irq_type() that clarifies
what the semantics are supposed to be.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/ipic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index bc4d4a7..746f78c 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -473,9 +473,9 @@ static int ipic_set_irq_type(unsigned in
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
 	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
 		desc->status |= IRQ_LEVEL;
-		set_irq_handler(virq, handle_level_irq);
+		desc->handle_irq = handle_level_irq;
 	} else {
-		set_irq_handler(virq, handle_edge_irq);
+		desc->handle_irq = handle_edge_irq;
 	}
 
 	/* only EXT IRQ senses are programmable on ipic
-- 
1.4.2.3
