Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 41Pknq0qzqzDr2J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 11:17:18 +1000 (AEST)
Date: Tue, 10 Jul 2018 11:18:34 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>
cc: Meelis Roos <mroos@linux.ee>, Mathieu Malaterre <malat@debian.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
In-Reply-To: <CAK8P3a29rNtWCcgKeJK57C5CPPi74wc1o1cnPJM=Qe+eMKFYjw@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807101105130.12@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <CA+7wUsyN_gru4rW0y3ZzXzYwhfaA=uHKaOG=z5bprnYq6oVfMg@mail.gmail.com>
 <alpine.LRH.2.21.1807011844470.19761@math.ut.ee>
 <CAK8P3a29rNtWCcgKeJK57C5CPPi74wc1o1cnPJM=Qe+eMKFYjw@mail.gmail.com>
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

On Mon, 9 Jul 2018, Arnd Bergmann wrote:

> 
> The most likely explanation I have here is that the RTC was indeed set 
> to an incorrect date, either because of a depleted battery (not unlikely 
> for a ~15 year old box) or because it was previously stored incorrectly.

The PowerMac stores the GMT offset in NVRAM, and this gets used to 
initialize timezone_offset.

If timezone_offset was negative and now.tv_sec was zero, I think this 
could store a 1969 date in the RTC:

int update_persistent_clock64(struct timespec64 now)
{
        struct rtc_time tm;

        if (!ppc_md.set_rtc_time)
                return -ENODEV;

        rtc_time64_to_tm(now.tv_sec + 1 + timezone_offset, &tm);

        return ppc_md.set_rtc_time(&tm);
}

But maybe now.tv_sec can be shown to be greater than timezone_offset.

Then, what would happen when the timezone in /etc/localtime disagrees with 
the timezone_offset stored in NVRAM (PRAM)?

Besides that, if the battery went flat, what use is a backtrace? Why not 
scrap the WARN_ON()?

-- 
