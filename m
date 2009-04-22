Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F072DDFDD
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 08:09:28 +1000 (EST)
Message-Id: <80EA9B57-158A-4BA9-B068-18B6BA9D32B4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <49EF92E6.4090301@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: removing get_immrbase()??
Date: Wed, 22 Apr 2009 17:07:20 -0500
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8D42.7010104@freescale.com>
	<DC91BA72-AF10-41DD-B610-EDEFD106A811@kernel.crashing.org>
	<49EF9019.7000102@freescale.com>
	<C86B0B8A-C031-4F4C-AF79-58D77ED6EA2F@kernel.crashing.org>
	<49EF92E6.4090301@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 22, 2009, at 4:57 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> New nodes.  For example I've proposed a "local access window" node.
>> Once I add it I plan on changing code to use it.  This will break an
>> old device tree booting with the new kernel and I'm completely ok  
>> with
>> that.
>
> Are we having two different conversations?  I was talking about this
> block from your email:
>
>>> arch/powerpc/include/asm/cpm2.h:#define CPM_MAP_ADDR  
>>> (get_immrbase() +
>>> 0x80000)
>>> arch/powerpc/sysdev/cpm2.c:     cpm2_immr = ioremap(get_immrbase(),
>>> CPM_MAP_SIZE);
>>>       these two are related and seem like we could look for  
>>> "fsl,cpm2"
>>
>> That's okay, as long as you don't break compatibility with older
>> device trees that don't have that property, unless you can  
>> demonstrate
>> that these trees would never work with the current kernel anyway.
>
> Specifically, I was referring to this comment:
> 	
> 	these two are related and seem like we could look for "fsl,cpm2"
>
> And my point was that not all device trees have "fsl,cpm2" in their  
> CPM
> nodes.

Yes -- we are having two different conversations.  I've moved on from  
the specific issue of "fsl,cpm2" not existing in old device trees.   
I've moved to a more general statement about how I can solve some of  
the CPM2 related uses of cpm2_immr.  For example we assign cpmp based  
on cpm2_immr.  I could stop using cpm2_immr and solve this problem by  
adding a new device node for the comm-proc registers in the device  
trees at which point I'd break older .dts working with the kernel.

- k
