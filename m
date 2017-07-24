Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGCqz0jMlzDqsV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 17:37:02 +1000 (AEST)
Date: Mon, 24 Jul 2017 02:36:55 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
Message-ID: <20170724073654.GR13471@gate.crashing.org>
References: <20170724010109.21263-1-matthew.brown.dev@gmail.com>
 <20170724010109.21263-2-matthew.brown.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170724010109.21263-2-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matt,

On Mon, Jul 24, 2017 at 11:01:06AM +1000, Matt Brown wrote:
> +	for (i = 0; i < (64 / size); i++) {

If you do

  for (i = 0; i < 64; i += size)

things are slightly nicer.

> +		if ((i * size) < 32)
> +			low |= n << (i * size);
> +		else
> +			high |= n << ((i * size) - 32);
> +	}
> +	regs->gpr[ra] = (high << 32) | low;

Why have separate high and low vars?

And there are much better ways to calculate popcount, of course.


Segher
