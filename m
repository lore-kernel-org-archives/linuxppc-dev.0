Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 799C7B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 02:43:31 +1000 (EST)
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CA+55aFxpH9-4rkH6CRXbjFCQMGNYGRMKgdgHUEthefQPumFKVg@mail.gmail.com>
References: <20110707102107.GA16666@in.ibm.com>
	<1310036375.3282.509.camel@twins> <20110714103418.7ef25b68@kryten>
	<20110714143521.5fe4fab6@kryten> <1310649379.2586.273.camel@twins>
	<20110715104547.29c3c509@kryten> <1311024956.2309.22.camel@laptop>
	<20110719144451.79bc69ab@kryten> <1311070894.13765.180.camel@twins>
	<20110720201436.19e9689a@kryten> <1311158708.5345.12.camel@twins>
	<20110720221420.153b0830@kryten>
	<CA+55aFxzaaMj8OUaust90c_hYKzg8NpRfmX4SzJ9SMwXzg5ocA@mail.gmail.com>
	<1311173910.5345.94.camel@twins>
	<CA+55aFxpH9-4rkH6CRXbjFCQMGNYGRMKgdgHUEthefQPumFKVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jul 2011 18:42:57 +0200
Message-ID: <1311180177.29152.57.camel@twins>
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

On Wed, 2011-07-20 at 09:04 -0700, Linus Torvalds wrote:
> On Wed, Jul 20, 2011 at 7:58 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> =
wrote:
> >
> > Right, so we can either merge my scary patches now and have 3.0 boot on
> > 16+ node machines (and risk breaking something), or delay them until
> > 3.0.1 and have 16+ node machines suffer a little.
>=20
> So how much impact does your scary patch have on machines that don't
> have multiple nodes? If it's a "the code isn't even called by normal
> machines" kind of setup, I don't think I care a lot.

Hmm, it does get called, but it looks relatively straight forward to
make it so that it doesn't. Let me try that.

Yes, the below works nicely (on top of the previous two).

Built and boot tested on a single-node and multi-node x86_64.

---
Subject: sched: Avoid creating superfluous domains
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Wed Jul 20 18:34:30 CEST 2011

When creating sched_domains, stop when we've covered the entire target
span instead of continuing to create domains, only to later find
they're redundant and throw them away again.

This avoids single node systems from touching funny NUMA sched_domain
creation code.

Requested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 kernel/sched.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -7436,6 +7436,8 @@ static int build_sched_domains(const str
 			sd =3D build_sched_domain(tl, &d, cpu_map, attr, sd, i);
 			if (tl->flags & SDTL_OVERLAP || sched_feat(FORCE_SD_OVERLAP))
 				sd->flags |=3D SD_OVERLAP;
+			if (cpumask_equal(cpu_map, sched_domain_span(sd)))
+				break;
 		}
=20
 		while (sd->child)
