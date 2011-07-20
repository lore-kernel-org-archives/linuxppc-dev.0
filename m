Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
	[IPv6:2001:770:15f::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA3DDB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 00:59:06 +1000 (EST)
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CA+55aFxzaaMj8OUaust90c_hYKzg8NpRfmX4SzJ9SMwXzg5ocA@mail.gmail.com>
References: <20110707102107.GA16666@in.ibm.com>
	<1310036375.3282.509.camel@twins> <20110714103418.7ef25b68@kryten>
	<20110714143521.5fe4fab6@kryten> <1310649379.2586.273.camel@twins>
	<20110715104547.29c3c509@kryten> <1311024956.2309.22.camel@laptop>
	<20110719144451.79bc69ab@kryten> <1311070894.13765.180.camel@twins>
	<20110720201436.19e9689a@kryten> <1311158708.5345.12.camel@twins>
	<20110720221420.153b0830@kryten>
	<CA+55aFxzaaMj8OUaust90c_hYKzg8NpRfmX4SzJ9SMwXzg5ocA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jul 2011 16:58:30 +0200
Message-ID: <1311173910.5345.94.camel@twins>
Mime-Version: 1.0
Cc: mahesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-07-20 at 07:40 -0700, Linus Torvalds wrote:
> On Wed, Jul 20, 2011 at 5:14 AM, Anton Blanchard <anton@samba.org> wrote:
> >
> >> So with that fix the patch makes the machine happy again?
> >
> > Yes, the machine looks fine with the patches applied. Thanks!
>=20
> Ok, so what's the situation for 3.0 (I'm waiting for some RCU
> resolution now)? Anton's patch may be small, but that's just the tiny
> fixup patch to Peter's much scarier one ;)

Right, so we can either merge my scary patches now and have 3.0 boot on
16+ node machines (and risk breaking something), or delay them until
3.0.1 and have 16+ node machines suffer a little.

The alternative quick hack is simply to disable the node domain, but
that'll be detrimental to regular machines in that the top domain used
to have NODE sd_flags will now have ALL_NODE sd_flags which are much
less aggressive.
