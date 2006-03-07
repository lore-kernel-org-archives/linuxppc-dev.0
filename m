Return-Path: <chris.wyse@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 87554679E7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 00:49:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Calling PCI Autoconfig again
Date: Tue, 7 Mar 2006 05:49:02 -0800
Message-ID: <927594BA71733F4BAA815162B79A3F513B2942@ala-mail04.corp.ad.wrs.com>
From: "Wyse, Chris" <chris.wyse@windriver.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>
Cc: "Touron, Emmanuel" <emmanuel.touron@windriver.com>, "McComb,
	Michael" <michael.mccomb@windriver.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dave,

Thanks for the input.

I was thinking about making the FPGA a hotplug device.  I was really
hoping that I could just enable CONFIG_HOTPLUG in the kernel build, but
after some research, I don't believe that will work.  The hotplug
approach was more work than I wanted, but after your response, I decided
to look into it some more, specifically looking for an FPGA
implementation similar to ours.  I searched the linux-hotplug-devel list
for FPGA, and found this:

http://marc.theaimsgroup.com/?l=3Dlinux-hotplug-devel&m=3D101318310111131=
&w=3D
2

It implements a rescan of the PCI bus for a newly loaded FPGA device
(although despite the group name, it doesn't use HotPlug).

I'm going to try to use the code from the above link rather than
implement a hotplug driver. =20

Thanks again for the help.


Chris Wyse
Member of Technical Staff
Embedded Technologies
860-749-1556 office
860-978-0849 cell
413-778-9101 fax
http://www.windriver.com
 =20


-----Original Message-----
From: David Hawkins [mailto:dwh@ovro.caltech.edu]=20
Sent: Monday, March 06, 2006 11:33 PM
To: Wyse, Chris
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Calling PCI Autoconfig again

Wyse, Chris wrote:
> Hi,
> =20
> I'm working on a board (PPC440GX CPU) that has an FPGA on it.  The=20
> FPGA software has a PCI interface.  If I load the FPGA, then boot the=20
> Linux kernel, the FPGA is recognized as a device on the PCI bus. =20
> However, I'd like to load the FPGA after the kernel has booted, then=20
> run autoconfig again to detect the device.  What's the best way to do
this?
> =20
> Please send responses directly to me (in addition to the list), since=20
> I am not subscribed to the list.

Hi Chris,

I haven't had to do this, but I've thought about how I might do it.

In compact PCI, you can hot-swap a PCI device, and the Linux host is
supposed to go and re-enumerate the PCI bus. There is a pci (host-side)
hotplug skeleton in the source;

linux-2.6/drivers/pci/hotplug/pcihp_skeleton.c

I believe you can do the following;

   - consider the 440GX is a hotplug controller
     (and write a hotplug driver appropriately)
   - when Linux loads the FPGA, the FPGA generates a hotplug
     event, i.e., it just got plugged in
     (I'm not sure what signal is generated, perhaps a
      power-management interrupt PME#?)
   - the 440GX hotplug controller re-enumerates the PCI bus
     and finds the device

I'm sure you can get an idea from the hotplug skeleton what
re-enumeration entails.

Cheers
Dave
