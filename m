Return-Path: <susheel_nuguru@yahoo.co.in>
Received: from web8503.mail.in.yahoo.com (web8503.mail.in.yahoo.com
	[202.43.219.165]) by ozlabs.org (Postfix) with SMTP id 3309D67CEA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 17:16:40 +1000 (EST)
Message-ID: <20050725071638.67632.qmail@web8503.mail.in.yahoo.com>
Date: Mon, 25 Jul 2005 00:16:38 -0700 (PDT)
From: Susheel Raj <susheel_nuguru@yahoo.co.in>
To: David Wolfe <david.wolfe@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Compilation error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

   I ams til trying to make Ethernet work :-(
 Last time i compiled the kernel without including
some files but now included everything in Bestcomm
directory.

I am getting the following error which I could figure
out what? could you help me ...

ppc_82xx-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000
-Bstatic arch/ppc/kernel/head.o
arch/ppc/kernel/idle_6xx.o init/main.o init/version.o
init/do_mounts.o \
        --start-group \
        arch/ppc/kernel/kernel.o
arch/ppc/platforms/platform.o
arch/ppc/mm/mm.oarch/ppc/lib/lib.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o
drivers/pci/driver.o drivers/mtd/mtdlink.o
drivers/macintosh/macintosh.o drivers/video/video.o
drivers/usb/usbdrv.o drivers/media/media.o
arch/ppc/mgt_io/mgt_io.o drivers/mitron/mitron.o \
        net/network.o \
        /home/nuguru/linux_2_4_21_5200/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/mgt_io/mgt_io.o: In function
`mgt_sdma_fec_rx_task_setup':
arch/ppc/mgt_io/mgt_io.o(.text+0x3934): undefined
reference to `TaskSetup_TASK_FEC_RX'
arch/ppc/mgt_io/mgt_io.o(.text+0x3934): relocation
truncated to fit: R_PPC_REL24 TaskSetup_TASK_FEC_RX
arch/ppc/mgt_io/mgt_io.o: In function
`mgt_sdma_fec_tx_task_setup':
arch/ppc/mgt_io/mgt_io.o(.text+0x39cc): undefined
reference to `TaskSetup_TASK_FEC_TX'
arch/ppc/mgt_io/mgt_io.o(.text+0x39cc): relocation
truncated to fit: R_PPC_REL24 TaskSetup_TASK_FEC_TX
make: *** [vmlinux] Error 1
nuguru@SW-server:~/linux_2_4_21_5200$     


As you know mgt_io is nothing but 5xxx_io for you and
the rest is same. It complains while it is linking
everything. I dint find anything like
"askSetup_TASK_FEC_RX" used in
mgt_sdma_fec_rx_task_setup() -->
arch/ppc/mgt_io/sdma.c.

What could be wrong here????


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
