Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7SNF1qbkzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 17:38:04 +1000 (AEST)
Date: Thu, 13 Jul 2017 02:37:57 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
Subject: Re: [PATCH 4/5] powerpc/lib/sstep: Add prty instruction emulation
Message-ID: <20170713073757.GC13471@gate.crashing.org>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
 <20170713032548.451-4-matthew.brown.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713032548.451-4-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 01:25:47PM +1000, Matt Brown wrote:
> +static nokprobe_inline void do_prtyw(struct pt_regs *regs, unsigned long v,
> +				int ra)
> +{
> +	unsigned long low, high, out;
> +	unsigned int i;
> +
> +	high = 0;
> +	low = 0;
> +	out = 0;
> +
> +	for (i = 0; i < 8; i++) {
> +		if (v & (1 << (i * 8)))

1UL

> +			(i < 4) ? (low++) : (high++);
> +	}
> +
> +	if (low % 2)
> +		out |= low;
> +	if (high % 2)
> +		out |= (high << 32);

Only the low bit of each word of the output can be set.  Something
like

  out = ((high & 1) << 32) | (low & 1);


Segher
