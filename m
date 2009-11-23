Return-Path: <albert_herranz@yahoo.es>
Received: from smtp134.mail.ukl.yahoo.com (smtp134.mail.ukl.yahoo.com
	[77.238.184.65]) by ozlabs.org (Postfix) with SMTP id 87138B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 06:10:58 +1100 (EST)
Message-ID: <4B0ADE3F.1070604@yahoo.es>
Date: Mon, 23 Nov 2009 20:10:55 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 10/19] powerpc: gamecube/wii: early debugging using
	usbgecko
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<200911222327.37949.arnd@arndb.de>
In-Reply-To: <200911222327.37949.arnd@arndb.de>
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

Arnd Bergmann wrote:
> On Sunday 22 November 2009, Albert Herranz wrote:
>> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
>> +setup_usbgecko_bat:
>> +	/* prepare a BAT for early io */
>> +	lis	r8, 0x0c00
>> +	ori	r8, r8, 0x002a	/* uncached, guarded ,rw */
>> +	lis	r11, 0xcc00
>> +	ori	r11, r11, 0x3	/* 128K */
>> +#ifdef CONFIG_WII
>> +	oris	r8, r8, 0x0100
>> +	oris	r11, r11, 0x0100
>> +#endif
>> +	mtspr	SPRN_DBAT1L, r8
>> +	mtspr	SPRN_DBAT1U, r11
>> +	sync
>> +	isync
>> +	blr
>> +#endif
> 
> This will probably break other platforms if CONFIG_PPC_EARLY_DEBUG_USBGECKO
> is set. In general, we try hard to make it possible to build generic
> kernels for multiple systems, so it would be better to also add a runtime
> check here.
> 

Ok, I see the point.
But, what makes CONFIG_PPC_EARLY_DEBUG_USBGECKO case different from CONFIG_PPC_EARLY_DEBUG_CPM case here?

>> --- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
>> +++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
>> @@ -27,4 +27,10 @@ static inline void __init ug_udbg_init(void)
>>  
>>  #endif /* CONFIG_USBGECKO_UDBG */
>>  
>> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
>> +
>> +void __init udbg_init_usbgecko(void);
>> +
>> +#endif /* CONFIG_PPC_EARLY_DEBUG_USBGECKO */
>> +
> 
> No need to enclose a declaration in #ifdef, better leave it there
> unconditionally, unless you have an alternative version, like
> 
> #ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
> void __init udbg_init_usbgecko(void);
> #else /* !CONFIG_PPC_EARLY_DEBUG_USBGECKO */
> static inline void udbg_init_usbgecko(void)
> {
> }
> #endif /* CONFIG_PPC_EARLY_DEBUG_USBGECKO */
> 
> That style is now more common than having additional #ifdefs
> in the code using the function.

I'll fix that too. Thanks.

Cheers,
Albert
