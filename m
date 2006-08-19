Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from elch.in-berlin.de (elch.in-berlin.de [192.109.42.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B59767B61
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 02:20:40 +1000 (EST)
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by elch.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id
	k7J8CYYI013895
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 10:12:34 +0200
Message-ID: <44E6C77E.6060401@s5r6.in-berlin.de>
Date: Sat, 19 Aug 2006 10:10:38 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
References: <20060817230347.GC3440@localhost>
In-Reply-To: <20060817230347.GC3440@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Pfeiffer wrote:
> The SCSI/FW routines seem to work like a charm with a LSILogic Model/
> SYM13FW500-Disk on my old Macintosh titanium-IV laptop, with exactly
> the same relatively fresh git-kernel that does not work on the
> PowerBook5,8.  That is I compiled the kernel on the Apple Powerbook5,8
> and installed it on both machines.
> 
> SCSI/FW didn't work ever on the new PowerBook5,8.

[...]
> #!/bin/sh -x
> /bin/sh -n /home/shorty/scripts/scsi.start.sh && \
> 
> modprobe raw1394 && \
> modprobe ieee1394 disable_irm=0 disable_nodemgr=1 && \
> modprobe ohci1394 && \
> modprobe eth1394 && \
> modprobe sbp2 max_speed=3 workarounds=0x1 serialize_io=0 && \
> sleep 4 && \
> chown root.shorty /dev/raw1394

This script doesn't work as you may expect.

"modprobe raw1394" pulls ieee1394 in. Therefore all the parameters you 
give to ieee1394 in the next line are ignored. If you want to run 
ieee1394 with non-default parameters, load it first before any other 
1394 driver or put the parameters into /etc/modprobe.d/xyz or 
/etc/modprobe.conf.

"disable_nodemgr=1" will also enforce disable_irm=0 because some of the 
IRMs functionality requires the nodemgr kernel daemon.

The nodemgr is also the bridge between the 1394 bus and Linux' driver 
core. Some of the IEEE 1394 high-level drivers, including sbp2, don't 
find devices on their own but work on top of the driver core's device 
representations created by nodemgr. IOW sbp2 won't work with 
disable_nodemgr=1.

"modprobe eth1394" is not necessary if you have hotplug scripts. 
ieee1394 is, according to your log, configured to always adds an 
IP-over-1394 ROM entry to the local node's configuration ROM (it's 
actually RAM but works like ROM for other 1394 nodes), and there will be 
hotplug events generated for this entry as soon as the local node 
(driven by ohci1394) became operational.

(Similarly, sbp2 is usually loaded by hotplug scripts when an SBP-2 
device was detected. But if you rely on hotplug, you would have of 
course to supply any non-default module parameters to sbp2 via 
/etc/modprobe.d/xyz or /etc/modprobe.conf.)

"max_speed=3" i.e. S800 is the default and will stay so for the time 
being. It doesn't seem like S1600 hardware (standardized by IEEE 1394b) 
or even S3200 hardware (not standardized yet) will ever become available.

"workarounds=1" or 0x1 isn't precisely the default. But there is also 
sbp2's parameter max_sectors whose default value of 255 means exactly 
the same as the bit 1 in the workarounds bit field. The bit 1 exists in 
the workarounds parameter only to fully reflect what can be stuffed into 
sbp2's hardcoded blacklist (or "whitelist" depending on the point of view).

"serialize_io=0" has always been --- and still is --- unsafe. I recently 
started work to make it safe but am not done yet. serialize_io=0 does 
work with many devices though (by fortunate circumstances rather than by 
principle) and gains a measurable but hardly noticeable throughput 
advantage with some devices, AFAIK especially with S800 devices.

However all my comments to your script do not relate to the problem you 
are seeing with

[...]
> Aug 18 00:24:03 debby1-6 kernel: [38907.611119] ieee1394: Initialized config rom entry `ip1394'
> Aug 18 00:24:03 debby1-6 kernel: [38907.628475] ieee1394: raw1394: /dev/raw1394 device initialized

Here you are seeing proof for my comment on "modprobe raw1394": ieee1394 
is up earlier than raw1394...

> Aug 18 00:24:03 debby1-6 kernel: [38907.692766] PM: Adding info for ieee1394:fw-host0
> Aug 18 00:24:03 debby1-6 kernel: [38907.764726] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[4096]  IR/IT contexts=[8/8]
> Aug 18 00:24:03 debby1-6 kernel: [38907.912614] eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> Aug 18 00:24:04 debby1-6 kernel: [38909.170610] ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
> Aug 18 00:24:05 debby1-6 kernel: [38910.425599] ieee1394: Error parsing configrom for node 0-00:1023

...and you are using it with irm and nodemgr enabled.

AFAIK:
Node 0-00:1023 is the enclosure's SYM13FW501 which seems to be a link 
layer controller with integrated minimal PHY. (Node IDs are associated 
with PHYs, not links.) Node 0-01:1023 is an extra PHY in the enclosure, 
the PHY that actually drives the cable port (ports?). This is the 
TSB41LV03A on the bridge board. To take up two nodes, i.e. show the 
presence of two daisy-chained PHYs to the bus instead of one PHY, is 
apparently a property of some or all bridge boards with the old Symbios 
SBP-2 controller.

Node 0-02:1023 is of course the fw-host0.

"Error parsing configrom" often means that ieee1394 was unable to read 
anything from a devices ROM in the first place. This is often a normal 
condition for SBP-2 devices until their attached drive is fully 
operational. They then send a bus reset and publish a proper ROM, 
ieee1394 reads it, and Linux' driver core attaches the sbp2 driver as 
the matching protocol driver to it.

What if you force a bus reset about 5 seconds or more later, using 
gscanbus or 1394commander? Would ieee1349 detect the disk's SBP-2 
capability?

What if you load ieee1394 with disable_irm=1? (Before raw1394 of 
course.) Nodemgr takes care to run the IRM code in a very non-intrusive 
manner in newer Linux releases, but there is still the "selecting a new 
root node and resetting" routine which can't be avoided by an IRM that 
wants to be fully compliant to the specs.

> Aug 18 00:24:05 debby1-6 kernel: [38910.425992] PM: Adding info for ieee1394:001451fffe3148be
> Aug 18 00:24:05 debby1-6 kernel: [38910.426064] ieee1394: Host added: ID:BUS[0-02:1023]  GUID[001451fffe3148be]
> Aug 18 00:24:05 debby1-6 kernel: [38910.426209] PM: Adding info for ieee1394:001451fffe3148be-0

These two "Adding info for..." are of course related to the host 
adapter. The first one is the fw-host0 itself and the second one the 
ip1394 a.k.a. RFC 2734 unit that ieee1394 added to it (and eth1394 was 
bound to). 0x001451 is Apple's OUI.

[...]
> And gscanbus says this for:
> "Unknown
> Linux - ohci1394":
> 
> --------------------------
> SelfID Info
> -----------
> Physical ID: 2
[...]
> And this for "S400 unknown":
> 
> ---------------------------------
> SelfID Info
> -----------
> Physical ID: 1
> Link active: No

This is the TSB41LV03A.

> Gap Count: 63
> PHY Speed: S400
> PHY Delay: <=144ns
> IRM Capable: No
> Power Class: -1W
> Port 0: Connected to parent node
> Port 1: Not connected
> Port 2: Connected to child node
> Init. reset: No
[...]

There should be a third node, i.e. the node with physical ID 0 == the 
child node of the TSB41LV03A's node. Doesn't show gscanbus anything 
about that node? I expect that you at least see an icon and SelfID info. 
CSR ROM info might be missing; although the fact that ieee1394 failed to 
read the ROM doesn't mean that gscanbus will be unable to do so.
-- 
Stefan Richter
-=====-=-==- =--- =--==
http://arcgraph.de/sr/
