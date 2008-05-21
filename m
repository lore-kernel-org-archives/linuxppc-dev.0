Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04993DE19C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 05:49:57 +1000 (EST)
Date: Wed, 21 May 2008 12:44:07 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
In-Reply-To: <1211378410.8297.192.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0805211238440.5706@t2.domain.actdsltmp>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<1211318219.8297.177.camel@pasglop>
	<Pine.LNX.4.64.0805201425250.7453@t2.domain.actdsltmp>
	<1211378410.8297.192.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 May 2008, Benjamin Herrenschmidt wrote:
>> Depends on what you define as "necessary".  It's seem clear that I/O accessors
>> _no not_ need to be strictly ordered with respect to normal memory accesses,
>> by what's defined in memory-barriers.txt.  So if by "necessary" you mean what
>> the Linux standard for I/O accessors requires (and what other archs provide),
>> then yes, they have the necessary ordering guarantees.
>>
>> But, if you want them to be strictly ordered w.r.t to normal memory, that's
>> not the case.
>
> They should be.

Someone should update memory-barriers.txt, because it doesn't say that, and
all I/O accessors for all the arches, because none of them are.

>> Here's a quick hack I stuck in a driver to test.  compile with -save-temps and
>> check the resulting asm.  gcc will do the optimization I described above.
>>
>> static void __iomem *baz = (void*)0x1234;
>> static struct bar {
>>      u32 bar[256];
>> } bar;
>>
>> void foo(void) {
>>      bar.bar[0] = 44;
>>      out_be32(baz+100, 200);
>>      bar.bar[0] = 45;
>>      out_be32(baz+101, 201);
>> }
>
> Have you removed -fno-strict-aliasing ? Just don't do that.

No, it's compiled with a normal kernel build, which includes
-fno-strict-aliasing.
