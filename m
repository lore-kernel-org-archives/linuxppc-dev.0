Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GGZC3Gx5zF1Dg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 07:41:23 +1000 (AEST)
In-Reply-To: <20180619140229.3615110-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Joshua Thompson <funaho@jurai.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Mathieu Malaterre <malat@debian.org>,
 Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
 y2038@lists.linaro.org, linux-m68k@lists.linux-m68k.org,
 Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [1/3,v2] powerpc: mac: fix rtc read/write functions
Message-Id: <41GGZC26Lyz9s1R@ozlabs.org>
Date: Thu, 28 Jun 2018 07:41:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-06-19 at 14:02:27 UTC, Arnd Bergmann wrote:
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
> Tested-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/22db552b50fa11d8c1d171de908a1f

cheers
