Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A204DE2B4
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 01:07:32 +1000 (EST)
Date: Thu, 12 Jun 2008 09:07:16 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080612150716.GX30405@parisc-linux.org>
References: <1211852026.3286.36.camel@pasglop> <4843C3D7.7000609@sgi.com>
	<200806031433.12460.nickpiggin@yahoo.com.au>
	<200806030952.10360.jbarnes@virtuousgeek.org>
	<4847A690.302@sgi.com> <1212655433.9496.109.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1212655433.9496.109.camel@pasglop>
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Roland Dreier <rdreier@cisco.com>, Jes Sorensen <jes@sgi.com>,
	linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>, scottwood@freescale.com,
	torvalds@linux-foundation.org, tpiepho@freescale.com,
	alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 06:43:53PM +1000, Benjamin Herrenschmidt wrote:
> Note that the powerpc implementation currently clears the flag
> on spin_lock and tests it on unlock. We are considering changing
> that to not touch the flag on spin_lock and just clear it whenever
> we do a sync (ie, on unlock, on explicit mmiowb, and possibly even
> on readl's where we happen to do sync's).

Your current scheme sounds like it's broken for

spin_lock(a)
writel();
spin_lock(b);
spin_unlock(b);
spin_unlock(a);

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
