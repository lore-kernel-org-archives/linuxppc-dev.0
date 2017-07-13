Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7SbH12HszDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 17:47:38 +1000 (AEST)
Date: Thu, 13 Jul 2017 02:47:32 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
Subject: Re: [PATCH 5/5] powerpc/lib/sstep: Add isel instruction emulation
Message-ID: <20170713074732.GD13471@gate.crashing.org>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
 <20170713032548.451-5-matthew.brown.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713032548.451-5-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 01:25:48PM +1000, Matt Brown wrote:
> +		case 585:	/* isel */

The secondary opcode for isel is only 5 bits, not 10 like most other
insns have.

> +			mb = (instr >> 6) & 0x1f; /* bc */
> +			val = (regs->ccr >> (mb + 32)) & 1;

regs->ccr >> (31 - mb)  ?

> +
> +			if (val)
> +				regs->gpr[rd] = regs->gpr[ra];

You need to treat ra=0 separately (as 0, not reg 0).

> +			else
> +				regs->gpr[rd] = regs->gpr[rb];
> +			goto logical_done;


Segher
