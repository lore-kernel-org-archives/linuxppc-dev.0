Return-Path: <albert_herranz@yahoo.es>
Received: from smtp109.mail.ukl.yahoo.com (smtp109.mail.ukl.yahoo.com
	[77.238.184.32]) by ozlabs.org (Postfix) with SMTP id 186D1B7BEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Dec 2009 03:54:12 +1100 (EST)
Message-ID: <4B193EAD.2040303@yahoo.es>
Date: Fri, 04 Dec 2009 17:54:05 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH v4 2/2] powerpc: gamecube/wii: early debugging using
	usbgecko
References: <cover.1259871725.git.albert_herranz@yahoo.es>
	<4f4baca1cd65f7949610ca901c9a8bcb1bb74cfd.1259871725.git.albert_herranz@yahoo.es>
	<364F1867-9601-44FD-B140-EAA0FCC2C237@kernel.crashing.org>
In-Reply-To: <364F1867-9601-44FD-B140-EAA0FCC2C237@kernel.crashing.org>
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
>> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
>> +setup_usbgecko_bat:
>> +    /* prepare a BAT for early io */
>> +#if defined(CONFIG_GAMECUBE)
>> +    lis    r8, 0x0c00
>> +#elif defined(CONFIG_WII)
>> +    lis    r8, 0x0d00
>> +#else
>> +#error Invalid platform for USB Gecko based early debugging.
>> +#endif
> 
> A kernel with both CONFIG_WII and CONFIG_GAMECUBE works fine
> on either, right?  If so, could you please switch the two #ifs?
> A dual-platform kernel will be used on a Wii much more likely
> than on a GC.
> 

Nope, a GameCube kernel currently doesn't work on a Wii and the same the other way around.

But I can make that particular check a runtime check.
The idea would be to enclose that snippet in GAMECUBE_COMMON and check the PVR. If it is a Gekko (a fixed value) then we have a GameCube, otherwise we assume a Wii.

>> +    /*
>> +     * The virtual address used must match the virtual address
>> +     * associated to the fixmap entry FIX_EARLY_DEBUG_BASE.
>> +     */
>> +    lis    r11, 0xfffe    /* top 128K */
>> +    ori    r8, r8, 0x002a    /* uncached, guarded ,rw */
>> +    ori    r11, r11, 0x3    /* 128K */
> 
> I think you should clear Vp since the BAT mapping can survive until
> after user space is started; it won't hurt to remove it either way.
> So 2 instead of 3.  And put the meaning in the comment :-)

This BAT is re-setup again on MMU_init, way before starting userspace.
But I'll make it Vs=1, Vp=0 here too :)

> 
> Looks fine otherwise.
> 

Thanks.

> 
> Segher
> 
> 

Cheers,
Albert
