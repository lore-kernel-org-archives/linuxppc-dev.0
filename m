Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5012067B18
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 17:51:00 +1000 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k5U7vIiH012073
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 02:57:19 -0500
Subject: new irq works status (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 30 Jun 2006 17:50:55 +1000
Message-Id: <1151653855.13194.9.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I uploaded a new version at http://gate.crashing.org/~benh/irq-WIP/

This one applies on top of a linus git checkout from today and thus
should also apply on top of a recent powerpc.git tree. It contains
various fixes & cleanups over the previous ones, significant fixes in
the mpic code (mpic based pseries work now) and powermac 64 bits is
ported over.

Remaining bits are:

 - PowerMac 32 bits. There is a bit of work to replace the old
workarounds for broken device-trees
   here, those used to be done by changing device_node->intrs which is
now gone
 - Maple (should be trivial, +/- a small nit for some SLOF version)
 - CHRP (should be really trivial :) Just need to be careful of Pegasos
lack of a valid
   interrupt-tree and properly default to the PCI_INTERRUPT_LINE config
space register
   in that case, which shall match 8259 interrupts
 - embedded6xx/* platforms. I'll leave the pleasure of fixing these to
the maintainers for now 
   unless I decide to beat them to it, but since I'm not too familiar,
I'd rather have them do
   the job. It should be fairly trivial to just make them work. The next
step though is to make
   them _use_ the new stuff which will probably involve device-tree
updates.

I expect to have PowerMac32 and possibly CHRP fixed tomorrow and will
proceed to the merge asap, leaving Maple and embedded6xx as "to be fixed
before 2.6.18 is finished".

I'd appreciate review and comments.

Cheers,
Ben.
