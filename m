Return-Path: <arndbergmann@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Vx7B32xSzF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 22:20:21 +1000 (AEST)
Received: by mail-lf0-x241.google.com with SMTP id m12-v6so3296144lfc.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 05:20:21 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
 <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
 <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Jul 2018 14:20:08 +0200
Message-ID: <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Joshua Thompson <funaho@jurai.org>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Meelis Roos <mroos@linux.ee>, Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2018 at 2:02 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 18 Jul 2018, Geert Uytterhoeven wrote:
>
>>
>> Thanks for your patch!
>>
>> Applied and queued for v4.19, with the WARN_ON() dropped.
>>
>
> The patch you've committed to your for-v4.19 branch has this hunk:
>
> @@ -269,8 +275,12 @@ static long via_read_time(void)
>                 via_pram_command(0x89, &result.cdata[1]);
>                 via_pram_command(0x8D, &result.cdata[0]);
>
> -               if (result.idata == last_result.idata)
> +               if (result.idata == last_result.idata) {
> +                       if (result.idata < RTC_OFFSET)
> +                               result.idata += 0x100000000ull;
> +
>                         return result.idata - RTC_OFFSET;
> +               }
>
>                 if (++count > 10)
>                         break;
>
> That looks bogus to me, since result.idata is a long.



> Also, the following hunk seems a bit pointless (?)
>
> @@ -291,11 +301,11 @@ static long via_read_time(void)
>   * is basically any machine with Mac II-style ADB.
>   */
>
> -static void via_write_time(long time)
> +static void via_write_time(time64_t time)
>  {
>         union {
>                 __u8 cdata[4];
> -               long idata;
> +               __u32 idata;
>         } data;
>         __u8 temp;
>
>
> But if data.idata needs to be changed to __u32 here, why not change the
> same struct member in via_read_time() also?

Hmm, apparently I forgot to update via_read_time(), that one
is indeed bogus and now inconsistent with the other functions.

The change in via_write_time() seems at least consistent wtih
what we do elsewhere, and using __u32 makes this code
more portable. (yes, I realize that 64-bit powermac doesn't
use the VIA RTC, but it feels better to write code portably
anyway).

I'd suggest we do it like below to make it consistent with the
rest again, using the 1904..2040 range of dates and no warning
for invalid dates.

If you agree, I'll send that as a proper patch.

       Arnd

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index bf8df47a6d09..8335509969f1 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -255,12 +255,13 @@ static void via_write_pram(int offset, __u8 data)
  * is basically any machine with Mac II-style ADB.
  */

-static long via_read_time(void)
+static time64_t via_read_time(void)
 {
        union {
                __u8 cdata[4];
-               long idata;
+               __u32 idata;
        } result, last_result;
+       time64_t ret;
        int count = 1;

        via_pram_command(0x81, &last_result.cdata[3]);
@@ -279,12 +280,8 @@ static long via_read_time(void)
                via_pram_command(0x89, &result.cdata[1]);
                via_pram_command(0x8D, &result.cdata[0]);

-               if (result.idata == last_result.idata) {
-                       if (result.idata < RTC_OFFSET)
-                               result.idata += 0x100000000ull;
-
-                       return result.idata - RTC_OFFSET;
-               }
+               if (result.idata == last_result.idata)
+                       return (time64_t(result.idata) - RTC_OFFSET);

                if (++count > 10)
                        break;
