Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 533A4679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 15:33:05 +1100 (EST)
Message-ID: <440D0CE7.9030702@ovro.caltech.edu>
Date: Mon, 06 Mar 2006 20:32:39 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Wyse, Chris" <chris.wyse@windriver.com>
Subject: Re: Calling PCI Autoconfig again
References: <927594BA71733F4BAA815162B79A3F513B27FD@ala-mail04.corp.ad.wrs.com>
In-Reply-To: <927594BA71733F4BAA815162B79A3F513B27FD@ala-mail04.corp.ad.wrs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Wyse, Chris wrote:
> Hi,
>  
> I'm working on a board (PPC440GX CPU) that has an FPGA on it.  The FPGA 
> software has a PCI interface.  If I load the FPGA, then boot the Linux 
> kernel, the FPGA is recognized as a device on the PCI bus.  However, I'd 
> like to load the FPGA after the kernel has booted, then run autoconfig 
> again to detect the device.  What's the best way to do this? 
>  
> Please send responses directly to me (in addition to the list), since I 
> am not subscribed to the list.

Hi Chris,

I haven't had to do this, but I've thought about how I might do it.

In compact PCI, you can hot-swap a PCI device, and the Linux host
is supposed to go and re-enumerate the PCI bus. There is a
pci (host-side) hotplug skeleton in the source;

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
