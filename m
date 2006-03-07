Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66FC767A00
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 03:26:20 +1100 (EST)
In-Reply-To: <927594BA71733F4BAA815162B79A3F513B2958@ala-mail04.corp.ad.wrs.com>
References: <927594BA71733F4BAA815162B79A3F513B2958@ala-mail04.corp.ad.wrs.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BAB64425-65CD-4311-9A93-004EBA27729A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Calling PCI Autoconfig again
Date: Tue, 7 Mar 2006 10:26:30 -0600
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


On Mar 7, 2006, at 8:17 AM, Wyse, Chris wrote:

> Hi,
>
> This code will do the rescan of the PCI that we need for the FPGA.
> However, it currently only supports a single execution after the FPGA
> gets loaded.  Additional calls will continue to add FPGA devices to  
> the
> PCI device list data structure.  I'm going to make some changes to  
> it to
> handle multiple calls and to support multiple device ids.  I'm  
> expecting
> it to take a day or two, but I'll make an initial cut at it today that
> will let us load the Spartan FPGA (only once).  This driver will be
> loaded when the kernel boots, so I believe that we'll just need to  
> make
> a call into it (we won't have to dynamically load it like the phob
> driver).

I'm dealing with this exact same situation and having a discussion on  
lkml regarding the proper way to do this.  In your case, do you care  
what addresses the FPGA is assigned at?

http://marc.theaimsgroup.com/?l=linux-kernel&m=114140791428032&w=2

> Michael,
>
> For the FPGA loader, you should load the FPGA, then make a call to
> pci_rescan_bus0() (I'm renaming check_hw() to pci_rescan_bus0()).   
> Next,
> you need to do a pci_find_device() to detect the newly loaded  
> FPGA.  If
> the pci_find_device() fails, assume that the FPGA load has not
> completed, so delay for some time frame (100 ms??), then rescan again.
> If still not found, rescan up to MAX_PCI_RESCANS (probably set it  
> to 3)
> times, then return an error that the FPGA load failed.

Do you not know when the FPGA load is done?  I assume its under  
software control so the "fpga loader" should just call the PCI setup  
code once it has completed successfully.

- kumar
