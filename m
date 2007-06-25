Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5772DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 07:19:53 +1000 (EST)
Message-ID: <4680319A.5050503@genesi-usa.com>
Date: Mon, 25 Jun 2007 22:20:26 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Clifford Wolf <clifford@clifford.at>
Subject: Re: Mem-2-Mem DMA - Generalized API
References: <20070624193932.GA11797@clifford.at>
	<200706242221.57507.arnd@arndb.de>
	<467FA0EA.3000607@genesi-usa.com> <467FBABD.9040103@anagramm.de>
	<467FD1DF.4000602@genesi-usa.com>
	<20070625180110.GH20463@clifford.at>
In-Reply-To: <20070625180110.GH20463@clifford.at>
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clifford Wolf wrote:
> Hi,
>
> However, i don't think that implementing stuff like memset() in a dma
> controller is any good because that would just flood the memory bus which
> would then block in 99% of all cases the cpu until the dma is finished.
>
> It would however cost less power than doing that in the CPU. ;-)

At least while the DMA transfer is happening, you could preempt to some
other task. Would it flood the memory bus? When a DMA transfer happens
would it really do it in such a way that it would stall the CPU on a
memory access far more than it would usually?

I think it would have to be extremely badly designed to be even ABLE to do
that, or at least, you'd be doing some incredibly unwise things to be able
to flood it like that.

>> Indeed. I wonder if we could pull apart the IOAT/DMA stuff and genericise
>> it (it should be possible) or simply add to it, or if making a powerpc
>> specific dma engine abstraction would be an easier idea.
>
> I don't think that this would actually be powerpc specific in any way. But
> since such general purpose dma controllers are more common in embedded
> hardware this still seams to be the right place to discuss the issue.

I meant powerpc platform (as in ARCH=powerpc) specific. Rather than dropping
it in the global drivers, just keep it as a library for powerpc. Everyone
else can get it later with a move into the full tree. As long as the headers
have common, easy to get to names that do not conflict with anything
preexisting, it would not affect anything.

Taking IOAT as an example and fixing it's weirdness would be a better start
than making a whole new API, but I think doing development *WITH* IOAT and
potentially trashing all.. umm.. 4 users, and the weird Linux kernel tripling
of development cost when heavily updating an actively maintained subsystem
that everyone else wants to touch, that would be detrimental. We don't want
to break Intel and we don't want to be tracking Intel's patches or having
extra weirdness break in (or for the number of users of that DMA system to
explode underneath New DMA Development)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
