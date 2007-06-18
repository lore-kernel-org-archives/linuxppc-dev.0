Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED9ECDDEEA
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 22:52:24 +1000 (EST)
In-Reply-To: <fbae4506b772f07d2a8c1d230bea82c8@bga.com>
References: <111819314606b8b45671.846930886.miltonm@bga.com>
	<4672EE95.3030407@freescale.com>
	<fbae4506b772f07d2a8c1d230bea82c8@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bfbd4f126c427f590198a3e50a789b0c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] boot: find initrd location from device-tree
Date: Mon, 18 Jun 2007 14:52:12 +0200
To: Milton Miller <miltonm@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +     /* if the initrd is above 4G, its untouchable in 32 bit mode */
>>> +     if (initrd_end <= UINT_MAX && initrd_start < initrd_end) {
>>> +             loader_info.initrd_addr = initrd_start;
>>> +             loader_info.initrd_size  = initrd_end - initrd_start;
>>> +     } else {
>>> +             printf("ignoring loader supplied initrd parameters\n");
>>
>> Saying why might be helpful.
>
> Hmm... well, that would mean seperating the && of the if; there are two
> possible reasons. (1) this 32-bit code can't handle such large
> addresses (in which case a 64-bit kernel may work), and (2) end is >=
> start (which means there really isn't any data.  I suppose I could
> reverse the sense of the if, use an else if, and make the final else
> the good path.

"ignoring loader supplied nonsensical initrd parameters"

You do need to fix the comment, though :-)

>>> +#define _LIBC_LIMITS_H_              /* don't recurse to system's
>> headers */
>>> +#include <limits.h>          /* MAX_UINT, etc */
>>> +
>>
>> I think it's really a bad idea to use any headers from outside the
>> boot context here.  We're dealing with explicit sized ints, so we can
>> safely define our own constants giving the limit values.
>
> As I said in the patch changelog, the only headers picked up here are
> libgcc.

Which the kernel doesn't use.  It _should_ be fine
nevertheless, <limits.h> is part of the "freestanding"
headers -- why do you need to do a "libc" trick though?
This doesn't work when not using glibc I guess?


Segher
