Return-Path: <bzolnier@gmail.com>
Received: from mail-fx0-f174.google.com (mail-fx0-f174.google.com
	[209.85.220.174]) by ozlabs.org (Postfix) with ESMTP id 873DEDDFE5
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 04:42:43 +1000 (EST)
Received: by fxm22 with SMTP id 22so835646fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 11:42:41 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrey Gusev <a.gusev1980@mail.ru>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Wed, 13 May 2009 20:46:33 +0200
References: <20090425170203.74603b9c@power-debian>
	<200905131528.26940.bzolnier@gmail.com>
	<20090513211123.24825895@power-debian>
In-Reply-To: <20090513211123.24825895@power-debian>
MIME-Version: 1.0
Message-Id: <200905132046.33663.bzolnier@gmail.com>
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

On Wednesday 13 May 2009 19:11:23 Andrey Gusev wrote:
> On Wed, 13 May 2009 15:28:26 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Tuesday 12 May 2009 21:50:24 Andrey Gusev wrote:
> > > On Mon, 27 Apr 2009 23:21:48 +0200
> > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > 
> > > > On Monday 27 April 2009 22:36:45 Andrey Gusev wrote:
> > > > > On Sat, 25 Apr 2009 16:48:38 +0200
> > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > 
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> > > > > > > Hello!
> > > > > > > 
> > > > > > > I have tested linux-2.6.30-rc3 on my system and find some
> > > > > > > problems. One of them is delaying on initialization IDE
> > > > > > > subsystem. I don't have this problem on 2.6.29.1. The
> > > > > > > difference is looked on log of dmesg.
> > > > > > 
> > > > > > Unfortunately this doesn't give us any hint about the root
> > > > > > cause of the bug so please try narrowing the problem down to
> > > > > > the specific change using git-bisect (sorry, there were 212
> > > > > > drivers/ide/ commits during v2.6.29..v2.6.30-rc3 and much much
> > > > > > more non-drivers/ide/ ones).
> > > > > > 
> > > > > > Thanks,
> > > > > > Bart
> > > > > > 
> > > > > 
> > > > > Hello!
> > > > > 
> > > > > 
> > > > > The full result of bisect is:
> > > > > 
> > > > > 
> > > > > git bisect start
> > > > > # good: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux 2.6.29
> > > > > git bisect good 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84
> > > > > # bad: [091069740304c979f957ceacec39c461d0192158] Linux
> > > > > 2.6.30-rc3 git bisect bad
> > > > > 091069740304c979f957ceacec39c461d0192158 # good:
> > > > > [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB (11166):
> > > > > pvrusb2: Implement status fetching from sub-devices git bisect
> > > > > good 40f07111be99b71c1e8d40c13cdc38445add787f # good:
> > > > > [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg:
> > > > > slicoss: Specify the license for Sahara SXG and Slicoss drivers
> > > > > git bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> > > > > 
> > > > > 
> > > > > git bisect start 'drivers/ide/'
> > > > 
> > > > Please note that limiting search space to drivers/ide/ may not
> > > > give reliable results in case problem was introduced by some
> > > > other kernel area.
> > > > 
> > > > > # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg:
> > > > > slicoss: Specify the license for Sahara SXG and Slicoss drivers
> > > > > git bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8 # bad:
> > > > > [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3 git
> > > > > bisect bad 091069740304c979f957ceacec39c461d0192158 # good:
> > > > > [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd: convert
> > > > > cdrom_decode_status() to use switch statements git bisect good
> > > > > e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d # good:
> > > > > [3153c26b54230d025c6d536e8d3015def4524906] ide: refactor
> > > > > tf_read() method git bisect good
> > > > > 3153c26b54230d025c6d536e8d3015def4524906 # good:
> > > > > [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix HPT370
> > > > > DMA timeouts git bisect good
> > > > > c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac # bad:
> > > > > [d5f840bf74c09ca5a31e518c9d984999926b5f44] ide: Remove void
> > > > > casts git bisect bad d5f840bf74c09ca5a31e518c9d984999926b5f44 #
> > > > > bad: [59c8d04f5ee97ea46da854e9adbbaa45d988c39d] hpt366: use
> > > > > ATA_DMA_* constants git bisect bad
> > > > > 59c8d04f5ee97ea46da854e9adbbaa45d988c39d
> > > > 
> > > > Uhh.. something went wrong during bisect.
> > > > 
> > > > "hpt366: use ATA_DMA_* constants" cannot be a first bad commit
> > > > because hpt366 is not even used on this system.
> > > > 
> > > > Could it be that the delay doesn't happen on every boot for "bad"
> > > > kernels?
> > > > 
> > > > Also, is 2.6.30-rc1 okay?
> > > > 
> > > > Thanks,
> > > > Bart
> > > > 
> > > 
> > > Hello all!
> > > 
> > > I continue to find reason of bug. I made more testing with bisect
> > > and got result:
> > > 
> > > git bisect start
> > > # bad: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix
> > > HPT370 DMA timeouts git bisect bad
> > >  # good:
> > > [fb4252e59452c18b88af014a2c4ee697bbf8cbc6] at91_ide: turn on PIO 6
> > > support git bisect good fb4252e59452c18b88af014a2c4ee697bbf8cbc6 #
> > > good: [2e1c63b7ed36532b68f0eddd6a184d7ba1013b89] Merge branch
> > > 'for-rc1/xen/core' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen git bisect
> > > good 2e1c63b7ed36532b68f0eddd6a184d7ba1013b89 # bad:
> > > [cd97824994042b809493807ea644ba26c0c23290] Merge
> > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6 git
> > > bisect bad cd97824994042b809493807ea644ba26c0c23290 # bad:
> > > [a2c252ebdeaab28c9b400570594d576dae295958] Merge
> > > git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes
> > > git bisect bad a2c252ebdeaab28c9b400570594d576dae295958 # good:
> > > [b897e6fbc49dd84b2634bca664344d503b907ce9] Merge branch
> > > 'drm-intel-next' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/anholt/drm-intel git
> > > bisect good b897e6fbc49dd84b2634bca664344d503b907ce9 # good:
> > > [dfbc4752eab33e66f113f9daa2effbe241cd661d] brd: support barriers
> > > git bisect good dfbc4752eab33e66f113f9daa2effbe241cd661d # good:
> > > [a23c218bd36e11120daf18e00a91d5dc20e288e6] Merge branch 'merge' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc git
> > > bisect good a23c218bd36e11120daf18e00a91d5dc20e288e6 # good:
> > > [23da64b4714812b66ecf010e7dfb3ed1bf2eda69] Merge branch 'for-linus'
> > > of git://git.kernel.dk/linux-2.6-block git bisect good
> > > 23da64b4714812b66ecf010e7dfb3ed1bf2eda69 # good:
> > > [a228df6339e0d385b8149c860d81b6007f5e9c81] GFS2: Move umount flush
> > > rwsem git bisect good a228df6339e0d385b8149c860d81b6007f5e9c81 #
> > > skip: [1328df725239804ae30fc7257c1a3185e679b517] GFS2: Use
> > > DEFINE_SPINLOCK git bisect skip
> > > 1328df725239804ae30fc7257c1a3185e679b517 # good:
> > > [10d2198805d7faa2b193485446ff6b1de42c9b78] GFS2: cleanup
> > > file_operations mess git bisect good
> > > 10d2198805d7faa2b193485446ff6b1de42c9b78
> > > 
> > > As I understand, I found bad commit, but it includes 5 commits. I
> > > checked them and they are good. So, I did git checkout
> > > a2c252ebdeaab28c9b400570594d576dae295958 and test one more time
> > > this commit. I found that bag is unstable. The boot can be bad or
> > > good on this commit. I compared dmesg of 'bad' and 'good' booting,
> > > but it is equal till delay. 
> > 
> > Thanks for doing it.
> > 
> > > Any suggestions?
> > 
> > Hard to tell...
> > 
> > I went through all commits in-between
> > 
> > 	fb4252e59452c18b88af014a2c4ee697bbf8cbc6
> > 
> > and
> > 
> > 	a2c252ebdeaab28c9b400570594d576dae295958
> > 
> > and there are no obvious candidates..
> > 
> > Could you please refresh my memory and tell me whether 2.6.30-rc2 was
> > OK?
> > 
> 
> It was ok, but I don't sure now. I tested only one boot, but this problem is not
> stable. I am rechecking it.

Ok.

Please also recheck first 'good' commit if 2.6.30-rc2 turns out to be 'bad'.

[ BTW the above bisection points that the problem was introduced outside of
  drivers/ide or that it was introduced earlier that we'd initially thought ]

> I have added second hard drive and got new issue. May be this log (dmesg) can
> tell you something. It is on first known 'bad commit'. 2.6.29.2 can't properly

It tells us that there is some IRQ routing problem... seems like a platform
or ide-pmac specific problem.  Does some earlier kernel work OK with this
configuration?

> initialize it too (got lost interrupt and disable dma).
> 
> [    1.113901] Uniform Multi-Platform E-IDE driver
> [    1.120304] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
> [    1.123139] adb: starting probe task...
> [    1.125609] adb: finished probe task...
> [    2.147653] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
> [    2.152331] Probing IDE interface ide0...
> [    2.457825] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
> [    2.817641] hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
> [   66.660447] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> [   66.660624] hda: UDMA/100 mode selected
> [   66.663170] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> [   66.663415] hdb: UDMA/66 mode selected
> [   66.666108] ide0 at 0xf1012000-0xf1012070,0xf1012160 on irq 39
> [   67.697640] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio), bus ID 2, irq 19
> [   67.702368] Probing IDE interface ide1...
> [  131.867685] ide1 at 0xf100e000-0xf100e070,0xf100e160 on irq 19
> [  132.897559] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio), bus ID 0, irq 20
> [  132.902273] Probing IDE interface ide2...
> [  196.898053] hde: PHILIPS CDD5101, ATAPI CD/DVD-ROM drive
> [  260.980668] hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> [  260.981049] hde: MWDMA2 mode selected
> [  260.984269] ide2 at 0xf1016000-0xf1016070,0xf1016160 on irq 20
> [  260.989418] ide-gd driver 1.18
> [  260.991880] hda: max request size: 128KiB
> [  261.039649] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
> [  261.044690] hda: cache flushes supported
> [  261.047292]  hda: [mac] hda1 hda2 hda3 hda4
> [  261.060150] hdb: max request size: 128KiB
> [  261.089788] hdb: 40132503 sectors (20547 MB) w/1900KiB Cache, CHS=39813/16/63
> [  261.092287] hdb: cache flushes not supported
> [  261.094754]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> [  281.089717] hdb: lost interrupt
> [  281.092085] hdb: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> [  281.097038] ide: failed opcode was: unknown
> [  281.101900] hda: DMA disabled
> [  281.104247] hdb: DMA disabled
> [  281.187260] ide0: reset: success
> [  281.230368]  hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
> [  281.285486] ide-cd driver 5.00
> [  281.297481] ide-cd: hde: ATAPI 32X DVD-ROM CD-R/RW drive, 8192kB Cache
> [  281.299687] Uniform CD-ROM driver Revision: 3.20
