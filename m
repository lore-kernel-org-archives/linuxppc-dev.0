Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xH2J014ybzDqp1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 01:30:39 +1000 (AEST)
Date: Tue, 25 Jul 2017 10:30:33 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/5] powerpc/lib/sstep: Add prty instruction emulation
Message-ID: <20170725153033.GH13471@gate.crashing.org>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-4-matthew.brown.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725033320.17893-4-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2017 at 01:33:19PM +1000, Matt Brown wrote:
> +static nokprobe_inline void do_prty(struct pt_regs *regs, unsigned long v,
> +				int size, int ra)
> +{
> +	unsigned long long res = v;
> +
> +	res = (0x0001000100010001 & res) + (0x0001000100010001 & (res >> 8));
> +	res = (0x0000000700000007 & res) + (0x0000000700000007 & (res >> 16));
> +	if (size == 32) {		/* prtyw */
> +		regs->gpr[ra] = (0x0000000100000001 & res);
> +		return;
> +	}
> +
> +	res = (0x000000000000000f & res) + (0x000000000000000f & (res >> 32));
> +	regs->gpr[ra] = res & 1;	/*prtyd */
> +}

Does 7's and 0xf look strange (since the top bit in the values there
is always 0).  You always "and" the values with 1 later, you could do
that immediately (and change + to ^).

A general question about these patches: some things are inside #ifdef
__powerpc64__, some are not.  It seems it is the wrong macro, and it
should be used (or not used) consistently?


Segher
