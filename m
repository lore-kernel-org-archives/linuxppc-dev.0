Return-Path: <bzolnier@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 74EFCDE4CC
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 05:29:26 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so10579nfd.9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 12:29:24 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: ide pmac breakage
Date: Tue, 29 Jul 2008 21:26:11 +0200
References: <1217208596.11188.144.camel@pasglop>
	<200807291404.46906.bzolnier@gmail.com>
	<200807291645.03382.bzolnier@gmail.com>
In-Reply-To: <200807291645.03382.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807292126.12238.bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 29 July 2008, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 29 July 2008, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 29 July 2008, Benjamin Herrenschmidt wrote:
> > > On Tue, 2008-07-29 at 13:41 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > > Well, all I do is call into Bart's new helpers to scan for or
> > > > unregister
> > > > > devices ...
> > > > 
> > > > The switch to these helpers happened _before_ 2.6.26 and it shouldn't
> > > > bring
> > > > such behavior change (ditto for new IDE host addition/removal
> > > > helpers)...
> > > > 
> > > > Please try to git-bisect it when you have some time.
> > > 
> > > Ok, I will. I worked fine when I last tried your patches. I'll see if I
> > > can track it down too. Been a bit too busy lately as you can imagine.
> > > 
> > > Do you have something that exercise the same code path you can use ?
> > 
> > I'll see if I can reproduce it with IDE warm-plug support later...
> 
> OK, I reproduced it here with IDE warm-plug support
> (echo -n "1" > /sys/class/ide_port/ide*/delete_devices)
> for devices driven by ide-cd.
> 
> It is also reproducible under qemu so I'm scripting it
> into git-bisect run now...

I WON!!!

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix regression caused by ide_device_{get,put}() addition

On Monday 28 July 2008, Benjamin Herrenschmidt wrote:

[...]

> Vector: 300 (Data Access) at [c58b7b80]
>     pc: c014f264: elv_may_queue+0x10/0x44
>     lr: c0152750: get_request+0x2c/0x2c0
>     sp: c58b7c30
>    msr: 1032
>    dar: c
>  dsisr: 40000000
>   current = 0xc58aaae0
>     pid   = 854, comm = media-bay
> enter ? for help
> mon> t
> [c58b7c40] c0152750 get_request+0x2c/0x2c0
> [c58b7c70] c0152a08 get_request_wait+0x24/0xec
> [c58b7cc0] c0225674 ide_cd_queue_pc+0x58/0x1a0
> [c58b7d40] c022672c ide_cdrom_packet+0x9c/0xdc
> [c58b7d70] c0261810 cdrom_get_disc_info+0x60/0xd0
> [c58b7dc0] c026208c cdrom_mrw_exit+0x1c/0x11c
> [c58b7e30] c0260f7c unregister_cdrom+0x84/0xe8
> [c58b7e50] c022395c ide_cd_release+0x80/0x84
> [c58b7e70] c0163650 kref_put+0x54/0x6c
> [c58b7e80] c0223884 ide_cd_put+0x40/0x5c
> [c58b7ea0] c0211100 generic_ide_remove+0x28/0x3c
> [c58b7eb0] c01e9d34 __device_release_driver+0x78/0xb4
> [c58b7ec0] c01e9e44 device_release_driver+0x28/0x44
> [c58b7ee0] c01e8f7c bus_remove_device+0xac/0xd8
> [c58b7f00] c01e7424 device_del+0x104/0x198
> [c58b7f20] c01e74d0 device_unregister+0x18/0x30
> [c58b7f40] c02121c4 __ide_port_unregister_devices+0x6c/0x88
> [c58b7f60] c0212398 ide_port_unregister_devices+0x38/0x80
> [c58b7f80] c0208ca4 media_bay_step+0x1cc/0x5c0
> [c58b7fb0] c0209124 media_bay_task+0x8c/0xcc
> [c58b7fd0] c00485c0 kthread+0x48/0x84
> [c58b7ff0] c0011b20 kernel_thread+0x44/0x60

The guilty commit turned out to be 08da591e14cf87247ec09b17c350235157a92fc3
("ide: add ide_device_{get,put}() helpers").  ide_device_put() is called
before kref_put() in ide_cd_put() so IDE device is already gone by the time
ide_cd_release() is reached.

