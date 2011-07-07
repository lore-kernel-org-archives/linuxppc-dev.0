Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A561CB6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Jul 2011 08:49:04 +1000 (EST)
Subject: Re: [PATCH] powerpc: enable access to HT Host-Bridge on Maple
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <F4E7EABC-B63F-4776-A8EB-8C93F64C2A3C@kernel.crashing.org>
References: <1309357060-20872-1-git-send-email-dbaryshkov@gmail.com>
	<F4E7EABC-B63F-4776-A8EB-8C93F64C2A3C@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Jul 2011 08:48:53 +1000
Message-ID: <1310078933.14501.308.camel@pasglop>
Mime-Version: 1.0
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-07-01 at 18:44 +0200, Segher Boessenkool wrote:
> > CPC925/CPC945 use special window to access host bridge  
> > functionality of
> > u3-ht. Provide a way to access this device.
> 
> Why?  Is anything going to use it?
> 
> > +static int u3_ht_root_read_config(struct pci_controller *hose, u8  
> > offset,
> > +				  int len, u32 *val)
> > +{
> > +	volatile void __iomem *addr;
> > +
> > +	addr = hose->cfg_addr;
> > +	addr += ((offset & ~3) << 2) + (4 - len - (offset & 3));
> 
> This will only work for len 1,2,4 with offset a multiple of len, is that
> guaranteed here?

I think the upper layer does. Dbl check tho.

> >  	hose->cfg_data = ioremap(0xf2000000, 0x02000000);
> > +	hose->cfg_addr = ioremap(0xf8070000, 0x1000);
> 
> Eww.  You could just make a global instead of abusing existing fields,
> there can be only one CPC9x5 in a system anyway.

Nah, that's fine, we abuse it that way regulary :-)

Cheers,
Ben.
