Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 043A2DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Nov 2007 06:18:50 +1100 (EST)
Message-Id: <A4E1A594-5A31-4EFE-B4F9-E4B24F9207F7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1195191333.28865.140.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Latest paulus.git PCI broken on mpc8540?
Date: Fri, 16 Nov 2007 13:18:41 -0600
References: <473C7FCC.7050307@anagramm.de>
	<4E0EFED3-8697-4768-9D89-A2443AEC82A5@kernel.crashing.org>
	<1195191333.28865.140.camel@pasglop>
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


On Nov 15, 2007, at 11:35 PM, Benjamin Herrenschmidt wrote:

>
> On Thu, 2007-11-15 at 22:37 -0600, Kumar Gala wrote:
>>> PCI: Probing PCI hardware
>>> PCI: Cannot allocate resource region 0 of device 0000:00:12.0
>>> PCI: Cannot allocate resource region 1 of device 0000:00:12.0
>>> PCI: Cannot allocate resource region 2 of device 0000:00:12.0
>>> PCI: Cannot allocate resource region 3 of device 0000:00:12.0
>>> PCI: Cannot allocate resource region 4 of device 0000:00:12.0
>>> PCI: Cannot allocate resource region 0 of device 0000:00:14.0
>>> PCI: Cannot allocate resource region 2 of device 0000:00:14.0
>>
>> this isn't really an error.  Its more of a warning, the kernel will
>> try and allocate these later and I'm guessing based on what you are
>> seeing it succeeded.
>>
>> Benh, can we possibly change these messages in pci_32.c?
>
> Heh, well, I've been working on 44x PCI lately and got annoyed by the
> exact same messages, though I'm still pondering what would be a better
> replacement.

Well, for one the generic pci code will complain if its not able to  
allocate the resource which is the true failure.

I'm thinking maybe we just make these pr_debug() instead of standard  
printk?

- k
