Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF92A679F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 06:57:48 +1100 (EST)
In-Reply-To: <927594BA71733F4BAA815162B79A3F513B2B03@ala-mail04.corp.ad.wrs.com>
References: <927594BA71733F4BAA815162B79A3F513B2B03@ala-mail04.corp.ad.wrs.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FF0A316F-B6A0-4C6A-B7A9-CA2C6C1AB72C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Calling PCI Autoconfig again
Date: Tue, 7 Mar 2006 13:57:44 -0600
To: "Wyse, Chris" <chris.wyse@windriver.com>
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


On Mar 7, 2006, at 1:25 PM, Wyse, Chris wrote:

> Hi Kumar,
>
> Thanks for the response.  Also, I apologize to the group - I didn't  
> mean
> to CC: the list with the last note.  However, I am glad that it got a
> response from you.
>
> Regarding the FPGA address assignment - it doesn't matter at all to  
> me,
> I just need to be able to access it on the PCI once the load is
> complete.
>
> As for the FPGA loader, the intent is that it will make the call to
> rescan the PCI after the load is complete.  In fact, I intend to  
> use it
> as a way of determining if the load completed successfully, since we
> don't have access to the DONE signal from the FPGA (we ran out of GPIO
> pins).
>
> If you missed this link from a previous post, please check it out.  It
> implements a rescan of the PCI.
>
> http://marc.theaimsgroup.com/?l=linux-hotplug- 
> devel&m=101318310111131&w=
> 2

I saw this link and felt that the code was doing alot of work that  
was already handled by the PCI subsystem for you.  For example, there  
isn't a need for you to kmalloc your own dev and go through all the  
effort.

For your case it should be as simple as the following:

bus = pci_find_bus(0, bus_of_dev);
dev = pci_scan_single_device(bus, devfn);
pci_bus_alloc_resource(...);
pci_bus_add_devices(bus);

You could also look at using the pci_scan_slot() / pci_find_slot()  
instead of pci_scan_single_device().

- kumar
