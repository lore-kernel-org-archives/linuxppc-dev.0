Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5F82DDEC4
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 01:18:08 +1000 (EST)
In-Reply-To: <20070912094536.013bf903@weaponx.rchland.ibm.com>
References: <200708301033.28423.ml@stefan-roese.de>
	<20070912094536.013bf903@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AD3577C7-050E-4D29-AF23-2C53A93E443F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [POWERPC] PCI Bug fix for MRM failure in PPC 440EPx
Date: Wed, 12 Sep 2007 10:14:29 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 12, 2007, at 9:45 AM, Josh Boyer wrote:

> On Thu, 30 Aug 2007 10:33:28 +0200
> Stefan Roese <ml@stefan-roese.de> wrote:
>
>> Problem Description and Fix : Memory Read Multiples(MRM) do not work
>> correctly on PPC 440EPX based systems. A PCI driver determines  
>> whether
>> MRMs are supported by reading the PCI cache line size register. If  
>> this
>> value is zero then MRMs are not supported. However some PCI drivers
>> write to the PCI cache line size register on initialization. This
>> results in MRMs being sent to system memory on 440EPX based systems.
>> Since MRMs do not work correctly in 440EPX based systems this may  
>> cause
>> system hang. This patch solves this problem by modifying the PPC
>> platform specific PCI configuration register write function, by  
>> forcing
>> any value written to PCI_CACHE_LINE_SIZE register to be 0. This  
>> fix was
>> tested on different PCI cards : i.e. Silicon Image ATA card and Intel
>> E1000 GIGE card. On Silicon Image ATA card without this fix in place
>> creating a filesystem on IDE drive "mke2fs /dev/hda" was hanging the
>> system. MRMs issued by the PCI card were seen on the PCI analyzer  
>> since
>> the Silicon Image driver was setting the PCI_CACHE_LINE_SIZE  
>> register to
>> 255. With this patch the PCI_CACHE_LINE_SIZE register was 0 and only
>> Memory Reads were seen on PCI analyzer.
>>
>> Signed-off-by: Pravin M. Bathija <pbathija@amcc.com>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>>
>> ---
>> I know this patch is a little "dirty", but perhaps somebody has a  
>> better
>> idea to fix this problem. Thanks.
>
> For the peanut gallery, Stefan and I discussed this a bit on IRC today
> and a different approach for arch/powerpc is going to be looked at
> instead.  Namely, introducing a new flag for indirect_type in the
> pci_controller structure to key off of instead of having ifdefs.

I assume you'll be adding to the 'quirk' flags that we already have  
in place.

- k
