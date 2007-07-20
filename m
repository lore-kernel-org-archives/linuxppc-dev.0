Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s17.bay0.hotmail.com (bay0-omc2-s17.bay0.hotmail.com
	[65.54.246.153]) by ozlabs.org (Postfix) with ESMTP id A6119DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jul 2007 19:27:59 +1000 (EST)
Message-ID: <BAY115-W3E40B1AA7056BDABCB768B2F40@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Rick Moleres <rick.moleres@xilinx.com>, <linux-ppc@eurotel.it>
Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6
Date: Fri, 20 Jul 2007 09:27:58 +0000
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear Massimiliano
Well I do not know the solution to the problem, but just,
In your post, there is some thing interesting for me,

How could you implement such large circuit on one FX12 FPGA?
We have done many experineces with both of AVNET MM and ML403,

you have, DDR SDRAM Controller, GPIO, UART, SYSACE and two intances of Tri-mode TEMAC GMII, 
In our tests, with one instance of Tri mode TEMAC and UART and DDR controller, the whole FPGA resource were consumed we could not even put sysace interface.

For me, another important question is, how many PHY chips are available on your board? Each of Tri-mode temac modules are connected to a separate phy chip, yes?





________________________________
> Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6
> Date: Thu, 19 Jul 2007 09:00:33 -0600
> From: Rick.Moleres@xilinx.com
> To: linux-ppc@eurotel.it
> CC: eemingliu@hotmail.com; linuxppc-embedded@ozlabs.org; mamsadegh@hotmail.com
> 
> Hi,
> The first thing I would try is to make sure eth1 comes up without first bringing up eth0.  In other words, does it come up independently?  If not, there could be something wrong with its configuration in the kernel or perhaps a hardware design issue.  If both interfaces come up independently, but not together, then there’s likely a driver issue as we have not tested dual channel TEMAC with the Linux plb_temac driver.  Perhaps others on the list have.  The areas that I would look at would be:  make sure each interface is getting a unique and correct PHY address; make sure any calls to the shared registers of the two channels are protected with semaphores/spinlocks.  For example, I’m pretty sure the PHY registers are shared, so any PHY accesses should be protected.  I would think other Xilinx driver accesses like Start/Stop/Reset/Get or SetOptions/etc… should be protected as they may access shared registers.
> -Rick
> ________________________________
> From: Massimiliano.Patriarca@eurotel.it [mailto:Massimiliano.Patriarca@eurotel.it] On Behalf Of linux-ppc@eurotel.it
> Sent: Thursday, July 19, 2007 7:51 AM
> To: Rick Moleres
> Cc: Ming Liu; linuxppc-embedded@ozlabs.org; linuxppc-embedded-bounces+linux-ppc=eurotel.it@ozlabs.org; mamsadegh@hotmail.com
> Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6
> Hi, we are trying to use both side of an hard temac + 2 plb temac in a Virtex4FX12 project.
> we succesfull implemented a single temac Montavista tree with eth0.
> when trying to use both temac, devices are correctly registered with kernel-
> eth0 comes up and working ok-
> when manually start eth1 (/sbin/ifconfig eth1 up) kernel hang without any error or info in the console
> # dmesg
> Linux version 2.6.10_mvl401-ml40x (massimiliano@linux-yhbz) (gcc version 3.4.3 (MontaVista 3.4.3-25.0.135.0702900 2007-04-01)) #250 Wed Jul 18 12:20:43 CEST 2007
> Eurotel motherboard init
> Port by MontaVista Software, Inc. (source@mvista.com)
> On node 0 totalpages: 7812
>   DMA zone: 7812 pages, LIFO batch:1
>   Normal zone: 0 pages, LIFO batch:1
>   HighMem zone: 0 pages, LIFO batch:1
> Built 1 zonelists
> Kernel command line: console=ttl0 root=/dev/xsysace2 rw ip=off
> Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
> PID hash table entries: 128 (order: 7, 2048 bytes)
> hr_time_init: arch_to_nsec = 8192000, nsec_to_arch = 1099511627
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> Memory: 28420k available (1864k kernel code, 528k data, 124k init, 0k highmem)
> Calibrating delay loop... 252.92 BogoMIPS (lpj=126464)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> spawn_desched_task(00000000)
> desched cpu_callback 3/00000000
> ksoftirqd started up.
> desched cpu_callback 2/00000000
> desched thread 0 started up.
> NET: Registered protocol family 16
> Registering platform device 'xilinx_temac.0'. Parent at platform
> Registering platform device 'xilinx_temac.1'. Parent at platform
> Registering platform device 'xilinx_sysace.0'. Parent at platform
> Registering platform device 'xilinx_gpio.0'. Parent at platform
> Registering platform device 'xilinx_gpio.1'. Parent at platform
> Registering platform device 'oled_fb.0'. Parent at platform
> Generic PHY: Registered new driver
> oled_fb: 4096 video memory mapped to c2011000
> Console: switching to colour frame buffer device 16x8
> xgpio #0 at 0x40000000 mapped to 0xC2020000
> xgpio #1 at 0x40020000 mapped to 0xC2040000
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> loop: loaded (max 8 devices)
> elevator: using anticipatory as default io scheduler
> System ACE at 0x41800000 mapped to 0xC2060000, irq=4, 1000944KB
>  xsysace: xsysace1 xsysace2
> Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
> XTemac: using FIFO direct interrupt driven mode.
> eth0: Xilinx TEMAC #0 at 0x20000000 mapped to 0xC2080000, irq=0
> eth0: XTemac id 1.0f, block id 5, type 8
> XTemac: using FIFO direct interrupt driven mode.
> eth1: Xilinx TEMAC #1 at 0x20010000 mapped to 0xC20A0000, irq=10
> eth1: XTemac id 1.0f, block id 5, type 8
> i2c /dev entries driver
> i2c-xil_custom: registered with I2C (0)
> i2c-xil_custom: registered with I2C (1)
> mice: PS/2 mouse device common for all mice
> NET: Registered protocol family 2
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 4096)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on xsysace2, internal journal
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem).
> Freeing unused kernel memory: 124k init
> eth0: XTemac: Options: 0xb8f2
> eth0: XTemac: speed set to 100Mb/s
> eth0: XTemac: PHY Link carrier lost.
> # /sbin/ifconfig eth1 up
> # eth1: XTemac: Options: 0xb8f2
> Any suggestion?
> "Rick Moleres" 
> Sent by: linuxppc-embedded-bounces+linux-ppc=eurotel.it@ozlabs.org
> 08/02/2007 17.23
> To
> "Ming Liu" , 
> cc
> linuxppc-embedded@ozlabs.org
> Subject
> RE: ML403 Hard TEMAC, PLB and Linux 2.6
> Hi,
> As Ming says the Linux 2.6 TEMAC driver is made available in EDK 8.2.2 as part of the BSP and Libraries generation for Linux 2.6.  Note that we made a recent fix for better PHY address detection and speed negotiation. I've attached the adapter here, and it will be available in EDK 9.1.1 when that's released.
> Thanks,
> Rick
> -----Original Message-----
> From: linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org [mailto:linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org] On Behalf Of Ming Liu
> Sent: Thursday, February 08, 2007 2:31 AM
> To: mamsadegh@hotmail.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6
> Hi,
> In xapp902, they are using the old cores for Temac. So it will be easier to
> generate a project in EDK 8.2. Not only the cores there are new, but also
> it can generate the driver for linux 2.6.
> BR
> Ming
> >From: Mohammad Sadegh Sadri 
> >To: 
> >CC: linuxppc-embedded@ozlabs.org
> >Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6
> >Date: Thu, 8 Feb 2007 07:13:47 +0000
> >
> >
> >Hi
> >Thanks for reply
> >Well, regarding xapp902, there is a very simple question, Where can I find
> it? It seems that Xilinx has deleted all of the links to these files.
> >
> >
> >
> >
> >
> >----------------------------------------
> > > Subject: Re: ML403 Hard TEMAC, PLB and Linux 2.6
> > > From: christophe.alayrac@cresitt.com
> > > To: mamsadegh@hotmail.com
> > > CC: linuxppc-embedded@ozlabs.org
> > > Date: Thu, 8 Feb 2007 06:51:45 +0100
> > >
> > > Le mercredi 07 f関rier 2007 ?22:30 +0000, Mohammad Sadegh Sadri a
> > > 閏rit :
> > > Hi Mohammad,
> > >
> > > Please find here after some answer
> > >
> > > > 1- I want to use, ML403, Hard TEMAC and PLB TEMAC cores. Is there any
> ready to use design, or any reference design available for this?
> > > > I'm using EDK 8.1 and I understood that, when I choose the ML403
> board , EDK does not use hard temac, so , should I add it manually? ( well
> this is funny, but the wizard does not use hard temac , is it true? )
> > > > Is there any ready EDK projects for ML403, with TEMAC and PLB TEMAC
> modules already inserted and cofigured? (I don't want to use GSRD ) ( If
> yes would you please put the link here )
> > > >
> > > You can start from XAPP 902 from Xilinx, this design demonstrate TEMAC
> > > use in loopback mode. Some memers from that community have tried from
> > > that design as a starting point. I did not nknow if the succeed.
> > > I would recommand to get EDK 8.2 SP2 and use the Wizard to build a new
> > > design with TEMAC.
> > >
> > > > 2- Simply, Is there any driver available for linux 2.6 , for PLB
> TEMAC and Hard TEMAC modules? If yes , can you put the link here, so that I
> can download it?
> > > >
> > > For the kernel you can get it from Montavista source code site using
> GIT
> > > to download it (linux-xilinx-26). This is 2.6.17.4 version (last week!)
> > >
> > > Then you will need to pacth the Kernel with TEMAC drivers (look for
> > > TEMAC PAULUS MVISTA with google, or follow my messages in that mailing
> > > list)
> > > NOTE: If you use that TEMAC patch do not use SGDMA on your TEMAC, use
> > > FIFO.
> > >
> > > > thanks
> > > Regards
> > >
> > > Chris
> > > > _________________________________________________________________
> > > > Personalize your Live.com homepage with the news, weather, and photos
> you care about.
> > > > http://www.live.com/getstarted.aspx?icid=T001MSN30A0701
> > > > _______________________________________________
> > > > Linuxppc-embedded mailing list
> > > > Linuxppc-embedded@ozlabs.org
> > > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > >
> >
> >_________________________________________________________________
> >Live Search: New search found
> >http://get.live.com/search/overview
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _________________________________________________________________
> 与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=windows+vista&mkt=en-US&form=QBRE
