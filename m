Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id B202BDDF26
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 18:27:43 +1000 (EST)
Date: Tue, 3 Jul 2007 10:27:38 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] pata_mpc52xx: suspend/resume support
Message-ID: <20070703082738.GM23294@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ide@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Implement suspend and resume routines for mpc52xx ata driver.
Tested on Lite5200b with deep-sleep and low-power (not yet in-tree)
modes.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
If anyone cares, I attached ATA_DEBUG messages at the end of patch.
Should it take almost 5 seconds?


 drivers/ata/pata_mpc52xx.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

Index: work-powerpc.git/drivers/ata/pata_mpc52xx.c
===================================================================
--- work-powerpc.git.orig/drivers/ata/pata_mpc52xx.c
+++ work-powerpc.git/drivers/ata/pata_mpc52xx.c
@@ -467,13 +467,27 @@ mpc52xx_ata_remove(struct of_device *op)
 static int
 mpc52xx_ata_suspend(struct of_device *op, pm_message_t state)
 {
-	return 0;	/* FIXME : What to do here ? */
+	struct ata_host *host = dev_get_drvdata(&op->dev);
+
+	return ata_host_suspend(host, state);
 }
 
 static int
 mpc52xx_ata_resume(struct of_device *op)
 {
-	return 0;	/* FIXME : What to do here ? */
+	struct ata_host *host = dev_get_drvdata(&op->dev);
+	struct mpc52xx_ata_priv *priv = host->private_data;
+	int rv;
+
+	rv = mpc52xx_ata_hw_init(priv);
+	if (rv) {
+		printk(KERN_ERR DRV_NAME ": Error during HW init\n");
+		return rv;
+	}
+
+	ata_host_resume(host);
+
+	return 0;
 }
 
 #endif


