Return-Path: <glikely@secretlab.ca>
Received: from mail-bw0-f207.google.com (mail-bw0-f207.google.com
	[209.85.218.207])
	by bilbo.ozlabs.org (Postfix) with ESMTP id ECEE4B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 01:57:34 +1000 (EST)
Received: by bwz3 with SMTP id 3so41145bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 03 Sep 2009 08:57:31 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc: Fix i8259 interrupt driver kernel crash on ML510
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Date: Thu, 03 Sep 2009 09:57:23 -0600
Message-ID: <20090903155208.18009.73841.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Roderick Colenbrander <thunderbird2k@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roderick Colenbrander <thunderbird2k@gmail.com>

This patch fixes a null pointer exception caused by removal of
'ack()' for level interrupts in the Xilinx interrupt driver.  A recent
change to the xilinx interrupt controller removed the ack hook for
level irqs.

Signed-off-by: Roderick Colenbrander <thunderbird2k@gmail.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Hi Ben & Linus,

This is a last minute bug fix must go into 2.6.31.  This patch
is needed to prevent a kernel panic on Xilinx ml510 boards.

I've also pushed the patch out to my git tree if you'd prefer to pull:

The following changes since commit 326ba5010a5429a5a528b268b36a5900d4ab0eba:
  Linus Torvalds (1):
        Linux 2.6.31-rc8

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

Roderick Colenbrander (1):
      powerpc: Fix i8259 interrupt driver kernel crash on ML510

 arch/powerpc/sysdev/xilinx_intc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)



diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 3ee1fd3..40edad5 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -234,7 +234,6 @@ static void xilinx_i8259_cascade(unsigned int irq, struct irq_desc *desc)
 		generic_handle_irq(cascade_irq);
 
 	/* Let xilinx_intc end the interrupt */
-	desc->chip->ack(irq);
 	desc->chip->unmask(irq);
 }
 
