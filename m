Return-Path: <geert.uytterhoeven@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9FDA2B7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 17:22:48 +1000 (EST)
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203]) by ozlabs.org (Postfix) with ESMTP id 25A4ADDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 17:22:46 +1000 (EST)
Received: by pzk41 with SMTP id 41so1421581pzk.4
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 00:22:45 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4AAA73A4.9010601@caviumnetworks.com>
References: <4AA991C1.1050800@caviumnetworks.com>
	<1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
	<200909111633.00665.mb@bu3sch.de>
	<4AAA73A4.9010601@caviumnetworks.com>
Date: Sat, 12 Sep 2009 09:22:43 +0200
Message-ID: <10f740e80909120022m72ad5ea7t692fba93cd3114e9@mail.gmail.com>
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
	to compiler.h
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
	linux-am33-list@redhat.com, Helge Deller <deller@gmx.de>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-parisc@vger.kernel.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	uclinux-dist-devel@blackfin.uclinux.org, akpm@linux-foundation.org,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 11, 2009 at 17:58, David Daney<ddaney@caviumnetworks.com> wrote=
:
> Michael Buesch wrote:
>>
>> On Friday 11 September 2009 01:56:42 David Daney wrote:
>>>
>>> +/* Unreachable code */
>>> +#ifndef unreachable
>>> +# define unreachable() do { for (;;) ; } while (0)
>>> +#endif
>>
>> # define unreachable() do { } while (1)
>>
>> ? :)
>
> Clearly I was not thinking clearly when I wrote that part. =C2=A0RTH note=
d the
> same thing. =C2=A0I will fix it.

However, people are so used to seeing the `do { } while (0)' idiom,
that they might miss
there's a `1' here, not a `0'.

So perhaps it's better to use plain `for (;;)' for infinite loops?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
