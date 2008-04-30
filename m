Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E4988DE175
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 05:06:50 +1000 (EST)
Message-ID: <4818C33F.60007@am.sony.com>
Date: Wed, 30 Apr 2008 12:06:39 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC] [PATCH] vmemmap fixes to use smaller pages
References: <1209534108.18023.221.camel@pasglop>
In-Reply-To: <1209534108.18023.221.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> This patch changes vmemmap to use a different region (region 0xf) of the
> address space whose page size can be dynamically configured at boot.
> 
> The problem with the current approach of always using 16M pages is that
> it's not well suited to machines that have small amounts of memory such
> as small partitions on pseries, or PS3's.
> 
> In fact, on the PS3, failure to allocate the 16M page backing vmmemmap
> tends to prevent hotplugging the HV's "additional" memory, thus limiting
> the available memory even more, from my experience down to something
> like 80M total, which makes it really not very useable.
> 
> The logic used by my match to choose the vmemmap page size is:
> 
>  - If 16M pages are available and there's 1G or more RAM at boot, use that size.
>  - Else if 64K pages are available, use that
>  - Else use 4K pages
> 
> I've tested on a POWER6 (16M pages) and on an iSeries POWER3 (4K pages)
> and it seems to work fine.
> 
> However, when attempting to test on a PS3, it didn't boot.
> 
> In fact, it doesn't boot without my patch with current upstream. 


Yes, this is a know problem I am working on, related to recent
changes in bootmem.  Errors with: 'sparse_early_usemap_alloc: allocation failed'.


I tried
> booting 2.6.25 with a ps3_defconfig and that doesn't work neither
> (though at least when doing the later, I do get a black screen & no
> sync, like of ps3fb failed monitor detection, while with current
> upstream, I just get the last kexec messages and nothing happens).


This should work.  You are the first to report a problem with 
2.6.25.  Could you double check your build, and if you still have
trouble, put your vmlinux somewhere I can get it?


> Since the PS3 boot failures are impossible to debug unless your email is
> @sony* and you have the special magic tools, I'll let Geoff try the
> patch out.


OK, I'll try it with the upstream kernel from last week and report
within the next day or so.


-Geoff