Fix it by calling ide_device_get() before kref_get() and ide_device_put()
after kref_put() in all affected device drivers.

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c     |   10 +++++-----
 drivers/ide/ide-disk.c   |    9 ++++-----
 drivers/ide/ide-floppy.c |    9 ++++-----
 drivers/ide/ide-tape.c   |    9 ++++-----
 drivers/scsi/ide-scsi.c  |    9 ++++-----
 5 files changed, 21 insertions(+), 25 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -66,11 +66,11 @@ static struct cdrom_info *ide_cd_get(str
 	mutex_lock(&idecd_ref_mutex);
 	cd = ide_cd_g(disk);
 	if (cd) {
-		kref_get(&cd->kref);
-		if (ide_device_get(cd->drive)) {
-			kref_put(&cd->kref, ide_cd_release);
+		if (ide_device_get(cd->drive))
 			cd = NULL;
-		}
+		else
+			kref_get(&cd->kref);
+
 	}
 	mutex_unlock(&idecd_ref_mutex);
 	return cd;
@@ -79,8 +79,8 @@ static struct cdrom_info *ide_cd_get(str
 static void ide_cd_put(struct cdrom_info *cd)
 {
 	mutex_lock(&idecd_ref_mutex);
-	ide_device_put(cd->drive);
 	kref_put(&cd->kref, ide_cd_release);
+	ide_device_put(cd->drive);
 	mutex_unlock(&idecd_ref_mutex);
 }
 
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -65,11 +65,10 @@ static struct ide_disk_obj *ide_disk_get
 	mutex_lock(&idedisk_ref_mutex);
 	idkp = ide_disk_g(disk);
 	if (idkp) {
-		kref_get(&idkp->kref);
-		if (ide_device_get(idkp->drive)) {
-			kref_put(&idkp->kref, ide_disk_release);
+		if (ide_device_get(idkp->drive))
 			idkp = NULL;
-		}
+		else
+			kref_get(&idkp->kref);
 	}
 	mutex_unlock(&idedisk_ref_mutex);
 	return idkp;
@@ -78,8 +77,8 @@ static struct ide_disk_obj *ide_disk_get
 static void ide_disk_put(struct ide_disk_obj *idkp)
 {
 	mutex_lock(&idedisk_ref_mutex);
-	ide_device_put(idkp->drive);
 	kref_put(&idkp->kref, ide_disk_release);
+	ide_device_put(idkp->drive);
 	mutex_unlock(&idedisk_ref_mutex);
 }
 
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -167,11 +167,10 @@ static struct ide_floppy_obj *ide_floppy
 	mutex_lock(&idefloppy_ref_mutex);
 	floppy = ide_floppy_g(disk);
 	if (floppy) {
-		kref_get(&floppy->kref);
-		if (ide_device_get(floppy->drive)) {
-			kref_put(&floppy->kref, idefloppy_cleanup_obj);
+		if (ide_device_get(floppy->drive))
 			floppy = NULL;
-		}
+		else
+			kref_get(&floppy->kref);
 	}
 	mutex_unlock(&idefloppy_ref_mutex);
 	return floppy;
@@ -180,8 +179,8 @@ static struct ide_floppy_obj *ide_floppy
 static void ide_floppy_put(struct ide_floppy_obj *floppy)
 {
 	mutex_lock(&idefloppy_ref_mutex);
-	ide_device_put(floppy->drive);
 	kref_put(&floppy->kref, idefloppy_cleanup_obj);
+	ide_device_put(floppy->drive);
 	mutex_unlock(&idefloppy_ref_mutex);
 }
 
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -331,11 +331,10 @@ static struct ide_tape_obj *ide_tape_get
 	mutex_lock(&idetape_ref_mutex);
 	tape = ide_tape_g(disk);
 	if (tape) {
-		kref_get(&tape->kref);
-		if (ide_device_get(tape->drive)) {
-			kref_put(&tape->kref, ide_tape_release);
+		if (ide_device_get(tape->drive))
 			tape = NULL;
-		}
+		else
+			kref_get(&tape->kref);
 	}
 	mutex_unlock(&idetape_ref_mutex);
 	return tape;
@@ -344,8 +343,8 @@ static struct ide_tape_obj *ide_tape_get
 static void ide_tape_put(struct ide_tape_obj *tape)
 {
 	mutex_lock(&idetape_ref_mutex);
-	ide_device_put(tape->drive);
 	kref_put(&tape->kref, ide_tape_release);
+	ide_device_put(tape->drive);
 	mutex_unlock(&idetape_ref_mutex);
 }
 
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -102,11 +102,10 @@ static struct ide_scsi_obj *ide_scsi_get
 	mutex_lock(&idescsi_ref_mutex);
 	scsi = ide_scsi_g(disk);
 	if (scsi) {
-		scsi_host_get(scsi->host);
-		if (ide_device_get(scsi->drive)) {
-			scsi_host_put(scsi->host);
+		if (ide_device_get(scsi->drive))
 			scsi = NULL;
-		}
+		else
+			scsi_host_get(scsi->host);
 	}
 	mutex_unlock(&idescsi_ref_mutex);
 	return scsi;
@@ -115,8 +114,8 @@ static struct ide_scsi_obj *ide_scsi_get
 static void ide_scsi_put(struct ide_scsi_obj *scsi)
 {
 	mutex_lock(&idescsi_ref_mutex);
-	ide_device_put(scsi->drive);
 	scsi_host_put(scsi->host);
+	ide_device_put(scsi->drive);
 	mutex_unlock(&idescsi_ref_mutex);
 }
 
