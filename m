Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C46F7DDF8E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jun 2008 02:16:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Anybody have an mpc5200b mscan linux driver under 2.6.24,
	ARCH=powerpc or equiv?
Date: Wed, 18 Jun 2008 09:16:29 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6022FEB1A@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <4859193A.1040105@grandegger.com>
References: <4858113F.4050203@vecimanetworks.com>	<48582CC6.60004@freescale.com>
	<161B3BAD77161449A144FF054231C3D6022FEAAE@uss-am-xch-01.am.trimblecorp.net>
	<48591167.1050303@grandegger.com>
	<161B3BAD77161449A144FF054231C3D6022FEAC0@uss-am-xch-01.am.trimblecorp.net>
	<4859193A.1040105@grandegger.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: "Wolfgang Grandegger" <wg@grandegger.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks again Wolfgang. I've successfully built and insmod' the
following:=20

vcan.ko=20
can-dev.ko=20
mscan-mpc5200.ko

(I'll figure out the dependencies for modules.dep and use modprobe in
the future, but for now I think I've loaded what I need).

It looks like I should be good-to-go, but I'm having a socket address
issue with the cansniffer app. I have posted a question to the
socket-CAN mailing list.

Your advice below did get me successfully building the modules for my
2.6.24 kernel, so that part of the issue is closed.


-Mike

-----Original Message-----
From: Wolfgang Grandegger [mailto:wg@grandegger.com]=20
Sent: Wednesday, June 18, 2008 9:19 AM
To: Mike Timmons
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Anybody have an mpc5200b mscan linux driver under 2.6.24,
ARCH=3Dpowerpc or equiv?

Mike Timmons wrote:
> Thanks for the quick response. I'm currently using 2.6.24 =
ARCH=3Dpowerpc
> on the Lite5200b. I just searched for an obvious patch but it is
unclear
> to me what patch(es) I should take at this point.
>=20
> Can you direct me to the patch(es) I need? Again, thank you.

As a first try you can build Socket-CAN out of tree by just downloading=20
the SVN trunk repository as described here:

http://developer.berlios.de/svn/?group_id=3D6475

Then go to trunk/kernel/2.6 and type:

   $ make ARCH=3Dpowerpc KERNELDIR=3D<path-to-kernel> \
     CONFIG_CAN_MSCAN=3Dm CONFIG_CAN_MPC52XX=3Dm

You need the following modules on your target:

   drivers/net/can/*.ko
   drivers/net/can/mscan/*.ko

There is a script to create kernel patches, but I don't known if it=20
works right now (there have been some issues recently). Please ask on=20
the Socket-CAN mailing list.

Wolfgang.

>=20
> -Mike=20
>=20
> -----Original Message-----
> From: Wolfgang Grandegger [mailto:wg@grandegger.com]=20
> Sent: Wednesday, June 18, 2008 8:45 AM
> To: Mike Timmons
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Anybody have an mpc5200b mscan linux driver under 2.6.24,
> ARCH=3Dpowerpc or equiv?
>=20
> Mike Timmons wrote:
>> I'm trying to wrestle the peak CAN driver for the old,
non-device-tree
>> ppc into submission but I'm making a mess of it so far.
>>
>> I think I'll get it going at some point, but if anybody has or knows
> of
>> an mscan driver for the mpc5200 can you alert me?
>=20
> http://svn.berlios.de/svnroot/repos/socketcan/trunk/README
>=20
> The Socket-CAN core is part of the official kernel since 2.6.25.
>=20
> Wolfgang.
>=20
>> Thanks,
>> Mike
>>
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
>>
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org]
>> On Behalf Of Scott Wood
>> Sent: Tuesday, June 17, 2008 4:30 PM
>> To: Mike Winter
>> Cc: linuxppc-embedded@ozlabs.org
>> Subject: Re: PCI DMA Problems With 82xx?
>>
>> Mike Winter wrote:
>>> We are developing with an 8248-based platform, and we have a vendor=20
>>> telling us that the PCI hardware is unreliable on this CPU family,
in
>=20
>>> particular the DMA functionality.  A quick search of this list
> doesn't
>>> turn up any horror stories, although the processor does have some
PCI
>=20
>>> errata listed.  Does anybody have any practical experience using PCI
>> on=20
>>> the 8248 or similar that they can share with me?   Thanks.
>> Make sure that you park the bus on PCI, and elevate PCI's arbitration

>> priority.  See fixup_pci() in arch/powerpc/boot/cuboot-pq2.c.
>>
>> I haven't had a problem with PCI DMA when that is done, though I
> haven't
>> done significant stress testing.
>>
>> -Scott
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
>=20
>=20
