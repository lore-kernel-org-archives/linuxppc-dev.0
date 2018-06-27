Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Fqks4mMKzF158
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 14:32:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Joshua Thompson <funaho@jurai.org>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 y2038@lists.linaro.org, Meelis Roos <mroos@linux.ee>,
 Andreas Schwab <schwab@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
In-Reply-To: <20180619140229.3615110-1-arnd@arndb.de>
References: <20180619140229.3615110-1-arnd@arndb.de>
Date: Wed, 27 Jun 2018 14:32:17 +1000
Message-ID: <87y3f06e9a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> writes:

> As Mathieu pointed out, my conversion to time64_t was incorrect and resulted
> in negative times to be read from the RTC. The problem is that during the
> conversion from a byte array to a time64_t, the 'unsigned char' variable
> holding the top byte gets turned into a negative signed 32-bit integer
> before being assigned to the 64-bit variable for any times after 1972.
>
> This changes the logic to cast to an unsigned 32-bit number first for
> the Macintosh time and then convert that to the Unix time, which then gives
> us a time in the documented 1904..2040 year range. I decided not to use
> the longer 1970..2106 range that other drivers use, for consistency with
> the literal interpretation of the register, but that could be easily
> changed if we decide we want to support any Mac after 2040.
>
> Just to be on the safe side, I'm also adding a WARN_ON that will trigger
> if either the year 2040 has come and is observed by this driver, or we
> run into an RTC that got set back to a pre-1970 date for some reason
> (the two are indistinguishable).
>
> For the RTC write functions, Andreas found another problem: both
> pmu_request() and cuda_request() are varargs functions, so changing
> the type of the arguments passed into them from 32 bit to 64 bit
> breaks the API for the set_rtc_time functions. This changes it
> back to 32 bits.
>
> The same code exists in arch/m68k/ and is patched in an identical way now
> in a separate patch.
>
> Fixes: 5bfd643583b2 ("powerpc: use time64_t in read_persistent_clock")
> Reported-by: Mathieu Malaterre <malat@debian.org>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/platforms/powermac/time.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)

So I think I can take this patch in isolation via the powerpc tree as a
fix for 4.18.

I'll leave the other two alone.

cheers
