Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
	[IPv6:2001:770:15f::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AF729B6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 20:45:43 +1000 (EST)
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20110720201436.19e9689a@kryten>
References: <20110707102107.GA16666@in.ibm.com>
	<1310036375.3282.509.camel@twins> <20110714103418.7ef25b68@kryten>
	<20110714143521.5fe4fab6@kryten> <1310649379.2586.273.camel@twins>
	<20110715104547.29c3c509@kryten> <1311024956.2309.22.camel@laptop>
	<20110719144451.79bc69ab@kryten> <1311070894.13765.180.camel@twins>
	<20110720201436.19e9689a@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jul 2011 12:45:08 +0200
Message-ID: <1311158708.5345.12.camel@twins>
Mime-Version: 1.0
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-07-20 at 20:14 +1000, Anton Blanchard wrote:

> > That looks very strange indeed.. up to node 23 there is the normal
> > symmetric matrix with all the trace elements on 10 (as we would expect
> > for local access), and some 4x4 sub-matrix stacked around the trace
> > with 20, suggesting a single hop distance, and the rest on 40 being
> > out-there.
>=20
> I retested with the latest version of numactl, and get correct results.

One less thing to worry about ;-)

> I worked out why the patches don't boot, we weren't allocating any
> space for the cpumask and ran off the end of the allocation.

Gah! that's not the first time I made that particular mistake :/

> Should we also use cpumask_copy instead of open coding it? I added that
> too.

Probably, I looked for cpumask_assign() and on failing to find that used
the direct assignment.

So with that fix the patch makes the machine happy again?

Thanks!
