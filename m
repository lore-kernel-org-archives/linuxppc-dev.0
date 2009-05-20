Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 14877DE160
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 01:52:21 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 13so1686483fge.16
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 08:52:19 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrey Gusev <a.gusev1980@mail.ru>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Wed, 20 May 2009 17:56:14 +0200
References: <20090425170203.74603b9c@power-debian>
	<200905132046.33663.bzolnier@gmail.com>
	<20090516004007.3a7b9787@power-debian>
In-Reply-To: <20090516004007.3a7b9787@power-debian>
MIME-Version: 1.0
Message-Id: <200905201756.14769.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 15 May 2009 22:40:07 Andrey Gusev wrote:
> On Wed, 13 May 2009 20:46:33 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Wednesday 13 May 2009 19:11:23 Andrey Gusev wrote:
> > > On Wed, 13 May 2009 15:28:26 +0200
> > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > 
> > > > On Tuesday 12 May 2009 21:50:24 Andrey Gusev wrote:
> > > > > On Mon, 27 Apr 2009 23:21:48 +0200
> > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > 
> > > > > > On Monday 27 April 2009 22:36:45 Andrey Gusev wrote:
> > > > > > > On Sat, 25 Apr 2009 16:48:38 +0200
> > > > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > > > 
> > > > > > > > 
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> > > > > > > > > Hello!
> > > > > > > > > 
> > > > > > > > > I have tested linux-2.6.30-rc3 on my system and find
> > > > > > > > > some problems. One of them is delaying on
> > > > > > > > > initialization IDE subsystem. I don't have this problem
> > > > > > > > > on 2.6.29.1. The difference is looked on log of dmesg.
> > > > > > > > 
> > > > > > > > Unfortunately this doesn't give us any hint about the root
> > > > > > > > cause of the bug so please try narrowing the problem down
> > > > > > > > to the specific change using git-bisect (sorry, there
> > > > > > > > were 212 drivers/ide/ commits during v2.6.29..v2.6.30-rc3
> > > > > > > > and much much more non-drivers/ide/ ones).
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Bart
> > > > > > > > 
> > > > > > > 
> > > > > > > Hello!
> > > > > > > 
> > > > > > > 
> > > > > > > The full result of bisect is:
> > > > > > > 
> > > > > > > 
> > > > > > > git bisect start
> > > > > > > # good: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux
> > > > > > > 2.6.29 git bisect good
> > > > > > > 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84 # bad:
> > > > > > > [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
> > > > > > > git bisect bad 091069740304c979f957ceacec39c461d0192158 #
> > > > > > > good: [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB
> > > > > > > (11166): pvrusb2: Implement status fetching from
> > > > > > > sub-devices git bisect good
> > > > > > > 40f07111be99b71c1e8d40c13cdc38445add787f # good:
> > > > > > > [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg:
> > > > > > > slicoss: Specify the license for Sahara SXG and Slicoss
> > > > > > > drivers git bisect good
> > > > > > > ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> > > > > > > 
> > > > > > > 
> > > > > > > git bisect start 'drivers/ide/'
> > > > > > 
> > > > > > Please note that limiting search space to drivers/ide/ may not
> > > > > > give reliable results in case problem was introduced by some
> > > > > > other kernel area.
> > > > > > 
> > > > > > > # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging:
> > > > > > > sxg: slicoss: Specify the license for Sahara SXG and
> > > > > > > Slicoss drivers git bisect good
> > > > > > > ba0e1ebb7ea0616eebc29d2077355bacea62a9d8 # bad:
> > > > > > > [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
> > > > > > > git bisect bad 091069740304c979f957ceacec39c461d0192158 #
> > > > > > > good: [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd:
> > > > > > > convert cdrom_decode_status() to use switch statements git
> > > > > > > bisect good e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d #
> > > > > > > good: [3153c26b54230d025c6d536e8d3015def4524906] ide:
> > > > > > > refactor tf_read() method git bisect good
> > > > > > > 3153c26b54230d025c6d536e8d3015def4524906 # good:
> > > > > > > [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix
> > > > > > > HPT370 DMA timeouts git bisect good
> > > > > > > c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac # bad:
> > > > > > > [d5f840bf74c09ca5a31e518c9d984999926b5f44] ide: Remove void
> > > > > > > casts git bisect bad
> > > > > > > d5f840bf74c09ca5a31e518c9d984999926b5f44 # bad:
> > > > > > > [59c8d04f5ee97ea46da854e9adbbaa45d988c39d] hpt366: use
> > > > > > > ATA_DMA_* constants git bisect bad
> > > > > > > 59c8d04f5ee97ea46da854e9adbbaa45d988c39d
> > > > > > 
> > > > > > Uhh.. something went wrong during bisect.
> > > > > > 
> > > > > > "hpt366: use ATA_DMA_* constants" cannot be a first bad commit
> > > > > > because hpt366 is not even used on this system.
> > > > > > 
> > > > > > Could it be that the delay doesn't happen on every boot for
> > > > > > "bad" kernels?
> > > > > > 
> > > > > > Also, is 2.6.30-rc1 okay?
> > > > > > 
> > > > > > Thanks,
> > > > > > Bart
> > > > > > 
> > > > > 
> > > > > Hello all!
> > > > > 
> > > > > I continue to find reason of bug. I made more testing with
> > > > > bisect and got result:
> > > > > 
> > > > > git bisect start
> > > > > # bad: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix
> > > > > HPT370 DMA timeouts git bisect bad
> > > > >  # good:
> > > > > [fb4252e59452c18b88af014a2c4ee697bbf8cbc6] at91_ide: turn on
> > > > > PIO 6 support git bisect good
> > > > > fb4252e59452c18b88af014a2c4ee697bbf8cbc6 # good:
> > > > > [2e1c63b7ed36532b68f0eddd6a184d7ba1013b89] Merge branch
> > > > > 'for-rc1/xen/core' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen git
> > > > > bisect good 2e1c63b7ed36532b68f0eddd6a184d7ba1013b89 # bad:
> > > > > [cd97824994042b809493807ea644ba26c0c23290] Merge
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6 git
> > > > > bisect bad cd97824994042b809493807ea644ba26c0c23290 # bad:
> > > > > [a2c252ebdeaab28c9b400570594d576dae295958] Merge
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes
> > > > > git bisect bad a2c252ebdeaab28c9b400570594d576dae295958 # good:
> > > > > [b897e6fbc49dd84b2634bca664344d503b907ce9] Merge branch
> > > > > 'drm-intel-next' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/anholt/drm-intel
> > > > > git bisect good b897e6fbc49dd84b2634bca664344d503b907ce9 #
> > > > > good: [dfbc4752eab33e66f113f9daa2effbe241cd661d] brd: support
> > > > > barriers git bisect good
> > > > > dfbc4752eab33e66f113f9daa2effbe241cd661d # good:
> > > > > [a23c218bd36e11120daf18e00a91d5dc20e288e6] Merge branch 'merge'
> > > > > of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> > > > > git bisect good a23c218bd36e11120daf18e00a91d5dc20e288e6 #
> > > > > good: [23da64b4714812b66ecf010e7dfb3ed1bf2eda69] Merge branch
> > > > > 'for-linus' of git://git.kernel.dk/linux-2.6-block git bisect
> > > > > good 23da64b4714812b66ecf010e7dfb3ed1bf2eda69 # good:
> > > > > [a228df6339e0d385b8149c860d81b6007f5e9c81] GFS2: Move umount
> > > > > flush rwsem git bisect good
> > > > > a228df6339e0d385b8149c860d81b6007f5e9c81 # skip:
> > > > > [1328df725239804ae30fc7257c1a3185e679b517] GFS2: Use
> > > > > DEFINE_SPINLOCK git bisect skip
> > > > > 1328df725239804ae30fc7257c1a3185e679b517 # good:
> > > > > [10d2198805d7faa2b193485446ff6b1de42c9b78] GFS2: cleanup
> > > > > file_operations mess git bisect good
> > > > > 10d2198805d7faa2b193485446ff6b1de42c9b78
> > > > > 
> > > > > As I understand, I found bad commit, but it includes 5 commits.
> > > > > I checked them and they are good. So, I did git checkout
> > > > > a2c252ebdeaab28c9b400570594d576dae295958 and test one more time
> > > > > this commit. I found that bag is unstable. The boot can be bad
> > > > > or good on this commit. I compared dmesg of 'bad' and 'good'
> > > > > booting, but it is equal till delay. 
> > > > 
> > > > Thanks for doing it.
> > > > 
> > > > > Any suggestions?
> > > > 
> > > > Hard to tell...
> > > > 
> > > > I went through all commits in-between
> > > > 
> > > > 	fb4252e59452c18b88af014a2c4ee697bbf8cbc6
> > > > 
> > > > and
> > > > 
> > > > 	a2c252ebdeaab28c9b400570594d576dae295958
> > > > 
> > > > and there are no obvious candidates..
> > > > 
> > > > Could you please refresh my memory and tell me whether 2.6.30-rc2
> > > > was OK?
> > > > 
> > > 
> > > It was ok, but I don't sure now. I tested only one boot, but this
> > > problem is not stable. I am rechecking it.
> > 
> > Ok.
> > 
> > Please also recheck first 'good' commit if 2.6.30-rc2 turns out to be
> > 'bad'.
> 
> My last testing is very interesting. I check boot of each kernel at
> least 10 times. I checked 2.6.30-rc2, it is good. Rest results:
> 
> git bisect start
> # good: [0882e8dd3aad33eca41696d463bb896e6c8817eb] Linux 2.6.30-rc2
> git bisect good 0882e8dd3aad33eca41696d463bb896e6c8817eb
> # bad: [a2c252ebdeaab28c9b400570594d576dae295958] Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes git
> bisect bad a2c252ebdeaab28c9b400570594d576dae295958 # good:
> [c2572f2b4ffc27ba79211aceee3bef53a59bb5cd] brd: fix cacheflushing git
> bisect good c2572f2b4ffc27ba79211aceee3bef53a59bb5cd # bad:
> [b71a0c296cee4debaf446760fbd29ead1587a7ac] powerpc: pseries/dtl.c
> should include asm/firmware.h git bisect bad
> b71a0c296cee4debaf446760fbd29ead1587a7ac
> 
> Last commit had delay only on 10 time, but it ripped my system, I can't
> read any place on my hard drive. I can't mount any other device on it.
> Fortunately, I have tmpfs and I mounted second hard disk on it place.
> After my computer didn't turn on. It looks like dead drive or
> controller, but after on/off and replace disks, it has alived. Below
> is log of this bad boot.

I think that is an old problem which for some reasons gets triggered more
easily in newer kernels or a hardware issue (or just combination of both).

[...]

> > [ BTW the above bisection points that the problem was introduced
> > outside of drivers/ide or that it was introduced earlier that we'd
> > initially thought ]
> > 
> > > I have added second hard drive and got new issue. May be this log
> > > (dmesg) can tell you something. It is on first known 'bad commit'.
> > > 2.6.29.2 can't properly
> > 
> > It tells us that there is some IRQ routing problem... seems like a
> > platform or ide-pmac specific problem.  Does some earlier kernel work
> > OK with this configuration?
> 
> I have Debian's 2.6.26, it has same problem. Don't take attention to time, I 
> caught another bug on Aureal Vortex2, this driver kills kernel completely and
> system time too. I am lucky on bugs on this machine.

[...]

> [477194869.958131] hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive

[...]

> [477194895.065957] ide-pmac lost interrupt, dma status: 8480
> [477194895.068535] hdb: lost interrupt
> [477194895.070952] hdb: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> [477194895.073444] ide: failed opcode was: unknown
> [477194895.076053] hda: DMA disabled
> [477194895.078504] hdb: DMA disabled
> [477194895.209948] ide0: reset: success
> [477194895.430619]  hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >

This drive is one of the "quirky" drives which has special workarounds in
some host drivers...

OK, lets try something else.  I went through IDE code and fixed outstanding
issues which may be related to these problems + mixed-in pending bugfixes.

The end result is a patch for 2.6.30-rc6 below, please try it.

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 0feb66c..7ce68ef 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -138,14 +138,6 @@
 #undef	HPT_RESET_STATE_ENGINE
 #undef	HPT_DELAY_INTERRUPT
 
-static const char *quirk_drives[] = {
-	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP LM20.5",
-	NULL
-};
-
 static const char *bad_ata100_5[] = {
 	"IBM-DTLA-307075",
 	"IBM-DTLA-307060",
@@ -729,27 +721,13 @@ static void hpt3xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	hpt3xx_set_mode(drive, XFER_PIO_0 + pio);
 }
 
-static void hpt3xx_quirkproc(ide_drive_t *drive)
-{
-	char *m			= (char *)&drive->id[ATA_ID_PROD];
-	const  char **list	= quirk_drives;
-
-	while (*list)
-		if (strstr(m, *list++)) {
-			drive->quirk_list = 1;
-			return;
-		}
-
-	drive->quirk_list = 0;
-}
-
 static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
 {
 	ide_hwif_t *hwif	= drive->hwif;
 	struct pci_dev	*dev	= to_pci_dev(hwif->dev);
 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 
-	if (drive->quirk_list == 0)
+	if ((drive->dev_flags & IDE_DFLAG_NIEN_QUIRK) == 0)
 		return;
 
 	if (info->chip_type >= HPT370) {
@@ -1404,7 +1382,6 @@ static int __devinit hpt36x_init(struct pci_dev *dev, struct pci_dev *dev2)
 static const struct ide_port_ops hpt3xx_port_ops = {
 	.set_pio_mode		= hpt3xx_set_pio_mode,
 	.set_dma_mode		= hpt3xx_set_mode,
-	.quirkproc		= hpt3xx_quirkproc,
 	.maskproc		= hpt3xx_maskproc,
 	.mdma_filter		= hpt3xx_mdma_filter,
 	.udma_filter		= hpt3xx_udma_filter,
diff --git a/drivers/ide/ide-eh.c b/drivers/ide/ide-eh.c
index 5d5fb96..fab7e89 100644
--- a/drivers/ide/ide-eh.c
+++ b/drivers/ide/ide-eh.c
@@ -408,8 +408,9 @@ static ide_startstop_t do_reset1(ide_drive_t *drive, int do_not_try_atapi)
 	/* more than enough time */
 	udelay(10);
 	/* clear SRST, leave nIEN (unless device is on the quirk list) */
-	tp_ops->write_devctl(hwif, (drive->quirk_list == 2 ? 0 : ATA_NIEN) |
-			     ATA_DEVCTL_OBS);
+	tp_ops->write_devctl(hwif,
+		((drive->dev_flags & IDE_DFLAG_NIEN_QUIRK) ? 0 : ATA_NIEN) |
+		 ATA_DEVCTL_OBS);
 	/* more than enough time */
 	udelay(10);
 	hwif->poll_timeout = jiffies + WAIT_WORSTCASE;
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 35dc38d..a4622b8 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -503,11 +503,15 @@ repeat:
 
 		if ((hwif->host->host_flags & IDE_HFLAG_SERIALIZE) &&
 		    hwif != prev_port) {
+			ide_drive_t *cur_dev =
+				prev_port ? prev_port->cur_dev : NULL;
+
 			/*
 			 * set nIEN for previous port, drives in the
-			 * quirk_list may not like intr setups/cleanups
+			 * quirk list may not like intr setups/cleanups
 			 */
-			if (prev_port && prev_port->cur_dev->quirk_list == 0)
+			if (cur_dev &&
+			    (cur_dev->dev_flags & IDE_DFLAG_NIEN_QUIRK) == 0)
 				prev_port->tp_ops->write_devctl(prev_port,
 								ATA_NIEN |
 								ATA_DEVCTL_OBS);
@@ -696,7 +700,7 @@ void ide_timer_expiry (unsigned long data)
 		}
 		spin_lock_irq(&hwif->lock);
 		enable_irq(hwif->irq);
-		if (startstop == ide_stopped) {
+		if (startstop == ide_stopped && hwif->polling == 0) {
 			ide_unlock_port(hwif);
 			plug_device = 1;
 		}
@@ -868,7 +872,7 @@ irqreturn_t ide_intr (int irq, void *dev_id)
 	 * same irq as is currently being serviced here, and Linux
 	 * won't allow another of the same (on any CPU) until we return.
 	 */
-	if (startstop == ide_stopped) {
+	if (startstop == ide_stopped && hwif->polling == 0) {
 		BUG_ON(hwif->handler);
 		ide_unlock_port(hwif);
 		plug_device = 1;
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index c19a221..c1b5e86 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -269,6 +269,29 @@ no_80w:
 	return 0;
 }
 
+static const char *nien_quirk_list[] = {
+	"QUANTUM FIREBALLlct08 08",
+	"QUANTUM FIREBALLP KA6.4",
+	"QUANTUM FIREBALLP KA9.1",
+	"QUANTUM FIREBALLP KX13.6",
+	"QUANTUM FIREBALLP KX20.5",
+	"QUANTUM FIREBALLP KX27.3",
+	"QUANTUM FIREBALLP LM20.4",
+	"QUANTUM FIREBALLP LM20.5",
+	NULL
+};
+
+void ide_check_nien_quirk_list(ide_drive_t *drive)
+{
+	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
+
+	for (list = nien_quirk_list; *list != NULL; list++)
+		if (strstr(m, *list) != NULL) {
+			drive->dev_flags |= IDE_DFLAG_NIEN_QUIRK;
+			return;
+		}
+}
+
 int ide_driveid_update(ide_drive_t *drive)
 {
 	u16 *id;
@@ -352,7 +375,7 @@ int ide_config_drive_speed(ide_drive_t *drive, u8 speed)
 
 	tp_ops->exec_command(hwif, ATA_CMD_SET_FEATURES);
 
-	if (drive->quirk_list == 2)
+	if (drive->dev_flags & IDE_DFLAG_NIEN_QUIRK)
 		tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	error = __ide_wait_stat(drive, drive->ready_stat,
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 7f264ed..2399bc0 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -295,7 +295,7 @@ int ide_dev_read_id(ide_drive_t *drive, u8 cmd, u16 *id)
 
 	timeout = ((cmd == ATA_CMD_ID_ATA) ? WAIT_WORSTCASE : WAIT_PIDENTIFY) / 2;
 
-	if (ide_busy_sleep(hwif, timeout, use_altstatus))
+	if (ide_busy_sleep(drive, timeout, use_altstatus))
 		return 1;
 
 	/* wait for IRQ and ATA_DRQ */
@@ -316,8 +316,9 @@ int ide_dev_read_id(ide_drive_t *drive, u8 cmd, u16 *id)
 	return rc;
 }
 
-int ide_busy_sleep(ide_hwif_t *hwif, unsigned long timeout, int altstatus)
+int ide_busy_sleep(ide_drive_t *drive, unsigned long timeout, int altstatus)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	u8 stat;
 
 	timeout += jiffies;
@@ -330,6 +331,8 @@ int ide_busy_sleep(ide_hwif_t *hwif, unsigned long timeout, int altstatus)
 			return 0;
 	} while (time_before(jiffies, timeout));
 
+	printk(KERN_ERR "%s: timeout in %s\n", drive->name, __func__);
+
 	return 1;	/* drive timed-out */
 }
 
@@ -420,7 +423,7 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
 			tp_ops->dev_select(drive);
 			msleep(50);
 			tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
-			(void)ide_busy_sleep(hwif, WAIT_WORSTCASE, 0);
+			(void)ide_busy_sleep(drive, WAIT_WORSTCASE, 0);
 			rc = ide_dev_read_id(drive, cmd, id);
 		}
 
@@ -699,8 +702,12 @@ static int ide_probe_port(ide_hwif_t *hwif)
 	if (irqd)
 		disable_irq(hwif->irq);
 
-	if (ide_port_wait_ready(hwif) == -EBUSY)
-		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
+	rc = ide_port_wait_ready(hwif);
+	if (rc == -ENODEV) {
+		printk(KERN_INFO "%s: no devices on the port\n", hwif->name);
+		goto out;
+	} else if (rc == -EBUSY)
+		printk(KERN_ERR "%s: not ready before the probe\n", hwif->name);
 
 	/*
 	 * Second drive should only exist if first drive was found,
@@ -711,7 +718,7 @@ static int ide_probe_port(ide_hwif_t *hwif)
 		if (drive->dev_flags & IDE_DFLAG_PRESENT)
 			rc = 0;
 	}
-
+out:
 	/*
 	 * Use cached IRQ number. It might be (and is...) changed by probe
 	 * code above
@@ -729,6 +736,8 @@ static void ide_port_tune_devices(ide_hwif_t *hwif)
 	int i;
 
 	ide_port_for_each_present_dev(i, drive, hwif) {
+		ide_check_nien_quirk_list(drive);
+
 		if (port_ops && port_ops->quirkproc)
 			port_ops->quirkproc(drive);
 	}
diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index b68906c..65ba823 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -40,18 +40,6 @@
 #define DBG(fmt, args...)
 #endif
 
-static const char *pdc_quirk_drives[] = {
-	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP KA9.1",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP KX13.6",
-	"QUANTUM FIREBALLP KX20.5",
-	"QUANTUM FIREBALLP KX27.3",
-	"QUANTUM FIREBALLP LM20.5",
-	NULL
-};
-
 static u8 max_dma_rate(struct pci_dev *pdev)
 {
 	u8 mode;
@@ -200,19 +188,6 @@ static u8 pdcnew_cable_detect(ide_hwif_t *hwif)
 		return ATA_CBL_PATA80;
 }
 
-static void pdcnew_quirkproc(ide_drive_t *drive)
-{
-	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
-
-	for (list = pdc_quirk_drives; *list != NULL; list++)
-		if (strstr(m, *list) != NULL) {
-			drive->quirk_list = 2;
-			return;
-		}
-
-	drive->quirk_list = 0;
-}
-
 static void pdcnew_reset(ide_drive_t *drive)
 {
 	/*
@@ -473,7 +448,6 @@ static struct pci_dev * __devinit pdc20270_get_dev2(struct pci_dev *dev)
 static const struct ide_port_ops pdcnew_port_ops = {
 	.set_pio_mode		= pdcnew_set_pio_mode,
 	.set_dma_mode		= pdcnew_set_dma_mode,
-	.quirkproc		= pdcnew_quirkproc,
 	.resetproc		= pdcnew_reset,
 	.cable_detect		= pdcnew_cable_detect,
 };
diff --git a/drivers/ide/pdc202xx_old.c b/drivers/ide/pdc202xx_old.c
index 248a54b..ed5df32 100644
--- a/drivers/ide/pdc202xx_old.c
+++ b/drivers/ide/pdc202xx_old.c
@@ -23,18 +23,6 @@
 
 #define PDC202XX_DEBUG_DRIVE_INFO	0
 
-static const char *pdc_quirk_drives[] = {
-	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP KA9.1",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP KX13.6",
-	"QUANTUM FIREBALLP KX20.5",
-	"QUANTUM FIREBALLP KX27.3",
-	"QUANTUM FIREBALLP LM20.5",
-	NULL
-};
-
 static void pdc_old_disable_66MHz_clock(ide_hwif_t *);
 
 static void pdc202xx_set_mode(ide_drive_t *drive, const u8 speed)
@@ -151,19 +139,6 @@ static void pdc_old_disable_66MHz_clock(ide_hwif_t *hwif)
 	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
 }
 
-static void pdc202xx_quirkproc(ide_drive_t *drive)
-{
-	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
-
-	for (list = pdc_quirk_drives; *list != NULL; list++)
-		if (strstr(m, *list) != NULL) {
-			drive->quirk_list = 2;
-			return;
-		}
-
-	drive->quirk_list = 0;
-}
-
 static void pdc202xx_dma_start(ide_drive_t *drive)
 {
 	if (drive->current_speed > XFER_UDMA_2)
@@ -311,13 +286,11 @@ static void __devinit pdc202ata4_fixup_irq(struct pci_dev *dev,
 static const struct ide_port_ops pdc20246_port_ops = {
 	.set_pio_mode		= pdc202xx_set_pio_mode,
 	.set_dma_mode		= pdc202xx_set_mode,
-	.quirkproc		= pdc202xx_quirkproc,
 };
 
 static const struct ide_port_ops pdc2026x_port_ops = {
 	.set_pio_mode		= pdc202xx_set_pio_mode,
 	.set_dma_mode		= pdc202xx_set_mode,
-	.quirkproc		= pdc202xx_quirkproc,
 	.resetproc		= pdc202xx_reset,
 	.cable_detect		= pdc2026x_cable_detect,
 };
diff --git a/include/linux/ide.h b/include/linux/ide.h
index ff65fff..fa8ffe0 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -474,6 +474,7 @@ enum {
 	IDE_DFLAG_NICE1			= (1 << 5),
 	/* device is physically present */
 	IDE_DFLAG_PRESENT		= (1 << 6),
+	IDE_DFLAG_NIEN_QUIRK		= (1 << 7),
 	/* id read from device (synthetic if not set) */
 	IDE_DFLAG_ID_READ		= (1 << 8),
 	IDE_DFLAG_NOPROBE		= (1 << 9),
@@ -543,7 +544,6 @@ struct ide_drive_s {
 	u8	waiting_for_dma;	/* dma currently in progress */
 	u8	dma;			/* atapi dma flag */
 
-        u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	init_speed;	/* transfer rate set at boot */
         u8	current_speed;	/* current transfer rate set */
 	u8	desired_speed;	/* desired transfer rate set */
@@ -1109,7 +1109,7 @@ void ide_fix_driveid(u16 *);
 
 extern void ide_fixstring(u8 *, const int, const int);
 
-int ide_busy_sleep(ide_hwif_t *, unsigned long, int);
+int ide_busy_sleep(ide_drive_t *, unsigned long, int);
 
 int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
 
@@ -1464,6 +1464,7 @@ static inline void ide_acpi_set_state(ide_hwif_t *hwif, int on) {}
 void ide_register_region(struct gendisk *);
 void ide_unregister_region(struct gendisk *);
 
+void ide_check_nien_quirk_list(ide_drive_t *);
 void ide_undecoded_slave(ide_drive_t *);
 
 void ide_port_apply_params(ide_hwif_t *);
