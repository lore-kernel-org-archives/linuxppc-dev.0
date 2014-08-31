Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com
 [IPv6:2a00:1450:4010:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E96E1A004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Sep 2014 00:14:26 +1000 (EST)
Received: by mail-la0-f45.google.com with SMTP id pn19so4851672lab.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Aug 2014 07:14:22 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAJhHMCDaSAzU3zvhY2FRFoBaQH4oQBTsUsYMU6pvBbCXydROZQ@mail.gmail.com>
References: <1409369788-22563-1-git-send-email-bobby.prani@gmail.com>
 <CAMuHMdV_naTfQOLwOshWq1Q15kSE39a8GWChsjt3RrWRcd6peg@mail.gmail.com>
 <CAJhHMCDaSAzU3zvhY2FRFoBaQH4oQBTsUsYMU6pvBbCXydROZQ@mail.gmail.com>
Date: Sun, 31 Aug 2014 16:14:21 +0200
Message-ID: <CAMuHMdWMct-06aEMNdHWv7A-9SyLwu3pZfmF9ZxTrFGA2=ab_A@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc: Wire up three syscalls
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pranith Kumar <bobby.prani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: open list <linux-kernel@vger.kernel.org>, Fabian Frederick <fabf@skynet.be>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pranith,

On Sun, Aug 31, 2014 at 2:52 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> On Sun, Aug 31, 2014 at 4:53 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sat, Aug 30, 2014 at 5:36 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
>>> I see that the three syscalls seccomp, getrandom and memfd_create are not wired
>>> because of which we get a warning while compilation.
>>>
>>> So I wired them up in this patch. What else needs to be done? I tried the
>>> memfd_test after compiling this kernel, but it is failing. What am I missing for
>>> this to work? Any advice is really appreciated! :)
>>
>> Did it fail due to the (silly) "ifeq ($(ARCH),X86)" checks in
>> tools/testing/selftests/memfd/Makefile?
>
> I removed that check and compiled memfd_test.c by hand. This is the
> following error which I get when I run the test:
>
> $ ./memfd_test
> memfd: CREATE
> memfd: BASIC
> 10 != 0 = GET_SEALS(3)
> Aborted
>
> This is basically when checking the seals which we already added. It
> should return 10 (F_SEAL_SHRINK | F_SEAL_WRITE), instead it is returning 0.

So it does fail.

> What else needs to be done for this to properly work? I see that for
> m68k, you just wired it up like in this patch. Did it work after that?

To be honest, I didn't run any tests.

I had a few spare minutes, so I wanted to give it a try, but "make kselftest"
doesn't work with building in a separate directory (O=), doesn't support
CROSS_COMPILE=, etc... So I gave up (for now).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
