Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06381B6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 09:31:22 +1000 (EST)
Received: by vws20 with SMTP id 20so3728667vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 03 Jul 2011 16:31:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <288B47E0-3869-486D-B753-62EFA1EEF66D@kernel.crashing.org>
References: <1309357060-20872-1-git-send-email-dbaryshkov@gmail.com>
	<F4E7EABC-B63F-4776-A8EB-8C93F64C2A3C@kernel.crashing.org>
	<BANLkTinarWc6n5KLJdx=kFC5wysw+8VQtw@mail.gmail.com>
	<288B47E0-3869-486D-B753-62EFA1EEF66D@kernel.crashing.org>
Date: Mon, 4 Jul 2011 03:31:18 +0400
Message-ID: <CALT56yNFuJMWYTJc6WTWcDBug9KzPysMJ48CVUBgyzom5rqp8A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: enable access to HT Host-Bridge on Maple
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/3/11, Segher Boessenkool <segher@kernel.crashing.org> wrote:
>>>> CPC925/CPC945 use special window to access host bridge
>>>> functionality of
>>>> u3-ht. Provide a way to access this device.
>>>
>>> Why?  Is anything going to use it?
>>
>> Hmmm. Why not?
>
> Because if nothing uses it it is essentially dead code.

1) It provides some (possibly debug) information to users
2) It provides a way to configure (e.g. HT address mask (reg 80),
   some bridge control regs (around c0-ff), etc.

>> Initially I stumbled upon the fact that powermac provides
>> such acces. Then I discovered that it provides configuration for
>> memory windows
>> and other parts.
>
> There are no memory windows in there afaik.  The main use is the HT
> link config stuff, which in a few places needs special handling to
> work :-/

Register 80 (0xf8070200) is an HT1 address mask, which configures
which memory belongs to HT bridge & devices (contrary to AGP/PCIe)

>> (I needed it for my hack to add AGP bridge on U3 in Linux,
>> as I didn't want to change firmware).
>
> Can you tell more about this?

I have a Mapple-D board (aka IBM PPC970FX ev. kit). It has an AGP slot,
which I would like to use. The slot is unsupported in PIBS (the original
firmware) (it doesn't enumerate devices behind the slot, it doesn't setup it,
it doesn't put u3-agp in device tree).

I didn't want to hack the PIBS (at least while it's possible and for initial
debug of the hardware setup),
so I had to develop a patch for Linux kernel which would:
1) configure hardware (memory windows, IRQs, etc).
2) tell Linux about the AGP bridge.

Second part is more or less complete (with some hacks though). Basically
I register an u3-agp slot if there is no u3-agp and u4-pcie devices. This still
needs an improvement before I'd submit this code anywhere.

I've mostly finished the HW setup (I can see devices behind the bridge).
The radeon plugged into AGP slot starts to warm up, but it fails somewhere.
The thing I still miss (or at least one of them) is the IRQ routing. Ben gave me
some possible pointers, so I'll have to check if he is right or not.
Unfortunately
I still hand't time to accomplish this. I can show my (possibly a bit
ugly) code,
but it still doesn't fully work.

>>>> +static int u3_ht_root_read_config(struct pci_controller *hose, u8
>>>> offset,
>>>> +				  int len, u32 *val)
>>>> +{
>>>> +	volatile void __iomem *addr;
>>>> +
>>>> +	addr = hose->cfg_addr;
>>>> +	addr += ((offset & ~3) << 2) + (4 - len - (offset & 3));
>>>
>>> This will only work for len 1,2,4 with offset a multiple of len,
>>> is that
>>> guaranteed here?
>>
>> I have to check. I think there is no guarantee, but standard accessors
>> are created exactly for 1, 2 and 4-byte access. And IIRC according
>> to PCI specs, offset should be len-aligned.
>
> If other places that need it do not do an alignment check, you don't
> need
> to either I suppose.  But could you make the switch for length have
> explicit 1,2,4 and default error?

Yes, of course. I wanted to overcome this, but of course I can split it
back to the switch.

BTW: the corresponding PowerMac code has a bug: try reading
VID/DID as a byte. word and dword and compare the outcome
with the output from typical PCI device.

>>>> +static int u3_ht_root_write_config(struct pci_controller *hose, u8
>>>> offset,
>>>> +				  int len, u32 val)
>>>> +{
>>>> +	volatile void __iomem *addr;
>>>> +
>>>> +	addr = hose->cfg_addr + ((offset & ~3) << 2) + (4 - len - (offset
>>>> & 3));
>>>> +
>>>> +	if (offset >= PCI_BASE_ADDRESS_0 && offset < PCI_CAPABILITY_LIST)
>>>> +		return PCIBIOS_SUCCESSFUL;
>>>
>>> This is a workaround for something; at the very least it needs a
>>> comment,
>>> but probably it shouldn't be here at all.
>>
>> I'll add a comment. Basically these registers are unimplemented on
>> u3/u4
>> bridges and at least some kinds of access to them cause system freeze.
>> I'll try to check what triggers what this night.
>
> I don't think the hardware freezes, but probably Linux isn't happy
> when it
> tries to write to the non-existent BARs.  Or something like that.

IIRC I've had problems even when reading. Will run an experiment tomorrow.

>>>>  static int u3_ht_read_config(struct pci_bus *bus, unsigned int
>>>> devfn,
>>>>  			     int offset, int len, u32 *val)
>>>>  {
>>>> @@ -217,6 +265,9 @@ static int u3_ht_read_config(struct pci_bus
>>>> *bus, unsigned int devfn,
>>>>  	if (hose == NULL)
>>>>  		return PCIBIOS_DEVICE_NOT_FOUND;
>>>>
>>>> +	if (bus->number == hose->first_busno && devfn == PCI_DEVFN(0, 0))
>>>> +		return u3_ht_root_read_config(hose, offset, len, val);
>>>> +
>>>>  	if (offset > 0xff)
>>>>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>
>>> u3_ht_root_read_config() can get an offset out of range this way.
>>
>> Yes, as offsets for this host bridge can be larger then 0xff. U3/U4
>> have
>> some HT configuration there, and I didn't want to impose a limit
>> there.
>> If you are against this, I can change the order of calls.
>
> The HT config is at (PCI) offset 0x40.  There are no implemented
> registers
> at PCI offset >= 0x100.  That corresponds to f8070000..f80703ff, there's
> one 4-byte PCI reg per 16 byte U3 bus address.

Hmmm. I saw the "HT Performance Monitor" part of the U4 spec, but
didn't notice that all regs are marked as "not implemented".

>>>>  	hose->cfg_data = ioremap(0xf2000000, 0x02000000);
>>>> +	hose->cfg_addr = ioremap(0xf8070000, 0x1000);
>>>
>>> Eww.  You could just make a global instead of abusing existing
>>> fields,
>>> there can be only one CPC9x5 in a system anyway.
>>
>> This was a copy-paste of corresponding PowerMac code. Do you really
>> want
>> for me to change this to global variable?
>
> It could use a comment at least.  The addresses aren't "cfg_data" and
> "cfg_addr" at all.

Fine, I'll add a comment here.

>> BTW: I see a lot of code duplication between PowerMac and Maple pci.c
>> files. Would you like a patch that merges those files to something
>> like arch/powerpc/sysdev/u3-pci.c? I can try merging them...
>
> That would be most excellent!  I hope there isn't much pmac special-
> casing
> needed for that.

Still have to check. Please don't expect a patch soon.

-- 
With best wishes
Dmitry
