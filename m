Return-Path: <billfink@mindspring.com>
Received: from soulshock.mail.pas.earthlink.net
	(soulshock.mail.pas.earthlink.net [207.217.120.130])
	by ozlabs.org (Postfix) with ESMTP id AF6742BC0F
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Oct 2004 00:32:08 +1000 (EST)
Date: Fri, 22 Oct 2004 08:53:15 -0400
From: Bill Fink <billfink@mindspring.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <20041022085315.710c0e93.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: frank.pierce@hedb.uib.no
Subject: Re: Many random crashes in 2.2.0 (and previous kernels)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Frank,

On Wed Oct 20 2004, Frank Pierce wrote:

> Yeah thats the problem I have 1MB L2 cache.
> Im not sure if it is the cache thats causing me problems,
> but it cant be good that its there but not registered.
> On 05-Feb-99 Marcus H. Mendenhall wrote:
> 
> > OK, I checked.  On my machine the cache is fine,
> > according to cpuinfo :
> > 
> > here is cat /proc/cpuinfo:
> > 
> > processor     : 0
> > cpu           : 750
> > temperature   : 0 C
> > clock         : 300MHz
> > revision      : 2.2
> > bogomips      : 601.29
> > zero pages    : total 0 (0Kb) current: 0 (0Kb) hits: 0/148
> > (0%)
> > machine               : Power Macintosh
> > motherboard   : AAPL,Gossamer MacRISC
> > L2 cache      : 1024K unified pipelined-syncro-burst
> > memory                : 128MB
> > 
> > Does you machine actually have an L2 cache?  It seems as
> > if the cache
> > problem on your PCPro machine may be a red herring with
> > respect to the
> > crashing.
> > 
> > Has anyone else out these been having this problem?  From
> > the lack of any
> > other responses, it seems that I am almost the only one. 
> > Are other people
> > running on machines similar to this one (rev 2 G3 300
> > MHz) successfully?  I
> > would like some feed back from successes and failures so
> > that I can try to
> > isolate what it is that is different about my machine and
> > poke directly at
> > that part of the kernel.  The crashes are just infrequent
> > enough to make
> > debugging difficult (low data rate), but frequent enough
> > to make serious
> > use difficult.

I don't know if this applies to you or not but here's some messages
about similar problems I once had with YellowDog Linux on a B&W G3
a while back.

						-Hope this helps

						-Bill



Date: Fri, 27 Aug 2004 04:54:39 -0400
From: Bill Fink
To: YellowDog Linux General <yellowdog-general@lists.terrasoftsolutions.com>
Subject: Re: Mac G3 reboots during installation

Hi Corey,

On Thu, 26 Aug 2004, Corey Mercer wrote:

> For those of you just tuning in :) I have a g3 blue
> and white tower 350Mhz with 640Mb RAM that I am trying
> to install YDL 3.0.1 on and it keeps rebooting during
> the installation at various different points during
> the file copy process.. at one point it actually made
> it to the second cd only to reboot a minute in.

I don't know if this applies to you or not, but I had very similar
problems installing YDL on a B&W G3 a while back.  In my case, I
was installing YDL on a second disk, and the system would crash
at various random points.  The way I got it to work was to replace
the internal disk with the second disk (jumpered as master), and
then everything worked fine for me.  I believe this is caused by
a hardware deficiency with certain B&W G3 models that causes DMA
problems with a second IDE disk.  I'm attaching a couple of old
messages that discussed the problems I encountered.

					-Hope this helps

					-Bill



Date: Sun, 30 Jun 2002 00:33:29 -0400
From: Bill Fink
To: "Timothy A. Seufert"
Cc: yellowdog-general@lists.terrasoftsolutions.com
Subject: Re: Booting YDL 2.1 on B&W G3 Problems

On Sat, 29 Jun 2002, "Timothy A. Seufert" wrote:

