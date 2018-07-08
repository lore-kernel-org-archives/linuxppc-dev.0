Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 41Nmp5467LzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jul 2018 21:44:13 +1000 (AEST)
Date: Sun, 8 Jul 2018 21:45:21 +1000 (AEST)
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
In-Reply-To: <CAMuHMdWzO1jzd=8SN5G_eoFObEAJR4-5u7JDExMefR__30QauA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807082133130.49@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
 <alpine.LNX.2.21.1806221455570.14@nippy.intranet>
 <CAK8P3a2chXVhz+UJ+ujg8QMqyMmJ4zGj9XKuFZ+MsJ=dGqb3eg@mail.gmail.com>
 <CAMuHMdWzO1jzd=8SN5G_eoFObEAJR4-5u7JDExMefR__30QauA@mail.gmail.com>
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

On Sun, 8 Jul 2018, Geert Uytterhoeven wrote:

> On Fri, Jun 22, 2018 at 10:55 AM Arnd Bergmann <arnd@arndb.de> wrote:

> > I don't think anyone so far had a strong preference here, so I went 
> > with what Mathieu suggested and kept the original Mac behavior, but 
> > added the WARN_ON().
> 
> So, is this safe to apply?
> Especially in light of the warnings seen by Meelis with the PPC version.
> 

You mean, "can we apply this and avoid warning splats?"

Meelis's result says, "no".

I forget what date the RTC gets set to when the PMU/Cuda is reset but I 
suspect that timezone arithmetic in either MacOS or Linux could cause it 
to end up in 1969.

So I'd prefer to see the WARN_ON() removed.

-- 
