Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C244DDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 07:27:10 +1000 (EST)
Message-ID: <47225BB9.1020403@freescale.com>
Date: Fri, 26 Oct 2007 16:27:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: reg adjust_total_lowmem
References: <4dd2a2ce0710252051pe83a943q48f52d148f5a9603@mail.gmail.com>
	<524E69ED-899B-452F-B593-44499C5181A3@kernel.crashing.org>
	<20071026194005.GA4571@loki.buserror.net>
	<47225327.2070103@freescale.com>
	<Pine.LNX.4.64.0710261615380.23925@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0710261615380.23925@blarg.am.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Surya Ravikiran <koduks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Fri, 26 Oct 2007, Scott Wood wrote:
> 
>> Scott Wood wrote:
>>> On Fri, Oct 26, 2007 at 10:04:19AM -0500, Kumar Gala wrote:
>>>> The reason you have 192M is that lowmem is the total amount of memory
>>>> that can be covered by up to three CAM entries.  In the case of  setting
>>>> mem=252M that max that three CAM entries can cover is 192M (64 +64+64).
>>>> You should be able to access the other 60M via HIGHMEM.
>>> Why doesn't it just use a 256M mapping, and not access the last 4M?
> 
> This has some possibility, not sure what the threshold should be.  Do we
> just always map 768M of lowmem regardless of how much memory we have?

That's probably the simplest way.  We'll need to fix VMALLOC_START as well.

>> Not to mention, why highmem and not just normal TLB0 mappings for the extra
>> pages?
> 
> Because we do not handle recursive misses in the TLB handlers.  We expect
> any load/store that occurs in the TLB handlers to not have a TLB fault
> associated with (and thus all of lowmem must be pinned).

OK.  I guess that means no page debugging... :-P

-Scott
