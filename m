Return-Path: <chris.wyse@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id E9FCF67A5A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 06:26:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Calling PCI Autoconfig again
Date: Tue, 7 Mar 2006 11:25:54 -0800
Message-ID: <927594BA71733F4BAA815162B79A3F513B2B03@ala-mail04.corp.ad.wrs.com>
From: "Wyse, Chris" <chris.wyse@windriver.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org, "McComb,
	Michael" <michael.mccomb@windriver.com>, "Touron,
	Emmanuel" <emmanuel.touron@windriver.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Thanks for the response.  Also, I apologize to the group - I didn't mean
to CC: the list with the last note.  However, I am glad that it got a
response from you.

Regarding the FPGA address assignment - it doesn't matter at all to me,
I just need to be able to access it on the PCI once the load is
complete.

As for the FPGA loader, the intent is that it will make the call to
rescan the PCI after the load is complete.  In fact, I intend to use it
as a way of determining if the load completed successfully, since we
don't have access to the DONE signal from the FPGA (we ran out of GPIO
pins). =20

If you missed this link from a previous post, please check it out.  It
implements a rescan of the PCI.

http://marc.theaimsgroup.com/?l=3Dlinux-hotplug-devel&m=3D101318310111131=
&w=3D
2=20

I see that you have a requirement for a fixed BAR address.  I think you
could modify the code from the above link to load a new BAR address
after the PCI has been rescanned.  You could probably add a routine to
register a BAR address for a device, and change the check_hw() routine
to see if a BAR address is registered.  If so, it would free the
allocated space for the device, allocate space at the desired address,
then write the new address to the BAR.

Hope this helps.  I'll be monitoring your thread for future
developments.


Chris Wyse
Member of Technical Staff
Embedded Technologies
860-749-1556 office
860-978-0849 cell
413-778-9101 fax
http://www.windriver.com
 =20


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Tuesday, March 07, 2006 11:27 AM
To: Wyse, Chris
Cc: Touron, Emmanuel; McComb, Michael; linuxppc-embedded@ozlabs.org
Subject: Re: Calling PCI Autoconfig again


On Mar 7, 2006, at 8:17 AM, Wyse, Chris wrote:

> Hi,
>
> This code will do the rescan of the PCI that we need for the FPGA.
> However, it currently only supports a single execution after the FPGA=20
> gets loaded.  Additional calls will continue to add FPGA devices to=20
> the PCI device list data structure.  I'm going to make some changes to

> it to handle multiple calls and to support multiple device ids.  I'm=20
> expecting it to take a day or two, but I'll make an initial cut at it=20
> today that will let us load the Spartan FPGA (only once).  This driver

> will be loaded when the kernel boots, so I believe that we'll just=20
> need to make a call into it (we won't have to dynamically load it like

> the phob driver).

I'm dealing with this exact same situation and having a discussion on
lkml regarding the proper way to do this.  In your case, do you care
what addresses the FPGA is assigned at?

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D114140791428032&w=3D2

> Michael,
>
> For the FPGA loader, you should load the FPGA, then make a call to
> pci_rescan_bus0() (I'm renaming check_hw() to pci_rescan_bus0()).  =20
> Next,
> you need to do a pci_find_device() to detect the newly loaded FPGA. =20
> If the pci_find_device() fails, assume that the FPGA load has not=20
> completed, so delay for some time frame (100 ms??), then rescan again.
> If still not found, rescan up to MAX_PCI_RESCANS (probably set it to=20
> 3) times, then return an error that the FPGA load failed.

Do you not know when the FPGA load is done?  I assume its under software
control so the "fpga loader" should just call the PCI setup code once it
has completed successfully.

- kumar
