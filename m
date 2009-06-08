Return-Path: <bzolnier@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 52522B70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 06:23:20 +1000 (EST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215]) by ozlabs.org (Postfix) with ESMTP id AF96EDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 06:23:18 +1000 (EST)
Received: by ewy11 with SMTP id 11so4781908ewy.9
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Jun 2009 13:23:16 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrey Gusev <a.gusev1980@mail.ru>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Mon, 8 Jun 2009 22:20:41 +0200
References: <20090425170203.74603b9c@power-debian>
	<200905201756.14769.bzolnier@gmail.com>
	<20090530144643.76cb456e@power-debian>
In-Reply-To: <20090530144643.76cb456e@power-debian>
MIME-Version: 1.0
Message-Id: <200906082220.41763.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 30 May 2009 12:46:43 Andrey Gusev wrote:
> On Wed, 20 May 2009 17:56:14 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Friday 15 May 2009 22:40:07 Andrey Gusev wrote:
> > > On Wed, 13 May 2009 20:46:33 +0200
> > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > 
> > > > On Wednesday 13 May 2009 19:11:23 Andrey Gusev wrote:
> > > > > On Wed, 13 May 2009 15:28:26 +0200
> > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > 
> > > > > > On Tuesday 12 May 2009 21:50:24 Andrey Gusev wrote:
> > > > > > > On Mon, 27 Apr 2009 23:21:48 +0200
> > > > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > > > 
> > > > > > > > On Monday 27 April 2009 22:36:45 Andrey Gusev wrote:
> > > > > > > > > On Sat, 25 Apr 2009 16:48:38 +0200
> > > > > > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Hi,
> > > > > > > > > > 
> > > > > > > > > > On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> > > > > > > > > > > Hello!
> > > > > > > > > > > 
> > > > > > > > > > > I have tested linux-2.6.30-rc3 on my system and find
> > > > > > > > > > > some problems. One of them is delaying on
> > > > > > > > > > > initialization IDE subsystem. I don't have this
> > > > > > > > > > > problem on 2.6.29.1. The difference is looked on
> > > > > > > > > > > log of dmesg.
> > > > > > > > > > 
> > > > > > > > > > Unfortunately this doesn't give us any hint about the
> > > > > > > > > > root cause of the bug so please try narrowing the
> > > > > > > > > > problem down to the specific change using git-bisect
> > > > > > > > > > (sorry, there were 212 drivers/ide/ commits during
> > > > > > > > > > v2.6.29..v2.6.30-rc3 and much much more
> > > > > > > > > > non-drivers/ide/ ones).
> > > > > > > > > > 
> > > > > > > > > > Thanks,
> > > > > > > > > > Bart
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Hello!
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > The full result of bisect is:
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > git bisect start
> > > > > > > > > # good: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux
> > > > > > > > > 2.6.29 git bisect good
> > > > > > > > > 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84 # bad:
> > > > > > > > > [091069740304c979f957ceacec39c461d0192158] Linux
> > > > > > > > > 2.6.30-rc3 git bisect bad
> > > > > > > > > 091069740304c979f957ceacec39c461d0192158 # good:
> > > > > > > > > [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB
> > > > > > > > > (11166): pvrusb2: Implement status fetching from
> > > > > > > > > sub-devices git bisect good
> > > > > > > > > 40f07111be99b71c1e8d40c13cdc38445add787f # good:
> > > > > > > > > [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging:
> > > > > > > > > sxg: slicoss: Specify the license for Sahara SXG and
> > > > > > > > > Slicoss drivers git bisect good
> > > > > > > > > ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > git bisect start 'drivers/ide/'
> > > > > > > > 
> > > > > > > > Please note that limiting search space to drivers/ide/
> > > > > > > > may not give reliable results in case problem was
> > > > > > > > introduced by some other kernel area.
> > > > > > > > 
> > > > > > > > > # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8]
> > > > > > > > > Staging: sxg: slicoss: Specify the license for Sahara
> > > > > > > > > SXG and Slicoss drivers git bisect good
> > > > > > > > > ba0e1ebb7ea0616eebc29d2077355bacea62a9d8 # bad:
> > > > > > > > > [091069740304c979f957ceacec39c461d0192158] Linux
> > > > > > > > > 2.6.30-rc3 git bisect bad
> > > > > > > > > 091069740304c979f957ceacec39c461d0192158 # good:
> > > > > > > > > [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd:
> > > > > > > > > convert cdrom_decode_status() to use switch statements
> > > > > > > > > git bisect good
> > > > > > > > > e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d # good:
> > > > > > > > > [3153c26b54230d025c6d536e8d3015def4524906] ide:
> > > > > > > > > refactor tf_read() method git bisect good
> > > > > > > > > 3153c26b54230d025c6d536e8d3015def4524906 # good:
> > > > > > > > > [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix
> > > > > > > > > HPT370 DMA timeouts git bisect good
> > > > > > > > > c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac # bad:
> > > > > > > > > [d5f840bf74c09ca5a31e518c9d984999926b5f44] ide: Remove
> > > > > > > > > void casts git bisect bad
> > > > > > > > > d5f840bf74c09ca5a31e518c9d984999926b5f44 # bad:
> > > > > > > > > [59c8d04f5ee97ea46da854e9adbbaa45d988c39d] hpt366: use
> > > > > > > > > ATA_DMA_* constants git bisect bad
> > > > > > > > > 59c8d04f5ee97ea46da854e9adbbaa45d988c39d
> > > > > > > > 
> > > > > > > > Uhh.. something went wrong during bisect.
> > > > > > > > 
> > > > > > > > "hpt366: use ATA_DMA_* constants" cannot be a first bad
> > > > > > > > commit because hpt366 is not even used on this system.
> > > > > > > > 
> > > > > > > > Could it be that the delay doesn't happen on every boot
> > > > > > > > for "bad" kernels?
> > > > > > > > 
> > > > > > > > Also, is 2.6.30-rc1 okay?
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Bart
> > > > > > > > 
> > > > > > > 
> > > > > > > Hello all!
> > > > > > > 
> > > > > > > I continue to find reason of bug. I made more testing with
> > > > > > > bisect and got result:
> > > > > > > 
> > > > > > > git bisect start
> > > > > > > # bad: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366:
> > > > > > > fix HPT370 DMA timeouts git bisect bad
> > > > > > >  # good:
> > > > > > > [fb4252e59452c18b88af014a2c4ee697bbf8cbc6] at91_ide: turn on
> > > > > > > PIO 6 support git bisect good
> > > > > > > fb4252e59452c18b88af014a2c4ee697bbf8cbc6 # good:
> > > > > > > [2e1c63b7ed36532b68f0eddd6a184d7ba1013b89] Merge branch
> > > > > > > 'for-rc1/xen/core' of
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen git
> > > > > > > bisect good 2e1c63b7ed36532b68f0eddd6a184d7ba1013b89 # bad:
> > > > > > > [cd97824994042b809493807ea644ba26c0c23290] Merge
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
> > > > > > > git bisect bad cd97824994042b809493807ea644ba26c0c23290 #
> > > > > > > bad: [a2c252ebdeaab28c9b400570594d576dae295958] Merge
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes
> > > > > > > git bisect bad a2c252ebdeaab28c9b400570594d576dae295958 #
> > > > > > > good: [b897e6fbc49dd84b2634bca664344d503b907ce9] Merge
> > > > > > > branch 'drm-intel-next' of
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/anholt/drm-intel
> > > > > > > git bisect good b897e6fbc49dd84b2634bca664344d503b907ce9 #
> > > > > > > good: [dfbc4752eab33e66f113f9daa2effbe241cd661d] brd:
> > > > > > > support barriers git bisect good
> > > > > > > dfbc4752eab33e66f113f9daa2effbe241cd661d # good:
> > > > > > > [a23c218bd36e11120daf18e00a91d5dc20e288e6] Merge branch
> > > > > > > 'merge' of
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> > > > > > > git bisect good a23c218bd36e11120daf18e00a91d5dc20e288e6 #
> > > > > > > good: [23da64b4714812b66ecf010e7dfb3ed1bf2eda69] Merge
> > > > > > > branch 'for-linus' of git://git.kernel.dk/linux-2.6-block
> > > > > > > git bisect good 23da64b4714812b66ecf010e7dfb3ed1bf2eda69 #
> > > > > > > good: [a228df6339e0d385b8149c860d81b6007f5e9c81] GFS2: Move
> > > > > > > umount flush rwsem git bisect good
> > > > > > > a228df6339e0d385b8149c860d81b6007f5e9c81 # skip:
> > > > > > > [1328df725239804ae30fc7257c1a3185e679b517] GFS2: Use
> > > > > > > DEFINE_SPINLOCK git bisect skip
> > > > > > > 1328df725239804ae30fc7257c1a3185e679b517 # good:
> > > > > > > [10d2198805d7faa2b193485446ff6b1de42c9b78] GFS2: cleanup
> > > > > > > file_operations mess git bisect good
> > > > > > > 10d2198805d7faa2b193485446ff6b1de42c9b78
> > > > > > > 
> > > > > > > As I understand, I found bad commit, but it includes 5
> > > > > > > commits. I checked them and they are good. So, I did git
> > > > > > > checkout a2c252ebdeaab28c9b400570594d576dae295958 and test
> > > > > > > one more time this commit. I found that bag is unstable.
> > > > > > > The boot can be bad or good on this commit. I compared
> > > > > > > dmesg of 'bad' and 'good' booting, but it is equal till
> > > > > > > delay. 
> > > > > > 
> > > > > > Thanks for doing it.
> > > > > > 
> > > > > > > Any suggestions?
> > > > > > 
> > > > > > Hard to tell...
> > > > > > 
> > > > > > I went through all commits in-between
> > > > > > 
> > > > > > 	fb4252e59452c18b88af014a2c4ee697bbf8cbc6
> > > > > > 
> > > > > > and
> > > > > > 
> > > > > > 	a2c252ebdeaab28c9b400570594d576dae295958
> > > > > > 
> > > > > > and there are no obvious candidates..
> > > > > > 
> > > > > > Could you please refresh my memory and tell me whether
> > > > > > 2.6.30-rc2 was OK?
> > > > > > 
> > > > > 
> > > > > It was ok, but I don't sure now. I tested only one boot, but
> > > > > this problem is not stable. I am rechecking it.
> > > > 
> > > > Ok.
> > > > 
> > > > Please also recheck first 'good' commit if 2.6.30-rc2 turns out
> > > > to be 'bad'.
> > > 
> > > My last testing is very interesting. I check boot of each kernel at
> > > least 10 times. I checked 2.6.30-rc2, it is good. Rest results:
> > > 
> > > git bisect start
> > > # good: [0882e8dd3aad33eca41696d463bb896e6c8817eb] Linux 2.6.30-rc2
> > > git bisect good 0882e8dd3aad33eca41696d463bb896e6c8817eb
> > > # bad: [a2c252ebdeaab28c9b400570594d576dae295958] Merge
> > > git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes
> > > git bisect bad a2c252ebdeaab28c9b400570594d576dae295958 # good:
> > > [c2572f2b4ffc27ba79211aceee3bef53a59bb5cd] brd: fix cacheflushing
> > > git bisect good c2572f2b4ffc27ba79211aceee3bef53a59bb5cd # bad:
> > > [b71a0c296cee4debaf446760fbd29ead1587a7ac] powerpc: pseries/dtl.c
> > > should include asm/firmware.h git bisect bad
> > > b71a0c296cee4debaf446760fbd29ead1587a7ac
> > > 
> > > Last commit had delay only on 10 time, but it ripped my system, I
> > > can't read any place on my hard drive. I can't mount any other
> > > device on it. Fortunately, I have tmpfs and I mounted second hard
> > > disk on it place. After my computer didn't turn on. It looks like
> > > dead drive or controller, but after on/off and replace disks, it
> > > has alived. Below is log of this bad boot.
> > 
> > I think that is an old problem which for some reasons gets triggered
> > more easily in newer kernels or a hardware issue (or just combination
> > of both).
> 
> Could it be RCU (it is experimental implementation in this configuratin)
> related? I have booted 2.6.30-rc6, sometimes it has long delay (about 66
> seconds) after: "[    0.000000] Experimental hierarchical RCU implementation."
> Currently I have it enabled on 2.6.29.4 and don't have any problems. 
> I made photos of boots and some faults:
> http://img17.imageshack.us/img17/149/dscn4403b.jpg
> http://img21.imageshack.us/img21/254/dscn4407v.jpg
> http://img21.imageshack.us/img21/4919/dscn4413.jpg
> http://img14.imageshack.us/img14/1230/dscn4414y.jpg
> http://img13.imageshack.us/img13/878/dscn4419c.jpg
> It is not very good photo, but it is difficult to shoot monitor.
> It looks like same delay.

Indeed.  The delay problem is a more generic kernel/hardware issue.

> > 
> > [...]
> > 
> > > > [ BTW the above bisection points that the problem was introduced
> > > > outside of drivers/ide or that it was introduced earlier that we'd
> > > > initially thought ]
> > > > 
> > > > > I have added second hard drive and got new issue. May be this
> > > > > log (dmesg) can tell you something. It is on first known 'bad
> > > > > commit'. 2.6.29.2 can't properly
> > > > 
> > > > It tells us that there is some IRQ routing problem... seems like a
> > > > platform or ide-pmac specific problem.  Does some earlier kernel
> > > > work OK with this configuration?
> > > 
> > > I have Debian's 2.6.26, it has same problem. Don't take attention
> > > to time, I caught another bug on Aureal Vortex2, this driver kills
> > > kernel completely and system time too. I am lucky on bugs on this
> > > machine.
> > 
> > [...]
> > 
> > > [477194869.958131] hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
> > 
> > [...]
> > 
> > > [477194895.065957] ide-pmac lost interrupt, dma status: 8480
> > > [477194895.068535] hdb: lost interrupt
> > > [477194895.070952] hdb: dma_intr: status=0x58 { DriveReady
> > > SeekComplete DataRequest } [477194895.073444] ide: failed opcode
> > > was: unknown [477194895.076053] hda: DMA disabled
> > > [477194895.078504] hdb: DMA disabled
> > > [477194895.209948] ide0: reset: success
> > > [477194895.430619]  hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
> > 
> > This drive is one of the "quirky" drives which has special
> > workarounds in some host drivers...
> > 
> > OK, lets try something else.  I went through IDE code and fixed
> > outstanding issues which may be related to these problems + mixed-in
> > pending bugfixes.
> 
> There is dmesg of 2.6.30-rc6 with patch, I could logged in only once, 
> 2 boots couldn't give me such ability.

Thanks for testing.  Unfortunately none of fixes helped.. :/

> [   70.287747] sysfs: cannot create duplicate filename '/class/ide_port/ide1'
> [   70.287841] ------------[ cut here ]------------
> [   70.287879] Badness at fs/sysfs/dir.c:487

This is caused by small mistake in one of fixes, follow-up fixup:

diff -u b/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- b/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -708,6 +708,8 @@
 		goto out;
 	} else if (rc == -EBUSY)
 		printk(KERN_ERR "%s: not ready before the probe\n", hwif->name);
+	else
+		rc = -ENODEV;
 
 	/*
 	 * Second drive should only exist if first drive was found,


> [   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480

DMA status indicates that DMA transfer is still active according to
the controller.  This one is really a platform/hardware specific issue.
