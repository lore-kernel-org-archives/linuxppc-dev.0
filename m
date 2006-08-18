Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 75B04679E9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 20:17:28 +1000 (EST)
Date: Fri, 18 Aug 2006 12:17:47 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Bill Fink <billfink@mindspring.com>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060818101747.GA3368@localhost>
References: <20060817230347.GC3440@localhost>
	<20060818012824.22e70b0f.billfink@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060818012824.22e70b0f.billfink@mindspring.com>
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	stefanr@s5r6.in-berlin.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Bill

Thanks for responding

On Fri, Aug 18, 2006 at 01:28:24AM -0400, Bill Fink wrote:
> Hi Wolfgang,
> 
> On Fri, 18 Aug 2006, Wolfgang Pfeiffer wrote:
> 
> [ ... ]
> > First I load the drivers with this little script:
> > 
> > ------------------------------------------
> > #!/bin/sh -x
> > /bin/sh -n /home/shorty/scripts/scsi.start.sh && \
> > 
> > modprobe raw1394 && \
> > modprobe ieee1394 disable_irm=0 disable_nodemgr=1 && \
> > modprobe ohci1394 && \
> > modprobe eth1394 && \
> > modprobe sbp2 max_speed=3 workarounds=0x1 serialize_io=0 && \
> > sleep 4 && \
> > chown root.shorty /dev/raw1394
> > -------------------------------------------
> 
> I don't know if it matters for you (haven't tried Firewire yet on
> a PowerBook), but on my desktop PowerMac systems, I need a "sleep 2"
> before the modprobe for sbp2, to get my Firewire disks to work
> properly.


No, that doesn't help: I made several changes to the script now, with a
shorter or longer sleep delay, changing driver options - still no /dev/sdX/:


-------------------------------------
#!/bin/sh -x
/bin/sh -n /home/shorty/scripts/scsi.start.sh ; \

modprobe raw1394; \
modprobe ieee1394 disable_irm=1 disable_nodemgr=0; \
modprobe ohci1394; \
modprobe eth1394; \
sleep 4; \
#modprobe sbp2 max_speed=3 workarounds=0x1 serialize_io=0; \
#modprobe sbp2 max_speed=3 serialize_io=0; \
modprobe sbp2; \
sleep 4; \
chown root.shorty /dev/raw1394


--------------------------------------

What I got today is this:

