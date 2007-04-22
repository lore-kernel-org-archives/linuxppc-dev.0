Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 154C1DDE00
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 14:53:31 +1000 (EST)
In-Reply-To: <1177200410.6080.26.camel@localhost.localdomain>
References: <20070419073555.01990DDECB@ozlabs.org>
	<0846c0d8efafe7258075826b9c869fea@bga.com>
	<1177200410.6080.26.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b876ed7a2f13ad05a04f0aac3b364c9a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 5/7] Enable MSI mappings for MPIC
Date: Sat, 21 Apr 2007 23:53:20 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 21, 2007, at 7:06 PM, Benjamin Herrenschmidt wrote:
>> This is just begging to be written in terms of
>> pci_bus_find_ht_capability.  Well,
>> we have pci_bus_find_capability, and pci_find_ht_capability, I'm sure
>> we could
>> create that.   It also means this and the other nearby functions want
>> to be
>> written in terms of a struct pci_bus and config accessors.
>
> A lot of that code has to run way before the PCI config stuff is even
> useable and certainly before the PCI layer data structures have been
> created.... Sucks but that's how it is for now. We might be able to
> tweak and delay init of the APICs etc... but I don't think I can be
> bothered for now as it's a bit of a corner case.
>

I wasn't proposing to make the code wait until the pci layer had
discovered the ht bridge.  Rather I was thinking that a struct
pci_bus instance created for the purpose with only ops and maybe
sysdata initialized.  The purpose being to reuse the generic code.

Maybe I'll have to code something up.   Perhaps when I'm a bit
less overloaded.

milton
