Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9CA7FB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 02:02:01 +1000 (EST)
Message-ID: <4E42AB6F.1050900@freescale.com>
Date: Wed, 10 Aug 2011 11:01:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v3] powerpc: 85xx: separate e500 from e500mc
References: <20110810044307.GA2804@sapphire.tkos.co.il>	<b965536bbd0457ab9614777dc00fc0dd22cf1d47.1312953203.git.baruch@tkos.co.il>
	<CAP=VYLoNSaVyfLyKDun-aBEQy+UzKJNwphs2U_74AhKAHgch_Q@mail.gmail.com>
In-Reply-To: <CAP=VYLoNSaVyfLyKDun-aBEQy+UzKJNwphs2U_74AhKAHgch_Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Baruch Siach <baruch@tkos.co.il>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2011 10:39 AM, Paul Gortmaker wrote:
> On Wed, Aug 10, 2011 at 1:21 AM, Baruch Siach <baruch@tkos.co.il> wrote:
>> CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6, thus
>> breaking clear_pages(), probably others too.
>>
>> This patch adds a new "Processor Type" entry for e500mc, and makes e500 systems
>> depend on PPC_E500_V1_V2.
> 
> Isn't the original invalid configuration still possible, i.e. I can
> choose E500_V1_V2
> and also E500MC at the same time, unless you add something like a
> "depends !E500MC" to  your new V1_V2 option?

They're members of a "choice", not standalone bools -- so they're
mutually exclusive.

> Alternatively, you could treat it like using i386 kernel on a modern
> core by taking
> the LCD for the L1_CACHE_SHIFT of the configured in platforms. 

For alignment you want to err on the high side, but for invalidation you
want to err on the low side.  For dcbz you can't err at all.

And there are other issues than cache size with combining e500v2 and e500mc.

Could it be done with sufficient hoop-jumping?  Probably.  Is it worth
it?  No.  These chips don't even have compatible userspace, unless you
use soft-float.

> I have booted
> a kernel built for an mpc8548 core on a P4080 CPU, so that does work (with only
> minimal dts fiddling).

The opposite direction does not work, and simply booting doesn't mean
there wouldn't be issues in running that kernel on a p4080 (floating
point?  bad cache size information being given to userspace?  emulation
of non-cacheable dcbz?  performance?).

What dts fiddling?

> And it keeps the ability to boot one kernel on several
> platforms open (one of the reasons for the ppc --> powerpc shuffle a couple
> of years ago...)

It's much better than the arch/ppc way of a separate kernel build for
every board.  Beyond a certain point there are diminishing returns on
the effort.

-Scott
