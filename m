Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-70-125.roch.qwest.net [67.41.70.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDCBE68847
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Dec 2005 08:57:27 +1100 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
In-Reply-To: <20051202080711.GA32759@obsidianresearch.com>
References: <20051202080711.GA32759@obsidianresearch.com>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 15:14:37 -0600
Message-Id: <1133558077.26046.1.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.15-rc4] ppc32: Fixes for non-zero PPC_MEMSTART on
	PPC440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-12-02 at 01:07 -0700, Jason Gunthorpe wrote:
> I have a custom embedded system with a 440GP derived CPU that places the
> memory starting at 0xc0000000 which requires a non-zero PPC_MEMSTART. There
> are a couple of places that assume PPC_MEMSTART is 0. This results in
> various tricky crashing during booting. Most of the problems are
> not accounting for PPC_MEMSTART during va/pa translations. My fixes
> convert these places to use pre-existing macros instead of duplicating
> the calculation.
> 
> The two items in head_4xx.S are critical, but I can't see a good way
> to link them in without an #ifdef, or maybe a CONFIG_* symbol. The
> alternate version of the tlb index picker will work for any platform,
> but is based on 'random' selection of the tlb index using the timebase
> rather than linear increment. I don't know if this is better, but it
> is an easy way to skip the problematic memory reference.

Shouldn't your board be using head_44x.S?

/me is confused...

josh
