Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 41Vz5z6bGDzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 23:49:27 +1000 (AEST)
Date: Wed, 18 Jul 2018 23:49:20 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Joshua Thompson <funaho@jurai.org>, Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Meelis Roos <mroos@linux.ee>,
 Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
In-Reply-To: <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807182333150.41@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
 <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
 <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
 <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Jul 2018, Arnd Bergmann wrote:

> Hmm, apparently I forgot to update via_read_time(), that one
> is indeed bogus and now inconsistent with the other functions.
> 
> The change in via_write_time() seems at least consistent wtih what we do 
> elsewhere, and using __u32 makes this code more portable. (yes, I 
> realize that 64-bit powermac doesn't use the VIA RTC, but it feels 
> better to write code portably anyway).
> 

As for portability, I think you just contradicted yourself. But I take 
your point about consistency. So I won't object to adopting __u32.

> I'd suggest we do it like below to make it consistent with the
> rest again, using the 1904..2040 range of dates and no warning
> for invalid dates.
> 
> If you agree, I'll send that as a proper patch.
> 

Geert may instead wish to fixup or revert the patch he has committed 
already...

>        Arnd
> 
> diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
> index bf8df47a6d09..8335509969f1 100644
> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -255,12 +255,13 @@ static void via_write_pram(int offset, __u8 data)
>   * is basically any machine with Mac II-style ADB.
>   */
> 
> -static long via_read_time(void)
> +static time64_t via_read_time(void)
>  {
>         union {
>                 __u8 cdata[4];
> -               long idata;
> +               __u32 idata;
>         } result, last_result;
> +       time64_t ret;

ret isn't used.

>         int count = 1;
> 
>         via_pram_command(0x81, &last_result.cdata[3]);
> @@ -279,12 +280,8 @@ static long via_read_time(void)
>                 via_pram_command(0x89, &result.cdata[1]);
>                 via_pram_command(0x8D, &result.cdata[0]);
> 
> -               if (result.idata == last_result.idata) {
> -                       if (result.idata < RTC_OFFSET)
> -                               result.idata += 0x100000000ull;
> -
> -                       return result.idata - RTC_OFFSET;
> -               }
> +               if (result.idata == last_result.idata)
> +                       return (time64_t(result.idata) - RTC_OFFSET);
> 

Did you mean to write,

			return (time64_t)result.idata - RTC_OFFSET;

?

-- 
