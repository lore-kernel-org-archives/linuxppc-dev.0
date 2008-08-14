Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92FA2DDF99
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 02:24:38 +1000 (EST)
Message-Id: <9E78DE5E-7B94-4990-81CB-1EBF806923C1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40808140800s417af75ex76ae73ec990be58d@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC/PATCH v2] powerpc: add ioremap_early() function for mapping
	IO regions before MMU_init()
Date: Thu, 14 Aug 2008 11:24:08 -0500
References: <20080813025726.26033.29519.stgit@trillian.secretlab.ca>
	<1C19524E-8400-4F61-AEB1-19CF20E71098@kernel.crashing.org>
	<fa686aa40808140800s417af75ex76ae73ec990be58d@mail.gmail.com>
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> what happens if we run out of bats?
>
> Then it returns NULL and the caller must handle it.  The board port
> maintainer needs understand the board/CPU/SoC and not depend on more
> BATs than are available.  They also need to understand that there is a
> tradeoff between BATs for IO and BATs for RAM.  If the board port uses
> up all the BATs for IO, then RAM above 256MB ends up getting mapped
> with PTEs and there is a performance hit.  My expectation is that only
> platform code will use this facility.  Device drivers should continue
> to use ioremap() and will gain the benefit of the BATs if platform
> code already set them up.  I can add some text to the documentation to
> describe this.
>
> I'm not going to make any attempt to fallback to PTEs for IO when
> there isn't enough BATs.  Doing so adds an order of magnitude more
> complexity.

that's fine.. I just didn't look at setbat() to see it errors out.

Also can we get rid of LOAD_BAT in head_32.S?

- k
