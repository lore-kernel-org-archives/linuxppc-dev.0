Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EC89BDDFE2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Dec 2007 04:36:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx devicetrees
Date: Thu, 13 Dec 2007 09:36:04 -0800
In-Reply-To: <EDAE140DF1B2FC42B5867C22CA0B333F0A590F@XMBIL132.northgrum.com>
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<47493D4F.4070605@dlasys.net><fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com><4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
	<20071213045215.DA8BAFB8060@mail11-blu.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A590F@XMBIL132.northgrum.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>,
	"David H. Lynch Jr." <dhlii@dlasys.net>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Message-Id: <20071213173458.5A11E1B1005E@mail192-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Koss, Mike (Mission Systems) [mailto:mike.koss@ngc.com]=20
> Sent: Thursday, December 13, 2007 5:49 AM
> To: Stephen Neuendorffer; David H. Lynch Jr.; Grant Likely;=20
> linuxppc-embedded
> Subject: RE: Xilinx devicetrees
>=20
> SN> Interesting idea..  I've been trying to figure out how to=20
> architect this=20
> SN> better, but it requires some information passing within=20
> EDK that isnot=20
> SN> today supported.  I don't see at all how to synchronize this with=20
> SN> patches to the kernel, tho.  My approach is to describe=20
> the hardware=20
> SN> as completely and faithfully as we can (given the=20
> information in EDK),=20
> SN> and let the drivers do whatever with it that they want to.
>=20
> You'll have to correct if I'm wrong here, but from what I've=20
> been reading up about EDK and its built-in Tcl interface, one=20
> can load their system.xmp with corresponding mhs and then use=20
> Tcl to traverse the device information to create the same=20
> information as found using the generated BSP. This would=20
> allow for a Tcl system that could be setup such that a main=20
> (unchanging, or slowly changing) Tcl script that would start=20
> the EDK definition traversal and upon finding a new device it=20
> would use a registered 'handler' Tcl function. These handlers=20
> could be stored as seperate script/files and would be=20
> registered at the start of the main script either via a=20
> config file or by searching a directory and looking for tags=20
> stored at the top of the Tcl files in comments. These driver=20
> handlers would be passed the handle to the system definition=20
> and then know how to gather the information they need to=20
> create their entry in the device tree. This approach gets=20
> around the issue of losing defaults found in the mhs file.

This seems like alot of work, for relatively little benefit.  :)
Instead, I think it is safer to just describe the IP as completely as we
can up front.  Everything else should be done by the Linux driver.  Now
today there is a problem, which is that there isn't a standard way of
having a device describe itself, in the format of a device tree.  This
is something that we'll likely have to add hooks for in the future.

> I originally looked at trying to perform the same thing using=20
> just device drivers in EDK, but I think I found some pitfall.=20
>  Oh, I think it was that I would have to choose the OS for=20
> the processor and EDK wants to build the library, but there=20
> isn't anything to compile for Linux (or I wasn't compiling=20
> anything for the linux BSP) and that was adding extra time to=20
> the download.bit generation and that is already a long build process.

I can't imagine that generating this file is the bottleneck in getting
to a bitstream (or at least, I really hope it isn't!)=20

Steve
