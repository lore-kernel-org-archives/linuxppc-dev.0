Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09011DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 15:54:33 +1000 (EST)
Date: Tue, 26 Jun 2007 07:53:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] Make jprobes a little safer for users
Message-ID: <20070626055347.GB6841@lst.de>
References: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
	<7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	anil.s.keshavamurthy@intel.com, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2007 at 11:48:51AM +1000, Michael Ellerman wrote:
> I realise jprobes are a razor-blades-included type of interface, but
> that doesn't mean we can't try and make them safer to use. This guy I
> know once wrote code like this:
> 
> struct jprobe jp = { .kp.symbol_name = "foo", .entry = "jprobe_foo" };
> 
> And then his kernel exploded. Oops.
> 
> This patch adds an arch hook, arch_deref_entry_point() (I don't like it either)
> which takes the void * in a struct jprobe, and gives back the text address
> that it represents.
> 
> We can then use that in register_jprobe() to check that the entry point
> we're passed is actually in the kernel text, rather than just some random
> value.

Please don't add more weak functions, they're utterly horrible for
anyone trying to understand the code.  Otherwise this looks fine to me.
