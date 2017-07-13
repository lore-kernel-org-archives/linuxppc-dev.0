Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7S974SbBzDqlN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 17:28:27 +1000 (AEST)
Date: Thu, 13 Jul 2017 02:28:21 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
Subject: Re: [PATCH 3/5] powerpc/lib/sstep: Add bpermd instruction emulation
Message-ID: <20170713072821.GB13471@gate.crashing.org>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
 <20170713032548.451-3-matthew.brown.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713032548.451-3-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 01:25:46PM +1000, Matt Brown wrote:
> +static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
> +				unsigned long v2, int ra)
> +{
> +	unsigned int idx, i;
> +	unsigned char perm;
> +
> +	perm = 0x0;
> +	for (i = 0; i < 8; i++) {
> +		idx = (v1 >> (i * 8)) & 0xff;
> +		if (idx < 64)
> +			perm |= (v2 & (1 << idx)) >> (idx - i);

That doesn't work I think, the bit numbers ("idx") are big-endian?

> +	}
> +	regs->gpr[ra] = 0 | perm;

And that is just silly :-)

> +}


Segher
