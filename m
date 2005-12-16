Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5361D688BA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 01:38:17 +1100 (EST)
Date: Fri, 16 Dec 2005 11:46:04 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20051216134604.GA3692@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Belz <Daniel.Belz@cyclades.com>,
	Edson Seabra <edson.seabra@cyclades.com>
Subject: [PATCH] MPC85xx: CPM2 interrupt handler failure after 100,
	000 interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Please apply.

From: Edson Seabra <Edson.Seabra@cyclades.com>

The CPM2 interrupt handler does not return success to the IRQ subsystem, which 
causes it to kill the IRQ line after 100,000 interrupts.

[root@KVM ~]# create_cf --doformat --factory_default
...
 Copying Linux kernel to /dev/hda1
Initialization of /dev/hda1 done.
 Copying RO file system to /dev/hda5
 Packing dev done.
  Creating directories...
  Creating etc... done.
  Creating home... done.
  Creating root... done.
  Creating mnt... done.
  Creating var... done.
  Creating dev... done.
  Creating tmp... done.
  Creating proc... done.
  Copying directories/files...
  Copying bin... done.
  Copying sbin... done.
  Copying lib... done.
  Copying libexec... done.
  Copying new_web... done.
  Copying opt... done.
  Copying usr... done.
  Copying COPYRIGHTS...
Error in command: 'cp -a /COPYRIGHTS /mnt/hdPart'

[ 1133.542580] Disabling IRQ #94
May 23 16:59:53 s_kernel@KVM [ 1133.542222] irq 94: nobody cared (try
booting with the "irqpoll" option)
May 23 16:59:53 s_kernel@KVM [ 1133.542546] handlers:
May 23 16:59:53 s_kernel@KVM [ 1133.542554] [<c0013ba4>]
(cpm2_cascade+0x0/0x48)

The following patch fixes the problem.

Signed-off-by: Edson Seabra <Edson.Seabra@cyclades.com>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

RCS file: /usr/cvsroot/oobi_projects/sources/lsp/linux-2.6.14
/arch/ppc/platforms/85xx/mpc85xx_cds_common.c,v
retrieving revision 1.1
retrieving revision 1.4
diff -u -r1.1 -r1.4
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c        6 Dec 2005 02:56:21 -0000       1.1
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c        14 Dec 2005 19:32:57 -0000      1.4
@@ -145,10 +154,11 @@
 }

 #ifdef CONFIG_CPM2
-static void cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
+static int cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
 {
        while((irq = cpm2_get_irq(regs)) >= 0)
                __do_IRQ(irq, regs);
+       return(IRQ_HANDLED);
 }

 static struct irqaction cpm2_irqaction = {
