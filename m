Return-Path: <andi@firstfloor.org>
Date: Tue, 19 Feb 2008 10:28:46 +0100
From: Andi Kleen <andi@firstfloor.org>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Message-ID: <20080219092846.GB6485@one.firstfloor.org>
References: <47B70A61.9030306@tiscali.nl>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<p731w7axrat.fsf@bingen.suse.de>
	<200802191333.53607.nickpiggin@yahoo.com.au>
	<20080219055806.GA8404@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080219055806.GA8404@1wt.eu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Roel Kluin <12o3l@tiscali.nl>,
	lkml <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Andi Kleen <andi@firstfloor.org>, cbe-oss-dev@ozlabs.org,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Sometimes, for performance critical paths, I would like gcc to be dumb and
> follow *my* code and not its hard-coded probabilities. 

If you really want that, simple: just disable optimization @)

> Maybe one thing we would need would be the ability to assign probabilities
> to each branch based on what we expect, so that gcc could build a better
> tree keeping most frequently used code tight.

Just use profile feedback then for user space. I don't think it's a good
idea for kernel code though because it leads to unreproducible binaries
which would wreck the development model.

> Hmm I've just noticed -fno-guess-branch-probability in the man, I never tried
> it.

Or -fno-reorder-blocks

-Andi
