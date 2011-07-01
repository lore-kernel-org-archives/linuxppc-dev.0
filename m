Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8595B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Jul 2011 05:11:13 +1000 (EST)
Received: by vxb40 with SMTP id 40so2828580vxb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Jul 2011 12:11:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <F4E7EABC-B63F-4776-A8EB-8C93F64C2A3C@kernel.crashing.org>
References: <1309357060-20872-1-git-send-email-dbaryshkov@gmail.com>
	<F4E7EABC-B63F-4776-A8EB-8C93F64C2A3C@kernel.crashing.org>
Date: Fri, 1 Jul 2011 23:11:09 +0400
Message-ID: <BANLkTinarWc6n5KLJdx=kFC5wysw+8VQtw@mail.gmail.com>
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

Hello,

Thanks for the review.

On 7/1/11, Segher Boessenkool <segher@kernel.crashing.org> wrote:
>> CPC925/CPC945 use special window to access host bridge
>> functionality of
>> u3-ht. Provide a way to access this device.
>
> Why?  Is anything going to use it?

Hmmm. Why not? Initially I stumbled upon the fact that powermac provides
such acces. Then I discovered that it provides configuration for memory windows
and other parts. (I needed it for my hack to add AGP bridge on U3 in Linux,
as I didn't want to change firmware).

>> +static int u3_ht_root_read_config(struct pci_controller *hose, u8
>> offset,
>> +				  int len, u32 *val)
>> +{
>> +	volatile void __iomem *addr;
>> +
>> +	addr = hose->cfg_addr;
>> +	addr += ((offset & ~3) << 2) + (4 - len - (offset & 3));
>
> This will only work for len 1,2,4 with offset a multiple of len, is that
> guaranteed here?

I have to check. I think there is no guarantee, but standard accessors
are created exactly for 1, 2 and 4-byte access. And IIRC according
to PCI specs, offset should be len-aligned.

>> +static int u3_ht_root_write_config(struct pci_controller *hose, u8
>> offset,
>> +				  int len, u32 val)
>> +{
>> +	volatile void __iomem *addr;
>> +
>> +	addr = hose->cfg_addr + ((offset & ~3) << 2) + (4 - len - (offset
>> & 3));
>> +
>> +	if (offset >= PCI_BASE_ADDRESS_0 && offset < PCI_CAPABILITY_LIST)
>> +		return PCIBIOS_SUCCESSFUL;
>
> This is a workaround for something; at the very least it needs a
> comment,
> but probably it shouldn't be here at all.

I'll add a comment. Basically these registers are unimplemented on u3/u4
bridges and at least some kinds of access to them cause system freeze.
I'll try to check what triggers what this night.

>>  static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
>>  			     int offset, int len, u32 *val)
>>  {
>> @@ -217,6 +265,9 @@ static int u3_ht_read_config(struct pci_bus
>> *bus, unsigned int devfn,
>>  	if (hose == NULL)
>>  		return PCIBIOS_DEVICE_NOT_FOUND;
>>
>> +	if (bus->number == hose->first_busno && devfn == PCI_DEVFN(0, 0))
>> +		return u3_ht_root_read_config(hose, offset, len, val);
>> +
>>  	if (offset > 0xff)
>>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>
> u3_ht_root_read_config() can get an offset out of range this way.

Yes, as offsets for this host bridge can be larger then 0xff. U3/U4 have
some HT configuration there, and I didn't want to impose a limit there.
If you are against this, I can change the order of calls.

>
>>  	hose->cfg_data = ioremap(0xf2000000, 0x02000000);
>> +	hose->cfg_addr = ioremap(0xf8070000, 0x1000);
>
> Eww.  You could just make a global instead of abusing existing fields,
> there can be only one CPC9x5 in a system anyway.

This was a copy-paste of corresponding PowerMac code. Do you really want
for me to change this to global variable?


BTW: I see a lot of code duplication between PowerMac and Maple pci.c
files. Would you like a patch that merges those files to something
like arch/powerpc/sysdev/u3-pci.c? I can try merging them...

-- 
With best wishes
Dmitry