-----------------------------
Aug 18 11:57:46 debby1-6 kernel: [ 2113.770420] ieee1394: Initialized config rom entry `ip1394'
Aug 18 11:57:46 debby1-6 kernel: [ 2113.777915] ieee1394: raw1394: /dev/raw1394 device initialized
Aug 18 11:57:46 debby1-6 kernel: [ 2113.848894] PM: Adding info for ieee1394:fw-host0
Aug 18 11:57:46 debby1-6 kernel: [ 2113.901455] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[4096]  IR/IT contexts=[8/8]
Aug 18 11:57:46 debby1-6 kernel: [ 2113.961215] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Aug 18 11:57:47 debby1-6 kernel: [ 2115.219661] ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
Aug 18 11:57:48 debby1-6 kernel: [ 2116.448637] ieee1394: Error parsing configrom for node 0-00:1023
Aug 18 11:57:48 debby1-6 kernel: [ 2116.449037] PM: Adding info for ieee1394:001451fffe3148be
Aug 18 11:57:48 debby1-6 kernel: [ 2116.449126] ieee1394: Host added: ID:BUS[0-02:1023]  GUID[001451fffe3148be]
Aug 18 11:57:48 debby1-6 kernel: [ 2116.449281] PM: Adding info for ieee1394:001451fffe3148be-0
Aug 18 11:57:50 debby1-6 kernel: [ 2118.041601] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
Aug 18 11:57:50 debby1-6 kernel: [ 2118.041634] ieee1394: sbp2: Try serialize_io=0 for better performance
-----------------------------------

Following a log excerpt from a few days ago, when I got /dev/sda at
least, tho still no disk partition (Please don't ask me how I got that
far: that time I must have played around with the FW drivers, un- and
reloading them again .... and at one moment I had at least the following ):

--------------------------------
Aug 11 23:53:16 debby1-6 kernel: [11154.413116] ieee1394: Node changed: 0-02:102
3 -> 0-00:1023
Aug 11 23:53:21 debby1-6 kernel: [11160.079353] PM: Adding info for ieee1394:003
0ffa046010cd5
Aug 11 23:53:21 debby1-6 kernel: [11160.079456] ieee1394: Node added: ID:BUS[0-0
0:1023]  GUID[0030ffa046010cd5]
Aug 11 23:53:21 debby1-6 kernel: [11160.079626] ieee1394: Node changed: 0-00:102
3 -> 0-02:1023
Aug 11 23:53:21 debby1-6 kernel: [11160.081535] PM: Adding info for ieee1394:003
0ffa046010cd5-0
Aug 11 23:53:21 debby1-6 kernel: [11160.190054] ieee1394: sbp2: Driver forced to
 serialize I/O (serialize_io=1)
Aug 11 23:53:21 debby1-6 kernel: [11160.190070] ieee1394: sbp2: Try serialize_io
=0 for better performance
Aug 11 23:53:21 debby1-6 kernel: [11160.191555] scsi2 : SBP-2 IEEE-1394
Aug 11 23:53:21 debby1-6 kernel: [11160.191815] PM: Adding info for No Bus:host2
Aug 11 23:53:23 debby1-6 kernel: [11161.295090] ieee1394: sbp2: Logged into SBP-
2 device
Aug 11 23:53:23 debby1-6 kernel: [11161.295728] ieee1394: Node 0-00:1023: Max sp
eed [S400] - Max payload [2048]
Aug 11 23:53:23 debby1-6 kernel: [11161.295932] PM: Adding info for No Bus:targe
t2:0:0
Aug 11 23:53:23 debby1-6 kernel: [11161.301996]   Vendor: LSILogic  Model: SYM13
FW500-Disk   Rev: 1.00
Aug 11 23:53:23 debby1-6 kernel: [11161.302026]   Type:   Direct-Access
             ANSI SCSI revision: 00
Aug 11 23:53:23 debby1-6 kernel: [11161.302323] PM: Adding info for scsi:2:0:0:0
Aug 11 23:53:26 debby1-6 udevd-event[5667]: wait_for_sysfs: waiting for '/sys/de
vices/pci0002:24/0002:24:0e.0/fw-host0/0030ffa046010cd5/0030ffa046010cd5-0/host2
/target2:0:0/2:0:0:0/ioerr_cnt' failed
Aug 11 23:53:53 debby1-6 kernel: [11191.302896] ieee1394: sbp2: aborting sbp2 command
Aug 11 23:53:53 debby1-6 kernel: [11191.302912] sd 2:0:0:0:
Aug 11 23:53:53 debby1-6 kernel: [11191.302915]         command: Test Unit Ready: 00 00 00 00 00 00
Aug 11 23:54:03 debby1-6 kernel: [11201.302892] ieee1394: sbp2: aborting sbp2 command
Aug 11 23:54:03 debby1-6 kernel: [11201.302909] sd 2:0:0:0:
Aug 11 23:54:03 debby1-6 kernel: [11201.302913]         command: Test Unit Ready: 00 00 00 00 00 00
Aug 11 23:54:03 debby1-6 kernel: [11201.302957] ieee1394: sbp2: reset requested
Aug 11 23:54:03 debby1-6 kernel: [11201.302962] ieee1394: sbp2: Generating sbp2 fetch agent reset
Aug 11 23:54:13 debby1-6 kernel: [11211.302892] ieee1394: sbp2: aborting sbp2 command
Aug 11 23:54:13 debby1-6 kernel: [11211.302907] sd 2:0:0:0:
Aug 11 23:54:13 debby1-6 kernel: [11211.302910]         command: Test Unit Ready: 00 00 00 00 00 00
Aug 11 23:54:13 debby1-6 kernel: [11211.302955] sd 2:0:0:0: scsi: Device offlined - not ready after error recovery
Aug 11 23:54:13 debby1-6 kernel: [11211.303150] sd 2:0:0:0: rejecting I/O to offline device
Aug 11 23:54:13 debby1-6 kernel: [11211.303199] sd 2:0:0:0: rejecting I/O to offline device
Aug 11 23:54:13 debby1-6 kernel: [11211.303237] sd 2:0:0:0: rejecting I/O to offline device
Aug 11 23:54:13 debby1-6 kernel: [11211.303272] sda : READ CAPACITY failed.
Aug 11 23:54:13 debby1-6 kernel: [11211.303276] sda : status=0, message=00, host=1, driver=00
Aug 11 23:54:13 debby1-6 kernel: [11211.303282] sda : sense not available.
Aug 11 23:54:13 debby1-6 kernel: [11211.303349] sd 2:0:0:0: rejecting I/O to offline device
Aug 11 23:54:13 debby1-6 kernel: [11211.303384] sda: Write Protect is off
Aug 11 23:54:13 debby1-6 kernel: [11211.303390] sda: Mode Sense: 00 00 00 00
Aug 11 23:54:13 debby1-6 kernel: [11211.303423] sd 2:0:0:0: rejecting I/O to offline device
Aug 11 23:54:13 debby1-6 kernel: [11211.303432] sda: asking for cache data failed
Aug 11 23:54:13 debby1-6 kernel: [11211.303436] sda: assuming drive cache: write through
Aug 11 23:54:13 debby1-6 kernel: [11211.304555] sd 2:0:0:0: Attached scsi disk sda
Aug 11 23:54:13 debby1-6 kernel: [11211.304657] sd 2:0:0:0: Attached scsi generic sg0 type 0
-----------------------------


Thanks again, and
Best Regards
Wolfgang


-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
