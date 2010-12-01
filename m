Return-Path: <jhautbois@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id B269CB708B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Dec 2010 02:15:21 +1100 (EST)
Received: by wwd20 with SMTP id 20so2947255wwd.21
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Dec 2010 07:15:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
References: <1291215130.4881.55.camel@gandalf.stny.rr.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
Date: Wed, 1 Dec 2010 16:15:18 +0100
Message-ID: <AANLkTik3LFf3qVv7STm+z-ahd+uqxeyA1+b5-D6Zj+tT@mail.gmail.com>
Subject: Re: [MPC52xx]Latency issue with DMA on FEC
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Eric Dumazet <eric.dumazet@gmail.com>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/12/1 David Laight <David.Laight@aculab.com>:
>
>> A mb() is usually used if you do a write to device and read from it.
>> With out it, the CPU could perform the read before the write, which
>> would give you an incorrect result. There's no other way around that.
>
> Possibly the synchronisation functions are doing significantly
> more work than is required.
>
> I was looking at the in_le32() and out_le32() functions for the
> ppc e300 (and maybe others).
>
> The out_le32() contains a 'sync' instruction - this may only
> be needed after a series of writes (eg just before a command).
>
> The iosync() function just adds a 'sync' and can be used as needed.
>
> The in_le32() not only contains the unwanted 'sync', but also
> a 'twi' (trap immediate - NFI exactly what this does) and 'isync'.
> The 'isync' is particularly horrid and unnecessary (aborts
> the instruction queue and refeches the opcode bytes).
>
> The very slow in_le32() might be there to give semi-synchronous
> traps on address fault - but unless the hardware is being probed
> that really isn't necessary.
>
> I did find st_le32() and ld_le32() in arch/powerpc/include/asm/swab.h
> but had difficulty #including that version of swab.h!
> =C2=A0 =C2=A0#include <../arch/powerpc/include/asm/swab.h>
> worked - but isn't that nice.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0David

Yes, I was also looking at in_be16 and out_be16, and my thoughts were
exactly the same.
I think the HW I am using is not a good one, but this is not
sufficient to explain the behaviour.
These instructions are called, for instance, from bcom_enable_task().
