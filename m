Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B12CEB7088
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Oct 2009 20:05:56 +1100 (EST)
Subject: Re: [patch 22/28] macintosh: Remove BKL from ans-lcd
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20091010153349.966159859@linutronix.de>
References: <20091010153314.827301943@linutronix.de>
	<20091010153349.966159859@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 11 Oct 2009 20:02:02 +1100
Message-Id: <1255251722.2192.33.camel@pasglop>
Mime-Version: 1.0
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Vincent Sanders <vince@simtec.co.uk>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	John Kacur <jkacur@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-10-10 at 15:37 +0000, Thomas Gleixner wrote:
> plain text document attachment (drivers-mac-ans-lcd-remove-bkl.patch)
> The ans-lcd driver got the cycle_kernel_lock() in anslcd_open() from
> the BKL pushdown and it still uses the locked ioctl.
> 
> The BKL serialization in this driver is more than obscure and
> definitely does not cover all possible corner cases. Protect the
> access to the hardware with a local mutex and get rid of BKL and
> locked ioctl.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@ozlabs.org
> ---

While I -do- have an ANS ... it's rusting in the back of my garage and I
really don't have time nor space to set it up and get it back to booting
shape :-) (It's a pretty huge thing)

Patch looks good, so if it builds...

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
