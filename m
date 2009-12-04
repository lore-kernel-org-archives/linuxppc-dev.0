Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1D18B7BF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Dec 2009 06:56:53 +1100 (EST)
Message-ID: <55140.84.105.60.153.1259956601.squirrel@gate.crashing.org>
In-Reply-To: <4B193EAD.2040303@yahoo.es>
References: <cover.1259871725.git.albert_herranz@yahoo.es>
	<4f4baca1cd65f7949610ca901c9a8bcb1bb74cfd.1259871725.git.albert_herranz@yahoo.es>
	<364F1867-9601-44FD-B140-EAA0FCC2C237@kernel.crashing.org>
	<4B193EAD.2040303@yahoo.es>
Date: Fri, 4 Dec 2009 20:56:41 +0100 (CET)
Subject: Re: [RFC PATCH v4 2/2] powerpc: gamecube/wii: early debugging
	using usbgecko
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Albert Herranz" <albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
>>> +setup_usbgecko_bat:
>>> +    /* prepare a BAT for early io */
>>> +#if defined(CONFIG_GAMECUBE)
>>> +    lis    r8, 0x0c00
>>> +#elif defined(CONFIG_WII)
>>> +    lis    r8, 0x0d00
>>> +#else
>>> +#error Invalid platform for USB Gecko based early debugging.
>>> +#endif
>>
>> A kernel with both CONFIG_WII and CONFIG_GAMECUBE works fine
>> on either, right?  If so, could you please switch the two #ifs?
>> A dual-platform kernel will be used on a Wii much more likely
>> than on a GC.
>
> Nope, a GameCube kernel currently doesn't work on a Wii and the same the
> other way around.

What is the problem, just the wrappers?

> But I can make that particular check a runtime check.

Nah, don't bother, this is just early debug stuff.

> The idea would be to enclose that snippet in GAMECUBE_COMMON and check the
> PVR.

Ugly!


Segher
