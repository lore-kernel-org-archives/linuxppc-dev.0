Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id D34D467BEA
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 21:11:36 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Heiko J Schick <info@schihei.de>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Mon, 11 Dec 2006 11:11:09 +0100
References: <20061207172259.64168f8c@localhost>
	<200612091244.05862.arnd@arndb.de>
	<89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
In-Reply-To: <89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612111111.10740.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 10 December 2006 19:42, Heiko J Schick wrote:
> On 09.12.2006, at 12:44, Arnd Bergmann wrote:
> 
> We have to include the IPMI information in a way which can be used  
> for controllers which are accessed via memory mapped or legacy I/O.

There should be no legacy I/O on an of_platform device, but only
on behind a PCI or ISA bus, right? For PCI, the probing happens
using the pci ipmi driver, so that's not our problem here, and
I hope we don't need to worry about ISA buses any more.

> Furthermore, we have to include the register information that it will  
> work not only for KCS interfaces. It should be possible to include BT  
> and SMIC interfaces, too.

yes

> We have two options how we wanna present IPMI in the OFDT.
> 
> (1)
> 
> name = ipmi
> device_type = ipmi
> compatible = ipmi-kcs, ipmi-1.5, ...
> 
> regs = <addr> <len> <addr> <len> (for KCS interfaces)
> 	or
> regs = <addr> <len> <addr> <len> <addr> <len> (for BT and SMIC  
> interfaces)
> 
> (2)
> name = ipmi
> device_type
> regs = <addr> <len>
> reg-spacing = <number>
> reg-size = <number>
> reg-shift = <number>
> 
> The main difference between (1) and (2) is that (2) will represent  
> the whole register region within the reg property. Because of that  
> you have to include additional properties.
> 
> In (1) you will include every register (e.g. Cmd / Status, Data_In /  
> Data_Out, etc.) within the reg property. The values for reg-spacing  
> are calculated by subtracting addr2 - addr1. The reg-size are the  
> len's within the reg property.
> 
> Personally I prefer (1), because I a the moment I don't see a big  
> benefit in (2). For both options of have to implement source code  
> which checks the compatible node to get the used interface type.  
> According to the emitted interface type you have to read in (1) two  
> or three registers from the reg property.
> 
> In (2) you have to calculate two or three addresses (with the help of  
> reg and the additional reg-spacing, etc. properties).

I'd like to see (2), because that's what the driver currently expects.
The common ipmi code in linux _always_ does this calculation anyway, and
(1) only means we have to compute the reg-spacing and reg-size from the
layout of the registers, which gets rather complicated if you have more
than two of them in the reg property.

	Arnd <><
