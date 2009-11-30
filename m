Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id 204CD1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Nov 2009 17:28:56 +1100 (EST)
Message-ID: <4B136624.4030505@yahoo.es>
Date: Mon, 30 Nov 2009 07:28:52 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 08/11] powerpc: gamecube/wii: early debugging using
	usbgecko
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>	
	<1259441037-15725-9-git-send-email-albert_herranz@yahoo.es>	
	<1259536695.2076.40.camel@pasglop> <4B135D3D.9030006@yahoo.es>
	<1259561692.2076.78.camel@pasglop>
In-Reply-To: <1259561692.2076.78.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2009-11-30 at 06:50 +0100, Albert Herranz wrote:
>> Benjamin Herrenschmidt wrote:
>>> On Sat, 2009-11-28 at 21:43 +0100, Albert Herranz wrote:
>>>> +        * Prepare again the same BAT for MMU_init.
>>>> +        * This allows udbg I/O to continue working after the MMU is
>>>> +        * turned on for real.
>>>> +        *
>>>> +        * We are assuming here that exi_io_base is identity mapped.
>>>> +        */
>>>> +       addr = ((unsigned long)exi_io_base) & 0xffff0000;
>>>> +       setbat(1, addr, addr, 128*1024, PAGE_KERNEL_NCG); 
>>> How do you prevent that from overlapping otherwise valid kernel
>>> mappings ?
>>>
>> ug_udbg_init() is called from ppc_md.init_early.
>> It doesn't overlap any valid kernel mappings because exi_io_base is
>> hardcoded to an i/o region not used yet by the kernel.
> 
> But that doesn't allocate virtual space does it ?
> 

No.

>> See udbg_early_grab_exi_io_base().
> 
> Yeah, I see that:
> 
> +#if defined(CONFIG_GAMECUBE)
> +       return (void __iomem *)0x0c006800;
> +#elif defined(CONFIG_WII)
> +       return (void __iomem *)0x0d006800;
> +#else
> 
> So you'll have BATs floating over user addresses ? That sounds fishy :-)
> 

Heh, I was told to identity map it :)
Originally it used kernel address space (0xc{c,d}006800).

> It should be trivial to just create a fixmap entry instead. That will
> give you a virtual address that is known at compile time (so you can
> use it from head_32.S as well for setting up your BAT).
> 
> Actually you probably need more than one entry in there since it needs
> to be big enough to cover a BAT min size and be aligned, but it's not
> -that- hard to do (I think x86 does similar tricks in their fixmap
> iirc) 
> 

I've never worked with fixmap entries. I'll look into it. Thanks.

>> The setbat just prepares again, exactly in the same way, the same BAT that we got
>> setup by setup_usbgecko_bat in head_32.S.
> 
>  .../...
> 
>>> You need to allocate the virtual space. For a debug thing like that, you
>>> could use the fixmap. In fact, I think we should create a fixmap entry
>>> or two always available for use by early debug.
>>>
>> Or give us back ppc_md.setup_io_mappings :)
> 
> Not happening :-) Or if you get one, it will allocate virtual addresses
> and so you cannot rely on an identity mapping.
> 

But we can use then a known mapping scheme, and have all the i/o region covered by bats there.
We can do that already, yes, but setup_io_mappings purpose was originally that, no?

Thanks,
Albert
