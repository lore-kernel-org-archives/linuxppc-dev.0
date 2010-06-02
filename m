Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 464EFB7D57
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Jun 2010 02:28:06 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o52GS3In021195 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 2 Jun 2010 09:28:03 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o52GbT4n027123
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 2 Jun 2010 11:37:29 -0500 (CDT)
Message-ID: <4C068691.6040501@freescale.com>
Date: Wed, 02 Jun 2010 11:28:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Martyn Welch <martyn.welch@ge.com>
Subject: Re: [PATCH] PowerPC: Remove hardcoded BAT configuration of IMMR in
	CPM	early debug console
References: <20100528151836.5889.10393.stgit@ES-J7S4D2J.amer.consind.ge.com>	<4BFFECF1.9060809@freescale.com>
	<4C050295.408@ge.com> <4C050E84.2010602@ge.com>
	<4C053008.50306@freescale.com> <4C0610F8.6020801@ge.com>
In-Reply-To: <4C0610F8.6020801@ge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2010 03:06 AM, Martyn Welch wrote:
>>>> I think that's a more fundamental change to CPM early debug than I can
>>>> handle right now.
>>
>> Is IMMRBASE on your board at some address that has a low likelihood of
>> conflicting when treated as a kernel effective address?
>
> It's at 0x0f000000, is seems ok, but then I'm not sure I fully
> understand kernel effective addresses.

That overlaps userspace -- is the BAT cleared before userspace starts?

If you don't want to do the fixmap stuff, might want to at least just 
leave it at the current arbitrary effective address, which hasn't seemed 
to cause much trouble so far.

But fixmap is the right way to do it.

-Scott
