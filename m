From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15963.417.778407.277896@argo.ozlabs.ibm.com>
Date: Tue, 25 Feb 2003 16:39:45 +1100
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Oops when inserting PCMCIA flash card (IDE)
In-Reply-To: <E18nL1U-0007Ag-00@piglet.grunz.lu>
References: <E18nL1U-0007Ag-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners writes:

> For a number of kernel versions (at least 4 months) I get a kernel oops
> when inserting a CF card in my TiBook's PCMCIA slot.
[snip]
> The NIP in the oops points to ide_mm_inb(); it's trying to read from the
> IDE ports. However, the port the new IDE interface got assinged seems to

It should of course be using ide_inb().

The problem is that there are 3 IDE interfaces on the tibook, and the
third one doesn't have anything attached.  Thus ide2 gets set up as a
pmac-ide interface but ends up with the `present' flag false, since
the IDE layer has no way to represent an interface that is present but
has no drives attached.  Then when you plug in the CF card it gets to
use ide2, but the data structures don't get properly initialized and
it goes off and tries to use pmac-ide routines on it.

I explained this problem to Alan Cox but didn't get him to focus on it
long enough to fix it properly.  In the meantime I am using this hack:

diff -urN linux-2.5/drivers/ide/ide.c pmac-2.5/drivers/ide/ide.c
--- linux-2.5/drivers/ide/ide.c	2003-02-22 12:30:01.000000000 +1100
+++ pmac-2.5/drivers/ide/ide.c	2003-02-25 16:37:40.000000000 +1100
@@ -904,6 +904,7 @@
 		ide_unregister(index);
 	if (hwif->present)
 		return -1;
+	init_hwif_data(index);
 	memcpy(&hwif->hw, hw, sizeof(*hw));
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
 	hwif->irq = hw->irq;

Regards,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
