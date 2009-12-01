Return-Path: <aciddeath@gmail.com>
Received: from mail-pz0-f172.google.com (mail-pz0-f172.google.com
	[209.85.222.172]) by ozlabs.org (Postfix) with ESMTP id AB242B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 18:43:59 +1100 (EST)
Received: by pzk2 with SMTP id 2so3221500pzk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Nov 2009 23:43:57 -0800 (PST)
Subject: Re: [RFC PATCH v3 3/3] powerpc: gamecube/wii: early debugging using
	usbgecko
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Richard Holden <aciddeath@gmail.com>
In-Reply-To: <4B14A834.4070907@yahoo.es>
Date: Tue, 1 Dec 2009 00:43:56 -0700
Message-Id: <40854686-7CD0-432D-B31C-0D5DF2DADBF9@gmail.com>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
	<86935119c483c2d6e4c810c0afd079e049443b18.1259609263.git.albert_herranz@yahoo.es>
	<4B147086.6070602@gmail.com> <4B14A834.4070907@yahoo.es>
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 30, 2009, at 10:23 PM, Albert Herranz wrote:

> Richard Holden wrote:
>> Albert Herranz wrote:
> The first patch is generic, and uses PPC_EARLY_DEBUG.
> This is the first patch where PPC_EARLY_DEBUG_USBGECKO is referenced.

Sorry, you are correct.

>>> diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c =
b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
>>> index ba4c7cc..3f125b6 100644
>>> --- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
>>> +++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
>>> @@ -17,6 +17,7 @@
>>> #include <asm/io.h>
>>> #include <asm/prom.h>
>>> #include <asm/udbg.h>
>>> +#include <asm/fixmap.h>
>>>=20
>>> #include "usbgecko_udbg.h"
>>>=20
>>> @@ -270,3 +271,61 @@ done:
>>> 		of_node_put(np);
>>> 	return;
>>> }
>>> +
>>> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
>>> +
>>> +static void __init ug_early_remap(void)
>>=20
>> you may want to rename the ug_ prefix, it took me a while looking =
back
>> and forth through the patch to convince myself it wasn't a typo.
>>=20
>=20
> What's wrong with ug_ ? (ug =3D (u)sb(g)ecko)
>=20

At first look I thought it was a typo of udbg_early_remap. I prefer the =
longer names although we could use gecko_early_remap unless the gecko =
prefix conflicts with anything else. If there is not going to be a non =
usb gecko then there is no need to have usb in the prefix.

-Richard Holden=
