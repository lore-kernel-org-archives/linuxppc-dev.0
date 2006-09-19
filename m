Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 923BB67B53
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 05:11:45 +1000 (EST)
In-Reply-To: <45103DF0.9050409@genesi-usa.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>	<20060919182953.GK29167@austin.ibm.com>
	<20060919135259.303706d3.kim.phillips@freescale.com>
	<45103DF0.9050409@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E674786-9AF3-4322-B642-7BAA58462B74@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] convert string i/o operations to C
Date: Tue, 19 Sep 2006 21:10:34 +0200
To: Matt Sealey <matt@genesi-usa.com>
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> For a generic "powerpc" kernel it can be understood, but when you
> consider that on 970/POWER4 and above they use lwsync instead of sync

lwsync (sync 1) doesn't (architecturally) do anything to order MMIO
accesses, so you're misunderstanding something.

> (google for them and see the mailing list posts :), just to breathe  
> back
> some performance in spinlocks and so on, surely this can be  
> rejigged so
> that processors don't do more work than necessary..? Even a noop takes
> time doesn't it?

No-ops don't matter for performance, compared to the cost of the I/O
itself.  It would help to avoid heavier-than-necessary synchronisation
instructions if not needed on some certain CPU (or on non-SMP kernels,
etc.)


Segher
