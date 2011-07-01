Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6A7FB6F5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Jul 2011 02:41:06 +1000 (EST)
In-Reply-To: <1309357060-20872-1-git-send-email-dbaryshkov@gmail.com>
References: <1309357060-20872-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F4E7EABC-B63F-4776-A8EB-8C93F64C2A3C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: enable access to HT Host-Bridge on Maple
Date: Fri, 1 Jul 2011 18:44:44 +0200
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> CPC925/CPC945 use special window to access host bridge  
> functionality of
> u3-ht. Provide a way to access this device.

Why?  Is anything going to use it?

> +static int u3_ht_root_read_config(struct pci_controller *hose, u8  
> offset,
> +				  int len, u32 *val)
> +{
> +	volatile void __iomem *addr;
> +
> +	addr = hose->cfg_addr;
> +	addr += ((offset & ~3) << 2) + (4 - len - (offset & 3));

This will only work for len 1,2,4 with offset a multiple of len, is that
guaranteed here?

> +static int u3_ht_root_write_config(struct pci_controller *hose, u8  
> offset,
> +				  int len, u32 val)
> +{
> +	volatile void __iomem *addr;
> +
> +	addr = hose->cfg_addr + ((offset & ~3) << 2) + (4 - len - (offset  
> & 3));
> +
> +	if (offset >= PCI_BASE_ADDRESS_0 && offset < PCI_CAPABILITY_LIST)
> +		return PCIBIOS_SUCCESSFUL;

This is a workaround for something; at the very least it needs a  
comment,
but probably it shouldn't be here at all.

>  static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
>  			     int offset, int len, u32 *val)
>  {
> @@ -217,6 +265,9 @@ static int u3_ht_read_config(struct pci_bus  
> *bus, unsigned int devfn,
>  	if (hose == NULL)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>
> +	if (bus->number == hose->first_busno && devfn == PCI_DEVFN(0, 0))
> +		return u3_ht_root_read_config(hose, offset, len, val);
> +
>  	if (offset > 0xff)
>  		return PCIBIOS_BAD_REGISTER_NUMBER;

u3_ht_root_read_config() can get an offset out of range this way.

>  	hose->cfg_data = ioremap(0xf2000000, 0x02000000);
> +	hose->cfg_addr = ioremap(0xf8070000, 0x1000);

Eww.  You could just make a global instead of abusing existing fields,
there can be only one CPC9x5 in a system anyway.


Segher
