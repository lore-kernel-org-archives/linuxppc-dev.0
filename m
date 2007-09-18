Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AEE44DDE3D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 01:06:04 +1000 (EST)
In-Reply-To: <20070917165746.GP6563@loki.buserror.net>
References: <20070917165746.GP6563@loki.buserror.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <58472170-34D3-43F4-A816-87AF0020A086@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 16/28] 8xx: Don't call non-existent Soft_emulate_8xx from
	SoftwareEmulation.
Date: Tue, 18 Sep 2007 10:08:50 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 17, 2007, at 11:57 AM, Scott Wood wrote:

> On arch/ppc, Soft_emulate_8xx was used when full math emulation was
> turned off to emulate a minimal subset of floating point load/store
> instructions, to avoid needing a soft-float toolchain.  This function
> is called, but not present, on arch/powerpc, causing a build error
> if floating point emulation is turned off.
>
> As:
> 1. soft-float toolchains are now common,
> 2. partial emulation could mislead someone into thinking they have
> a soft-float userspace because things usually work, only to have it
> fail when actual FP gets executed under unusual circumstances, and
> 3. full emulation is still available for those who need to run
> non-soft-float userspace,
>
> I'm deleting the call rather than moving Soft_emulate_8xx over to
> arch/powerpc.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>

I'm still not in favor of this and think we should move the  
Soft_emulate_8xx code over.

- k