[ 1039.434045] Stopping tasks ... done.
[ 1039.438193] Suspending console(s)
[ 1039.441662] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 1039.441749] ata_scsi_dump_cdb: CDB (1:0,0,0) 35 00 00 00 00 00 00 00 00
[ 1039.441817] ata_exec_command: ata1: cmd 0xE7
[ 1039.442191] ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
[ 1039.442208] ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
[ 1039.442310] sd 0:0:0:0: [sda] Stopping disk
[ 1039.442378] ata_scsi_dump_cdb: CDB (1:0,0,0) 1b 00 00 00 00 00 00 00 00
[ 1039.442442] ata_exec_command: ata1: cmd 0xE0
[ 1039.442738] ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
[ 1039.442754] ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
[ 1039.442881] usb_endpoint usbdev1.1_ep81: PM: suspend 0->2, parent 1-0:1.0 already 2
[ 1039.442903] hub 1-0:1.0: PM: suspend 2->2, parent usb1 already 2
[ 1039.442919] usb_endpoint usbdev1.1_ep00: PM: suspend 0->2, parent usb1 already 2
[ 1039.444022] ata_port_schedule_eh: port EH scheduled
[ 1039.444056] ata_scsi_error: ENTER
[ 1039.444065] ata_port_flush_task: ENTER
[ 1039.444074] ata_port_flush_task: flush #1
[ 1039.444087] ata1: ata_port_flush_task: flush #2
[ 1039.444097] ata1: ata_port_flush_task: EXIT
[ 1039.444116] ata_eh_autopsy: ENTER
[ 1039.444133] ata_eh_autopsy: EXIT
[ 1039.444141] ata_eh_recover: ENTER
[ 1039.444151] ata_eh_revalidate_and_attach: ENTER
[ 1039.444162] ata_eh_recover: EXIT, rc=0
[ 1039.444179] __ata_port_freeze: ata1 port frozen
[ 1039.444198] ata_scsi_error: EXIT
[ 1039.447207] ata_port_schedule_eh: port EH scheduled
[ 1039.447270] eth0: Phy @ 0x0, type LXT971 (0x001378e2)
[ 1039.448257] usb_endpoint usbdev1.1_ep00: PM: resume from 0, parent usb1 still 2
[ 1039.448276] usb_endpoint usbdev1.1_ep81: PM: resume from 0, parent 1-0:1.0 still 2
[ 1039.448306] sd 0:0:0:0: [sda] Starting disk
[ 1039.448384] ata_scsi_error: ENTER
[ 1039.448398] ata_port_flush_task: ENTER
[ 1039.448407] ata_port_flush_task: flush #1
[ 1039.448420] ata1: ata_port_flush_task: flush #2
[ 1039.448430] ata1: ata_port_flush_task: EXIT
[ 1039.448451] ata_eh_autopsy: ENTER
[ 1039.448467] ata_eh_recover: ENTER
[ 1039.448481] __ata_port_freeze: ata1 port frozen
[ 1039.956600] ata_std_softreset: ENTER
[ 1039.956648] ata_std_softreset: about to softreset, devmask=3
[ 1039.956661] ata_bus_softreset: ata1: bus reset via SRST
[ 1040.107612] ata_dev_classify: found ATA device by sig
[ 1040.107643] ata_dev_classify: found ATA device by sig
[ 1040.107656] ata_std_softreset: EXIT, classes[0]=1 [1]=5
[ 1040.107667] ata_std_postreset: ENTER
[ 1040.107680] ata_std_postreset: EXIT
[ 1040.107708] ata_eh_thaw_port: ata1 port thawed
[ 1040.107717] ata_eh_revalidate_and_attach: ENTER
[ 1040.107732] ata1.00: ata_dev_read_id: ENTER
[ 1040.107833] ata_exec_command: ata1: cmd 0xEC
[ 1040.110597] ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
[ 1040.110616] ata_pio_sector: data read
[ 1040.110852] ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
[ 1040.110867] ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
[ 1040.110920] ata_port_flush_task: ENTER
[ 1040.110929] ata_port_flush_task: flush #1
[ 1040.110941] ata1: ata_port_flush_task: flush #2
[ 1040.110952] ata1: ata_port_flush_task: EXIT
[ 1040.111032] ata_dev_set_xfermode: set features - xfer mode
[ 1040.111102] ata_exec_command: ata1: cmd 0xEF
[ 1040.111263] ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
[ 1040.111281] ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
[ 1040.111329] ata_port_flush_task: ENTER
[ 1040.111339] ata_port_flush_task: flush #1
[ 1040.111351] ata1: ata_port_flush_task: flush #2
[ 1040.111361] ata1: ata_port_flush_task: EXIT
[ 1040.111373] ata_dev_set_xfermode: EXIT, err_mask=0
[ 1040.111385] ata1.00: ata_dev_read_id: ENTER
[ 1040.111474] ata_exec_command: ata1: cmd 0xEC
[ 1040.114596] ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
[ 1040.114615] ata_pio_sector: data read
[ 1040.114713] ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
[ 1040.114727] ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
[ 1040.114775] ata_port_flush_task: ENTER
[ 1040.114784] ata_port_flush_task: flush #1
[ 1040.114796] ata1: ata_port_flush_task: flush #2
[ 1040.114806] ata1: ata_port_flush_task: EXIT
[ 1040.114861] ata_dev_set_mode: xfer_shift=0, xfer_mode=0xc
[ 1040.114873] ata1.00: configured for PIO4
[ 1040.114883] ata_eh_recover: EXIT, rc=0
[ 1040.114907] ata_scsi_error: EXIT
[ 1040.114957] ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
[ 1040.115051] ata_scsi_dump_cdb: CDB (1:0,0,0) 1b 00 00 00 01 00 00 00 00
[ 1040.115118] ata_exec_command: ata1: cmd 0x40
[ 1043.605018] ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
[ 1043.605039] ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
[ 1043.605128] ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
[ 1043.990208] Restarting tasks ... done.
[ 1043.995913] sd 0:0:0:0: [sda] 8404830 512-byte hardware sectors (4303 MB)
[ 1044.004169] ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
[ 1044.011083] sd 0:0:0:0: [sda] Write Protect is off
[ 1044.016047] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ 1044.016134] ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
[ 1044.023085] ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
[ 1044.029978] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
