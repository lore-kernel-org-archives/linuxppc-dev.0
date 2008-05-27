Return-Path: <corbet@lwn.net>
Received: from vena.lwn.net (vena.lwn.net [206.168.112.25])
	by ozlabs.org (Postfix) with ESMTP id E40B8DE06E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 01:34:48 +1000 (EST)
Date: Tue, 27 May 2008 09:28:30 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: benh@kernel.crashing.org
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080527092830.3535ee7b@bike.lwn.net>
In-Reply-To: <1211852026.3286.36.camel@pasglop>
References: <4833524C.3040207@freescale.com>
	<20080520.153947.84346222.davem@davemloft.net>
	<4833542E.3040608@freescale.com>
	<20080520.155326.195407196.davem@davemloft.net>
	<1211516683.8297.271.camel@pasglop>
	<Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
	<1211852026.3286.36.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux Arch list <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Trent Piepho <tpiepho@freescale.com>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 27 May 2008 11:33:46 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> However, I'm using that as an excuse to bring back my pet subject,
> which is basically, should we instead just finally mandate the use of
> explicit rmb/wmb/mb's (which boils down to barrier() on x86) to
> drivers who want to order memory consistent accesses vs. MMIO ?

To me this seems like asking for a long series of weird bugs in
drivers.  Is the cost of a barrier in an MMIO operation so high that we
can't afford to just put them in?  Alan's suggestion of no-barrier
versions for people who know what they're doing (and who think there's a
reason to care) seems like a better way to go to me.

jon
