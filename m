Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1E46FDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 07:47:24 +1000 (EST)
Message-ID: <481A3A50.3060101@am.sony.com>
Date: Thu, 1 May 2008 14:46:56 -0700
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


It doesn't seem to cause problems on PS3, and I added it into ps3-linux.git
as other/powerpc-vmemmap-variable-page-size.diff, but I couldn't get it to
fail without the patch...
 
Could you send me your kernel .config?

-Geoff
