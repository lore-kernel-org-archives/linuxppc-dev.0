Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 41VwkM2bKszF3Hq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 22:02:18 +1000 (AEST)
Date: Wed, 18 Jul 2018 22:02:15 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Joshua Thompson <funaho@jurai.org>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Meelis Roos <mroos@linux.ee>,
 Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
In-Reply-To: <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
 <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
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

On Wed, 18 Jul 2018, Geert Uytterhoeven wrote:

> 
> Thanks for your patch!
> 
> Applied and queued for v4.19, with the WARN_ON() dropped.
> 

The patch you've committed to your for-v4.19 branch has this hunk:

@@ -269,8 +275,12 @@ static long via_read_time(void)
                via_pram_command(0x89, &result.cdata[1]);
                via_pram_command(0x8D, &result.cdata[0]);
 
-               if (result.idata == last_result.idata)
+               if (result.idata == last_result.idata) {
+                       if (result.idata < RTC_OFFSET)
+                               result.idata += 0x100000000ull;
+
                        return result.idata - RTC_OFFSET;
+               }
 
                if (++count > 10)
                        break;

That looks bogus to me, since result.idata is a long.

Also, the following hunk seems a bit pointless (?)

@@ -291,11 +301,11 @@ static long via_read_time(void)
  * is basically any machine with Mac II-style ADB.
  */
 
-static void via_write_time(long time)
+static void via_write_time(time64_t time)
 {
        union {
                __u8 cdata[4];
-               long idata;
+               __u32 idata;
        } data;
        __u8 temp;
 

But if data.idata needs to be changed to __u32 here, why not change the 
same struct member in via_read_time() also?

-- 
