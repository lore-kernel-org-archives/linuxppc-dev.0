Message-ID: <3871058F.9E0B4D73@talknet.de>
Date: Mon, 03 Jan 2000 21:24:47 +0100
From: Alois Fertl <alois_fertl@talknet.de>
MIME-Version: 1.0
To: Gerard Roudier <groudier@club-internet.fr>
CC: LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Problem in ncr53c8xx.c driver
Content-Type: multipart/mixed;
 boundary="------------9EC9150FF574C84D26CA1EF0"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------9EC9150FF574C84D26CA1EF0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Version revision 3.2d from 6th of Dec. crashed my ppc kernel
at boot because it tries to access the nvram witin the
ncr53c8xx_pci_init() function before the pointer has been
correctly initialized. The patch below adds the initialization.

	Alois
--------------9EC9150FF574C84D26CA1EF0
Content-Type: text/plain; charset=us-ascii;
 name="ncr53c8xx.patch"
Content-Disposition: inline;
 filename="ncr53c8xx.patch"
Content-Transfer-Encoding: 7bit

--- drivers/scsi/ncr53c8xx.c.dist	Tue Dec 21 20:35:12 1999
+++ drivers/scsi/ncr53c8xx.c.new	Mon Jan  3 21:14:12 2000
@@ -9509,6 +9509,7 @@
 		devp = &devtbl[count];
 		devp->host_id = driver_setup.host_id;
 		devp->attach_done = 0;
+		devp->nvram = nvp;
 		if (ncr53c8xx_pci_init(tpnt, pcidev, devp)) {
 			continue;
 		}

--------------9EC9150FF574C84D26CA1EF0--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
