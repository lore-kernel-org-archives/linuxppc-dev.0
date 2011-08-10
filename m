Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B6368B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 03:38:18 +1000 (EST)
Message-ID: <4E42B477.80706@windriver.com>
Date: Wed, 10 Aug 2011 12:40:23 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3] powerpc: 85xx: separate e500 from e500mc
References: <20110810044307.GA2804@sapphire.tkos.co.il>	<b965536bbd0457ab9614777dc00fc0dd22cf1d47.1312953203.git.baruch@tkos.co.il>
	<CAP=VYLoNSaVyfLyKDun-aBEQy+UzKJNwphs2U_74AhKAHgch_Q@mail.gmail.com>
	<4E42AB6F.1050900@freescale.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
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

On 11-08-10 12:01 PM, Scott Wood wrote:
> On 08/10/2011 10:39 AM, Paul Gortmaker wrote:
>> On Wed, Aug 10, 2011 at 1:21 AM, Baruch Siach <baruch@tkos.co.il> wrote:
>>> CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6, thus
>>> breaking clear_pages(), probably others too.
>>>
>>> This patch adds a new "Processor Type" entry for e500mc, and makes e500 systems
>>> depend on PPC_E500_V1_V2.
>>
>> Isn't the original invalid configuration still possible, i.e. I can
>> choose E500_V1_V2
>> and also E500MC at the same time, unless you add something like a
>> "depends !E500MC" to  your new V1_V2 option?
> 
> They're members of a "choice", not standalone bools -- so they're
> mutually exclusive.

OK, I missed that.

> 
>> Alternatively, you could treat it like using i386 kernel on a modern
>> core by taking
>> the LCD for the L1_CACHE_SHIFT of the configured in platforms. 
> 
> For alignment you want to err on the high side, but for invalidation you
> want to err on the low side.  For dcbz you can't err at all.
> 
> And there are other issues than cache size with combining e500v2 and e500mc.
> 
> Could it be done with sufficient hoop-jumping?  Probably.  Is it worth
> it?  No.  These chips don't even have compatible userspace, unless you
> use soft-float.

Yeah, if there are lots of other issues and the value return is low,
then I can't argue with that.  And yes I did use soft float in the
thing I was meddling with.

> 
>> I have booted
>> a kernel built for an mpc8548 core on a P4080 CPU, so that does work (with only
>> minimal dts fiddling).
> 
> The opposite direction does not work, and simply booting doesn't mean
> there wouldn't be issues in running that kernel on a p4080 (floating
> point?  bad cache size information being given to userspace?  emulation
> of non-cacheable dcbz?  performance?).
> 
> What dts fiddling?

Just making sure that the 8548 dts had the right address to
find the uart on the actual p4080 platform.

> 
>> And it keeps the ability to boot one kernel on several
>> platforms open (one of the reasons for the ppc --> powerpc shuffle a couple
>> of years ago...)
> 
> It's much better than the arch/ppc way of a separate kernel build for
> every board.  Beyond a certain point there are diminishing returns on
> the effort.

Given the extra info you list above, I agree.  I just thought it worth
a mention since I had happened to boot the 8548 kernel on a p4080 as
part of something else I was experimenting with, and it didn't totally
catch fire (which somewhat surprised me).

P.

> 
> -Scott
> 
