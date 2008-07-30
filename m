Return-Path: <bzolnier@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id ED569DDF33
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 05:46:03 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so166682fke.9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 12:46:01 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: ide pmac breakage
Date: Wed, 30 Jul 2008 21:11:54 +0200
References: <1217208596.11188.144.camel@pasglop>
	<200807292126.12238.bzolnier@gmail.com>
	<1217401052.11188.318.camel@pasglop>
In-Reply-To: <1217401052.11188.318.camel@pasglop>
MIME-Version: 1.0
Message-Id: <200807302111.54514.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="utf-8"
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

On Wednesday 30 July 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-07-29 at 21:26 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > I WON!!!
> 
> Only half...

Heh, I wasn't talking about fixing the issue...
(hint: look up the author of the bad commit).

> It goes further and then blows up again. First problem is, this
> unregister interface doesn't quite convey the fact that the HW is gone
> and the IDE code seems to take it's sweet time figuring it out after
> trying some requests. Maybe something smarter can be done here ? ie,
> ide_set_interface_dead() :-)

Sure, it would be great to have controller hotplug working reliably
one day but the recent patches shouldn't really be making things worse
(quite the contrary) so I would prefer to find and learn more about
the cause of regression first.

[ However nothing prevents us from improving the hotplug support in
  parallel to fixing the issue so if you have some ideas that could
  be conveyed in form of patches please go ahead. ]

> mediabay0: switching to 7
> mediabay0: powering down
> media bay 0 is empty
> hdc: status error: status=0x00 { }
> ide: failed opcode was: unknown
> hdc: status error: status=0x00 { }
> ide: failed opcode was: unknown
> 
> Then after this couple of failed attempts at sending commands, it
> crashes with the backtrace below. Another NULL dereference apparently,
> though the DAR value (the faulting address) has been slightly different
> between consecutive tests so it may be a use-after-free too.

Is it actually caused by additional reference counting on drive->gendev?
IOW if you reverse the patch below instead of applying the previous fix
do things work OK again?

> Note that there shouldn't be anything fundamentally different from
> ide-pmac here vs. something like pcmcia IDE cards... do you have one of
> these to test with ?

Nope and I really don't intend to have one.  I count on other people
to take some care of support for host drivers that they maintain/use. ;)

Thanks,
Bart

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 4e73aee..8f253e5 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -57,23 +57,29 @@ static DEFINE_MUTEX(idecd_ref_mutex);
 #define ide_cd_g(disk) \
 	container_of((disk)->private_data, struct cdrom_info, driver)
 
+static void ide_cd_release(struct kref *);
+
 static struct cdrom_info *ide_cd_get(struct gendisk *disk)
 {
 	struct cdrom_info *cd = NULL;
 
 	mutex_lock(&idecd_ref_mutex);
 	cd = ide_cd_g(disk);
-	if (cd)
+	if (cd) {
 		kref_get(&cd->kref);
+		if (ide_device_get(cd->drive)) {
+			kref_put(&cd->kref, ide_cd_release);
+			cd = NULL;
+		}
+	}
 	mutex_unlock(&idecd_ref_mutex);
 	return cd;
 }
 
-static void ide_cd_release(struct kref *);
-
 static void ide_cd_put(struct cdrom_info *cd)
 {
 	mutex_lock(&idecd_ref_mutex);
+	ide_device_put(cd->drive);
 	kref_put(&cd->kref, ide_cd_release);
 	mutex_unlock(&idecd_ref_mutex);
 }
