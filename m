Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8ADC3B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Jul 2011 21:03:11 +1000 (EST)
Subject: Re: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1310860194.25044.17.camel@pasglop>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins>  <4E21A526.8010904@gmail.com>
	<1310860194.25044.17.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jul 2011 13:02:41 +0200
Message-ID: <1310900561.13765.22.camel@twins>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Shan Hai <haishan.bai@gmail.com>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-07-17 at 09:49 +1000, Benjamin Herrenschmidt wrote:
> In the meantime, other than rewriting the futex code to not require
> those in-atomic accesses (can't it just access the pages via the linear
> mapping and/or kmap after the gup ?),

That'll wreck performance on things like ARM and SPARC that have to deal
with cache aliasing.

>  all I see would be a way to force
> dirty and young after gup, with appropriate locks, or a variant of gup
> (via a flag ?) to require it to do so.=20

Again, _WHY_ isn't gup(.write=3D1) a complete write fault? Its supposed to
be, it needs to break COW, do dirty page tracking and call page_mkwrite.
I'm still thinking this e500 stuff is smoking crack.

ARM has no hardware dirty bit either, and yet it works for them. I can't
exactly tell how because I got lost in there, but it does, again,
suggest e500 is on crack.
