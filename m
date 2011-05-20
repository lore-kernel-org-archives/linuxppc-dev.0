Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69FEBB71A4
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2011 05:31:37 +1000 (EST)
Date: Fri, 20 May 2011 14:30:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 02/14] powerpc: Add a defconfig for 'corenet' 32-bit
	platforms
Message-ID: <20110520143051.50ab6bf8@schlenkerla.am.freescale.net>
In-Reply-To: <4DD6C023.2080601@freescale.com>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<BANLkTimzQ3PUpJQB_sF+PM9DAL+kAYgDYw@mail.gmail.com>
	<64A1571F-0AF7-4717-8D6F-4A980E09DFE0@kernel.crashing.org>
	<4DD6C023.2080601@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 May 2011 14:25:23 -0500
Timur Tabi <timur@freescale.com> wrote:

> Kumar Gala wrote:
> >> > This may be unnecessary.  I originally set CONFIG_FORCE_MAX_ZONEORDER
> >> > to 12 because the DIU driver needs to be able to allocate a contiguous
> >> > 5MB memory block.  Setting it to 13 means a max of 16MB.  Is there a
> >> > reason the default isn't good enough?
> 
> > Is there some concern here?  CONFIG_FORCE_MAX_ZONE_ORDER was set to 13 because of hugetlbfs
> 
> No, I just wanted to make sure it wasn't something that you just set for no
> particular reason.
> 
> Hmm... is 16MB big enough for hugetlbfs?  I presume PAGE_SIZE is still 4KB, so a
> value of 13 is just 16MB.

I think there's a separate mechanism for reserving hugetlbfs space at boot
time.  16 MiB should be enough for fully dynamic allocations, and if you
push it too high fragmentation will likely be too much of a problem.

-Scott
