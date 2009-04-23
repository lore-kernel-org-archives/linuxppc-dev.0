Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 970C7DE0E7
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 04:47:24 +1000 (EST)
Message-Id: <97DF2A19-563D-404A-AD3D-039D5989E489@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <49F07A15.9010006@mlbassoc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PCI changes 2.6.26 => 2.6.28
Date: Thu, 23 Apr 2009 13:47:15 -0500
References: <49EDF333.4000200@mlbassoc.com>	<49EE2CD8.7010700@mlbassoc.com>	<29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>	<49EE306D.3000401@mlbassoc.com>	<49EE4729.3000100@mlbassoc.com>	<612CEF05-3EFB-4947-B5FC-B35C1F9568D7@kernel.crashing.org>	<46B035C0-624F-41E4-BFDD-C16479CF8FC8@kernel.crashing.org>	<49EE5021.4020703@mlbassoc.com>	<306F293D-44CD-4238-ADA9-BB7436C7004C@kernel.crashing.org>	<49EE5A80.4030209@mlbassoc.com>
	<B869D8DC-2A3B-4B53-8BFD-15D403CE20D4@kernel.crashing.org>
	<49F07A15.9010006@mlbassoc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 23, 2009, at 9:24 AM, Gary Thomas wrote:

> I have found the culprit - in arch/powerpc/kernel/pci_32.c
>
> static void
> fixup_hide_host_resource_fsl(struct pci_dev *dev)
> {
> 	int i, class = dev->class >> 8;
>
> #if 0
> 	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
> 	     class == PCI_CLASS_BRIDGE_OTHER) &&
> #else
>        if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
> #endif
> 		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
> 		(dev->bus->parent == NULL)) {
> 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> 			dev->resource[i].start = 0;
> 			dev->resource[i].end = 0;
> 			dev->resource[i].flags = 0;
> 		}
> 	}
> }
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID,  
> fixup_hide_host_resource_fsl);
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,  
> fixup_hide_host_resource_fsl);
>
> This function is now (the #if 0 case is in 2.6.28) tossing out
> the memory resources used by the PCI bridge itself.  This makes
> everything fall over, at least on my 834x platform.
>
> This change was applied 2008-10-08, but it seems incorrect on the  
> 834x.

Its not.  The PCI subsystem shouldn't be allocating or seeing the PHBs  
resources.

>> Are you using u-boot to boot?  If so is the board port public?
>
> My systems use RedBoot (I'm the original author of RedBoot, so one  
> would
> expect that).  At this moment, the code isn't public, sorry.

Ok.  Not sure if RedBoot has a simple memory dump command, but if you  
can dump the IMMR registers for PCI (0x8400 - IOS and 0x8500 - PCI1).   
(I'm assuming PCI1 is the one you are using).  From IOS I wanted the  
outbound registers, for PCI1 the inbound ATU registers.

- k
