Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x234.google.com (mail-ob0-x234.google.com
 [IPv6:2607:f8b0:4003:c01::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA09B1A09F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 17:34:13 +1000 (AEST)
Received: by obdbs4 with SMTP id bs4so22819664obd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2015 00:34:11 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1435702685.24693.3.camel@ellerman.id.au>
References: <alpine.DEB.2.10.1505192206580.28384@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1506221321340.27145@digraph.polyomino.org.uk>
 <1435634913.24866.1.camel@ellerman.id.au>
 <alpine.DEB.2.10.1506301042250.2339@digraph.polyomino.org.uk>
 <1435702685.24693.3.camel@ellerman.id.au>
Date: Wed, 1 Jul 2015 09:34:11 +0200
Message-ID: <CAMuHMdV+t0OVYq=VFydRCq6+94E89Rt8AupZApZgCNqZ6mGJSw@mail.gmail.com>
Subject: Re: [PATCH RESEND] Update kernel math-emu code from current glibc
 soft-fp
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Joseph Myers <joseph@codesourcery.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 "David S.Miller" <davem@davemloft.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 1, 2015 at 12:18 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Tue, 2015-06-30 at 10:48 +0000, Joseph Myers wrote:
>> On Tue, 30 Jun 2015, Michael Ellerman wrote:
>>
>> > Is there some way you can imagine of splitting this up into smaller chunks, so
>> > that different arches can merge the pieces separately?
>>
>> Well, it could be split as:
>>
>> 1. Rename include/math-emu to math-emu-old and update architectures for
>> the renaming (mechanically).
>>
>> 2. Add new include/math-emu.
>>
>> 3,4,5,6,7. Move each architecture from math-emu-old to math-emu.
>>
>> 8. Remove math-emu-old.
>>
>> You still have patch 1 affecting all five architectures, but with the
>> per-architecture changes being much simpler.
>
> OK. That's obviously a bit more churn, but I think it's probably the best
> approach. Unless someone else has a better idea?

Does it make that much of a difference?

You said:
| However in it's current form it's not easily mergeable, because it
touches five
| architectures and has the potential to cause breakage on all of them.

Patch 1 still touches five architectures.
Patches 3-7 still have the potential to break an architecture, but only one of
them at a time.

>From a bisectability point of view there's no change.
Except that patch 1 (and 8) may break something, too ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