> At 11:38 AM -0400 6/29/02, Bill Fink wrote:
> 
> >Here are some of my experiences with installing Linux on a B&W G3 at work.
> >First, it just would not install on the slave drive, so I had to switch
> >master and slave.  It is my understanding that early B&W G3s cannot boot
> >from a slave drive because of an OpenFirmware bug.
> 
> Hmmm... I'm fairly sure I've booted a B&W from a slave drive at one 
> time or another.  I do remember not being able to do a plug & chug 
> install of Linux to a slave, due to bugs in the installer.  (I forget 
> which distribution and which version of it.)
> 
> BTW, Apple has a firmware update for B&W G3s, so if you have apparent 
> OF bugs, apply it.  It applies both to rev 1 and rev 2 B&W G3 systems.
> 
> http://docs.info.apple.com/article.html?artnum=58374

Thanks for the tip.  I'll have to check it out.

> >But even after installing Linux on the now master drive, I was still
> >having all kinds of problems actually running Linux on that system
> >including weird system errors and file system corruption.  These finally
> >went away went I installed a custom built 2.4.19-pre8-ben0 kernel.
> >
> >However, I noticed that Linux wasn't detecting the original (now slave)
> >internal disk drive.  I tracked this down to not having the CMD64X driver
> >configured in my kernel and added it in.  Linux then detected the slave
> >drive, but unfortunately the weird system errors and file system
> >corruption also returned.  I also checked and determined that the
> >default YDL 2.1 2.4.10-12a kernel has the CMD64X driver enabled,
> >which explained the earlier problem behavior.  It is my understanding
> >that some of the early disks in the B&W G3s had buggy firmware, so I
> >got bit by two early B&W G3 bugs.
> 
> I haven't heard of any disk firmware bugs before.  I think what you 
> got bitten by is the known IDE chip bug.  The B&W originally shipped 
> with rev 5 of the CMD646U2 controller.  Rev 5 has nasty corruption 
> problems in UDMA mode in master/slave configurations.  Even with only 
> a single drive attached, it can have problems (depends on the drive 
> model -- some work fine, others don't, the only ones you can trust 
> for absolute sure are the factory original drives which Apple did 
> qualification testing on).
> 
> The reason you aren't having problems when you eliminate the CMD64X 
> driver is presumably that the generic IDE driver can't enable UDMA 
> mode.  It might not even be able to enable DMA.

Actually, being somewhat paranoid after all the severe problems I had
run into, I finally removed the original internal drive to avoid any
further problems.  I do have the CMD64X driver disabled in the current
kernel:

astro% dmesg | grep CMD
CMD646: IDE controller on PCI bus 01 dev 08
CMD646: detected chipset, but driver not compiled in!
CMD646: chipset revision 5
CMD646: 100% native mode on irq 26

Is using_dma as reported by hdparm the same thing as the UDMA mode
you were talking about?  If so, it still seems to be set on the new
drive:

astro# hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 12009/16/63, sectors = 78165360, start = 0

Thus far I haven't had any problems with the new drive.  I guess that's
why I thought it was a disk problem rather than a controller problem,
although perhaps the problem only manifests itself in a master/slave
setup.  IIRC even when I still had the original drive connected, it
wasn't even detected by Linux at all without the CMD64X driver, so it
was as if it wasn't connected, and this may be why it worked OK in that
configuration.  However, this also confused me, since if the IDE driver/
controller couldn't detect the original drive, how was it able to detect
the new drive.  Apparently, the generic IDE driver has a problem
detecting the original drive when it's the slave drive.

> Anyways, CMD fixed the problems in rev 7 of the chip, which Apple 
> incorporated into Rev 2 of the B&W motherboard.  As far as I have 
> ever been able to tell, that was the lone motherboard change during 
> the product life of the B&W G3, which is pretty unusual and means 
> that it was a solid design aside from the use of a buggy IDE chip.
> 
> How you can tell what you've got: Rev 7 chips are marked 
> "CMD646U2-402", while Rev 5's lack the "-402".  The chip is located 
> in a far corner of the motherboard, behind the PCI slots (between the 
> slots and the slot covers).  Fortunately, it's on the top of the 
> board, so you don't have to take the board out.
> 
> If you're in Linux, you can find the chip revision without cracking 
> the box.  Just issue the "lspci" command and look at the revision 
> given for the 646.

