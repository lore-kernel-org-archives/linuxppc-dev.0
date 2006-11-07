Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B890667C4C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 20:04:46 +1100 (EST)
In-Reply-To: <1162888963.28571.459.camel@localhost.localdomain>
References: <20061107072126.C586067CD6@ozlabs.org>
	<93F89F52-7ED9-48F3-AE7A-15CDF5AB8E25@kernel.crashing.org>
	<1162888963.28571.459.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3210FBE5-5F22-4759-A728-A98175A435D6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 6/7] MPIC MSI backend
Date: Tue, 7 Nov 2006 10:04:24 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Agreed, though I prefer the naming to be ht_find_capability().

Of course, I just took "_msi" out of the name here ;-)

> Yes, I will do a cleanup pass on the MPIC code there. I think it  
> should
> only program the chip for polarity/sense in startup() and thus can
> "override" the native LSI setting of that vector when the interrupt is
> flagged as MSI without actually losing the original information.

You mean when we (in the future) reserve a range of vectors
for MSI allocation at MPIC startup?  Sure, that works.

> Right now, as you noticed, it's a non-issue for MSIs coming off HT, as
> both HT interrupts and MSIs are programmed to be edge in the MPIC
> itself, however, this is not ok with interrupts from the PCIe slot fow
> which, according to the device-tree on my Quad G5, the LSI is level  
> low.

["The PCIe slot" == the 16x PCIe slot on PowerMacs here, for
the record; it isn't connected over a bridge to HT, but is
directly connected to the CPC945 (U4) chip.]

There are more problems there (with this current code): the LSI
IRQ will always be #3, which cannot be used as an MSI IRQ; and
the MSI address to use can not be found on a parent HT bridge
(as there is none, duh).  That last problem makes the patch
perfectly safe for the CPC945 PCIe port though :-)

> Something else I'd like to do is add a generic IRQF_MSI purely for the
> sake of displaying "MSI" instead of "Edge" in /proc/interrupts :-)

Yes definitely.

> Though it might be useful for some backends to track what interrupts
> have been configured as MSI too.

That, too.

>>> ++static int msi_mpic_setup_msi_msg(struct pci_dev *pdev,
>>> +		struct msix_entry *entry, struct msi_msg *msg, int type)
>>> +{
>>> +	u64 addr;
>>> +
>>> +	addr = find_ht_magic_addr(pdev);
>>> +	msg->address_lo = addr & 0xFFFFFFFF;
>>> +	msg->address_hi = addr >> 32;
>>
>> You don't seem the check whether the "magic address" is outside
>> of 32-bit range and the device can do 32-bit only?
>
> Good point. It happens not to be on our chipset / firmware but we  
> should
> probably check in the check() callback. If it's the case, then we  
> refuse
> to enable MSI for that device.

Can't we just check here?  If not, what's the point of having
a return code here?  although doing the check in check() might
be conceptually nicer, sure.


Segher
