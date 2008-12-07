Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18747.13668.304923.709761@cargo.ozlabs.ibm.com>
Date: Sun, 7 Dec 2008 13:31:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH linux-next] powerpc/powermac: Add missing of_node_put
In-Reply-To: <20081206163449.60757c4a.akpm@linux-foundation.org>
References: <200812021445.18670.npalix@diku.dk>
	<20081206163449.60757c4a.akpm@linux-foundation.org>
Cc: Nicolas Palix <npalix@diku.dk>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Julia Lawall <julia@diku.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> This still misses a path - if that `return 0' is taken, we still leak
> the reference.
> 
> This is reason #345 why sprinkling return statements all over your code
> is bad.
> 
> I fixed it up thusly.  Please check.

I'm really in two minds about applying any of the of_node_put patches
that only affect powermacs.  The reference counts only matter on
platforms where we update the OF device tree at runtime, which is
currently only IBM pSeries machines.  Since we don't have any hotplug
on powermacs, and never will have, the OF device tree is completely
static and we don't actually need refcounts on the nodes at all, so
who cares if they're a bit higher than they might be?

In particular, the VIA whose node we're looking for here is built-in
on the motherboard, and there can never be more than one, and it can
never be removed.

Paul.