It looks like I've got the buggy Rev 5 IDE chip:

astro% lspci
00:00.0 Host bridge: Motorola MPC106 [Grackle] (rev 40)
00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 02)
00:10.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE
01:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link
Layer Controller (rev 02)
01:01.0 IDE interface: CMD Technology Inc PCI0646 (rev 05)
01:05.0 Class ff00: Apple Computer Inc. Paddington Mac I/O
01:06.0 USB Controller: OPTi Inc. 82C861 (rev 10)

According to your theory, it would seem all that would be necessary to
workaround the problem would be to issue an "hdparm -d 0" on the drive(s).
If I get some spare time, I may test that theory, but as much time as I've
already wasted on that system, it's not real high on my priority list,
especially since it seems to be working pretty well finally.

Thanks for all the info.

						-Regards

						-Bill



Date: Mon, 1 Jul 2002 18:20:28 -0400
From: Bill Fink
To: "Timothy A. Seufert"
Cc: yellowdog-general@lists.terrasoftsolutions.com
Subject: Re: Booting YDL 2.1 on B&W G3 Problems

On Sun, 30 Jun 2002, "Timothy A. Seufert" wrote:

> At 12:33 AM -0400 6/30/02, Bill Fink wrote:
> 
> >>  The reason you aren't having problems when you eliminate the CMD64X
> >>  driver is presumably that the generic IDE driver can't enable UDMA
> >>  mode.  It might not even be able to enable DMA.
> >
> >Actually, being somewhat paranoid after all the severe problems I had
> >run into, I finally removed the original internal drive to avoid any
> >further problems.  I do have the CMD64X driver disabled in the current
> >kernel:
> >
> >astro% dmesg | grep CMD
> >CMD646: IDE controller on PCI bus 01 dev 08
> >CMD646: detected chipset, but driver not compiled in!
> >CMD646: chipset revision 5
> >CMD646: 100% native mode on irq 26
> >
> >Is using_dma as reported by hdparm the same thing as the UDMA mode
> >you were talking about?  If so, it still seems to be set on the new
> >drive:
> 
> Not necesssarily.  It might be using the slower 16.6 MB/s DMA mode 
> (multiword DMA mode 2) instead of 33.3 MB/s UDMA.  If I recall 
> correctly, corruption only happens in UDMA mode.

The dmesg output seems to indicate it's using UDMA mode.

astro% dmesg | grep -i dma
    ide0: BM-DMA at 0x1050-0x1057, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1058-0x105f, BIOS settings: hdc:pio, hdd:pio
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, (U)DMA
hde: Enabling MultiWord DMA 2
ide_pmac: MDMA, cycleTime: 120, accessTime: 75, recTime: 45
ide_pmac: Set MDMA timing for mode 2, reg: 0x00211526
hde: ATAPI 10X CD-ROM drive, 128kB Cache, DMA
PowerMac Burgundy  DMA sound driver rev 016 installed

> >According to your theory, it would seem all that would be necessary to
> >workaround the problem would be to issue an "hdparm -d 0" on the drive(s).
> >If I get some spare time, I may test that theory, but as much time as I've
> >already wasted on that system, it's not real high on my priority list,
> >especially since it seems to be working pretty well finally.
> 
> Yes, that should do it.  No guarantees, but I don't remember ever 
> seeing a problem with DMA off.  Not using UltraDMA mode should also 
> do the trick.  Use:
> 
> hdparm -X34 /dev/hdX
> 
> to select multiword DMA mode 2.  -X66 selects UDMA mode 2.

Yes, that would be better than completely turning off DMA.

> Also, back when I was trying to get my B&W working right, I wrote a 
> simple program that tests for disk I/O corruption by writing large 
> files to disk and then reading them back and verifying them.  Better 
> than writing real data to disk and having to find out later that it 
> got corrupted.  :)  If you want it, let me know and I'll send you the 
> C source code.

Sure, I always like having simple test tools to check out various parts
of the system.

						-Thanks

						-Bill
