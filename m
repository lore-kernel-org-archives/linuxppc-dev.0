Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E94462C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 09:55:23 +1000 (EST)
Date: Mon, 24 Sep 2012 18:55:09 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Probing for native availability of isel from userspace
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <35A5B006-1E4E-4355-A6A4-CA5F7371D21C@kernel.crashing.org>
 (from segher@kernel.crashing.org on Sat Sep 22 20:46:06 2012)
Message-ID: <1348530909.25867.29@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: malc <av1474@comtv.ru>, linuxppc-dev@lists.ozlabs.org,
 hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/22/2012 08:46:06 PM, Segher Boessenkool wrote:
>>> Have a look at /sys/kernel/debug/powerpc/emulated_instructions/ =20
>>> then?
>>=20
>> Userspace should *NEVER* rely on the content of debugfs, it will =20
>> change
>> with time, it is not a guaranteed ABI, it's purely for people to look
>> at... for debugging.
>=20
> malc didn't say what he wants it for...  People are in userspace as
> well ;-)
>=20
>> At this stage I would recommend using arch 2.06 as your key/trigger =20
>> and
>> either add a handful of known PVR values (mfpvr is emulated) for =20
>> other
>> CPUs you know support it (there shouldn't be that many), or just do =20
>> the
>> heuristic :-(

The ISA says that isel is "Category: Phased-In (sV2.06)" -- are there =20
any 2.06 chips that don't have it?

> That's for 64-bit; another good option for 64-bit is to just never use
> isel, it hardly ever buys you anything.  It is much more useful on the
> (older) 32-bit cores that support it.

Why is it more useful on 32-bit?  If you're referring to the =20
performance of specific cores rather than some architectural thing, =20
maybe that's true with some chips, but on the Freescale side I'd be =20
surprised if e5500 were much different from e500v2 in that regard.

-Scott=
