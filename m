Return-Path: <David.Daney@caviumnetworks.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7B946B7C0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 01:40:38 +1000 (EST)
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id 0C4F7DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 01:40:37 +1000 (EST)
Message-ID: <4AAE63E7.90909@caviumnetworks.com>
Date: Mon, 14 Sep 2009 08:40:23 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
	to compiler.h
References: <4AA991C1.1050800@caviumnetworks.com>	
	<1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>	
	<200909111633.00665.mb@bu3sch.de>	
	<4AAA73A4.9010601@caviumnetworks.com>
	<10f740e80909120022m72ad5ea7t692fba93cd3114e9@mail.gmail.com>
In-Reply-To: <10f740e80909120022m72ad5ea7t692fba93cd3114e9@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Geert Uytterhoeven wrote:
> On Fri, Sep 11, 2009 at 17:58, David Daney<ddaney@caviumnetworks.com> wrote:
>> Michael Buesch wrote:
>>> On Friday 11 September 2009 01:56:42 David Daney wrote:
>>>> +/* Unreachable code */
>>>> +#ifndef unreachable
>>>> +# define unreachable() do { for (;;) ; } while (0)
>>>> +#endif
>>> # define unreachable() do { } while (1)
>>>
>>> ? :)
>> Clearly I was not thinking clearly when I wrote that part.  RTH noted the
>> same thing.  I will fix it.
> 
> However, people are so used to seeing the `do { } while (0)' idiom,
> that they might miss
> there's a `1' here, not a `0'.
> 
> So perhaps it's better to use plain `for (;;)' for infinite loops?
> 

I don't think so.  The only valid token that can follow 'do { } while 
(1)' is ';', any statement may follow 'for (;;)', so there is a greater 
possibility to silently screw things up with the for(;;) form.

David Daney
