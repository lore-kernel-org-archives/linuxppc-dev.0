Return-Path: <albert_herranz@yahoo.es>
Received: from smtp124.mail.ukl.yahoo.com (smtp124.mail.ukl.yahoo.com
	[77.238.184.55]) by ozlabs.org (Postfix) with SMTP id 31469B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 05:19:53 +1100 (EST)
Message-ID: <4B0C23C8.7040905@yahoo.es>
Date: Tue, 24 Nov 2009 19:19:52 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 10/19] powerpc: gamecube/wii: early debugging using
	usbgecko
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<A07AD196-D33F-477C-B53C-AB05BA236FEC@kernel.crashing.org>
In-Reply-To: <A07AD196-D33F-477C-B53C-AB05BA236FEC@kernel.crashing.org>
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

Segher Boessenkool wrote:
> You set up DBAT1 here...
> 
>> +setup_usbgecko_bat:
>> +    /* prepare a BAT for early io */
>> +    lis    r8, 0x0c00
>> +    ori    r8, r8, 0x002a    /* uncached, guarded ,rw */
>> +    lis    r11, 0xcc00
>> +    ori    r11, r11, 0x3    /* 128K */
>> +#ifdef CONFIG_WII
>> +    oris    r8, r8, 0x0100
>> +    oris    r11, r11, 0x0100
>> +#endif
>> +    mtspr    SPRN_DBAT1L, r8
>> +    mtspr    SPRN_DBAT1U, r11
>> +    sync
>> +    isync
>> +    blr
> 
> ... and again here:
> 
>> +void __init udbg_init_usbgecko(void)
>> +{
>> +    unsigned long vaddr, paddr;
>> +
>> +#if defined(CONFIG_GAMECUBE)
>> +    paddr = 0x0c000000;
>> +#elif defined(CONFIG_WII)
>> +    paddr = 0x0d000000;
>> +#else
>> +#error Invalid platform for USB Gecko based early debugging.
>> +#endif
>> +
>> +    vaddr = 0xc0000000 | paddr;
>> +    setbat(1, vaddr, paddr, 128*1024, PAGE_KERNEL_NCG);
> 
> Do you need to do it twice?
> 

Uhmm... I need to re-check it.
IIRC the BATs were re-initialized in between. But I'm not sure now :)

>> +    ug_io_base = (void __iomem *)(vaddr | 0x6814);
> 
> Oh, hardcoded slot2, now i'm confused which one should be it :-)
> 

early udbg  : hardcoded to mem2 slot
normal udbg : as specified in device tree

Clearer now ? ;)

Thanks for the review!
Albert
