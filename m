Return-Path: <linuxppc-dev+bounces-24468-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16796C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:25:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3c9Y28Pyz2xm3;
	Mon, 20 Jul 2026 20:25:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784543153;
	cv=none; b=HpYgHgvQBPATgfrG062od9JrBHEqjg/tE0tpd9RuPthp6owtGPfZ7ak19w5k6SpOQCCXr6S+f1VwiNM/3FK5mL20U/qCGpqLUJfvFZI2qTdk72UpvNKAwYzJQ9FzodPlebgumZWZwKf8mcDVrR2W24xOLYYB1YzdzCVXCxQOLHQ3WQMRTsPG2h4KHDbIwTF/JoLiCtDFVyryJ6E4w2mu3hh0FEtTO+68BV3fhXC0xYkyBoIp6Csu4+l7QVdl07EeOcPAWwzSOGX82F3FWAg8fWMpJW5HPvtjpojyYw+0GUtCUM6rTZQyJDnh5DUYMuRgu6aAjiRqWC6aPdbD8McHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784543153; c=relaxed/relaxed;
	bh=FEMcrO3HGTL8xCZ4BlJZDMVbP9rHDDAPrTvoBCm+z/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYyGVPdvSoSIsEr48CsCqOeyZxWXvxvdhHVX7HaE2vfuNIJcCsJfBCfUtUZw8c4hJ2TME3YaLw+4cEXQBDXsteVHN51mePZ/VCJsIzonMdMxGfhFGXzxho2HIGtPFGekjDR1O2yeRdFbiLzXk88owTAvAaqIDMeYC+SqWRtgpKSyAHPFp9dSoysspdUWz2PAC5bS6/0bAVS8ubPZZ6ioe9CpXCAmbn9ioDn+Z4+Iaot7HV6Tql/7vylNKliN1Y841BS5OYXrqtTcopUJJFY0bEXi0pe7mF9+/XJfz8I+eAynEuMEcdUT0xmREIdx7md5A0NRtQYziNRmmaiRwdpWzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3c9W4xNQz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:25:50 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 66KAPIbp3694179;
	Mon, 20 Jul 2026 05:25:18 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 66KAPIvE3694176;
	Mon, 20 Jul 2026 05:25:18 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 20 Jul 2026 05:25:18 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, hbathini@linux.ibm.com, venkat88@linux.ibm.com,
        yeswanth@linux.ibm.com
Subject: Re: [PATCH] powerpc/irq: Fix missing r2 clobber in PCREL inline
 assembly
Message-ID: <al33jmn9PmMJwYlz@gate>
References: <dc021f42afa10396052499cbeda1772e30b7ca64.1784530547.git.skb99@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc021f42afa10396052499cbeda1772e30b7ca64.1784530547.git.skb99@linux.ibm.com>

Hi!

On Mon, Jul 20, 2026 at 12:43:47PM +0530, Saket Kumar Bhaskar wrote:
> In CONFIG_PPC_KERNEL_PCREL mode, r2 is no longer reserved for the TOC
> pointer and is available as a caller-saved register [0].

Just like on many more ABIs.  Yeah.  It's the first that PowerPC Linux
supports though :-)

> Both call_do_irq() and call_do_softirq() use inline assembly to call
> functions with stack switching, but fail to list r2 in their clobber
> lists. This causes the compiler to assume r2 is preserved across these
> calls, leading to register corruption when the called functions
> (__do_irq and __do_softirq) clobber r2.

Yeah.

> index a0e8b998c9b5..26df38bdd334 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -218,7 +218,12 @@ static __always_inline void call_do_softirq(const void *sp)
>  		   [callee] "i" (__do_softirq)
>  		 : // Clobbers
>  		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> -		   "cr7", "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> +		   "cr7", "r0",
> +		  /* r2 is clobbered in PCREL mode */

"Note that r2 may be clobbered in the call, when using the ELF V2 ABI"?

PCREL has nothing to do with it.  Well, not directly :-)  And the
clobber list does not specify registers that definitely *are* clobbered,
but registers that *may be* clobbered, instead :-)  Registers that *are*
clobbered are in the output list (and given a name there so that the new
value can be accessed, etc.)

> +#ifdef CONFIG_PPC_KERNEL_PCREL
> +		   "r2",
> +#endif
> +		   "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
>  		   "r11", "r12"
>  	);
>  }
> @@ -276,7 +281,12 @@ static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
>  		   [callee] "i" (__do_irq)
>  		 : // Clobbers
>  		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> -		   "cr7", "r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> +		   "cr7", "r0",
> +		  /* r2 is clobbered in PCREL mode */
> +#ifdef CONFIG_PPC_KERNEL_PCREL
> +		   "r2",
> +#endif
> +		   "r4", "r5", "r6", "r7", "r8", "r9", "r10",
>  		   "r11", "r12"
>  	);
>  }


Segher

