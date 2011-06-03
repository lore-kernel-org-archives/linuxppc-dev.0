Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD56CB6FAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 00:48:10 +1000 (EST)
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
From: Peter Zijlstra <peterz@infradead.org>
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
In-Reply-To: <4DCAB6B0.8020904@linux.vnet.ibm.com>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins> <1299675674.2308.2924.camel@twins>
	<1299766211.2308.4468.camel@twins>  <1303294056.8345.122.camel@twins>
	<1303336869.2513.26.camel@pasglop>
	<4DC85BFE.7060900@linux.vnet.ibm.com>
	<1305036563.2914.80.camel@laptop> <4DCAB6B0.8020904@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 03 Jun 2011 16:47:49 +0200
Message-ID: <1307112469.2353.3402.camel@twins>
Mime-Version: 1.0
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-11 at 11:17 -0500, Jesse Larrew wrote:
> > I would really like to see both patch-sets together. Also, I'm not
> at
> > all convinced its a sane thing to do. Pretty much all NUMA aware
> > software I know of assumes that CPU<->NODE relations are static,
> > breaking that in kernel renders all existing software broken.
> >=20
>=20
> I suspect that's true. Then again, shouldn't it be the capabilities of
> the hardware that dictates what the software does, rather than the
> other way around?=20

Wish that were true, we wouldn't be all constrained by all this legacy
software.. ;-)

Anyway, there's plenty of CPU<->NODE assumptions in the kernel as well,
fixing those will be 'interesting' at best, as for userspace, since its
a user-driven tool revamping the topology the user gets to keep the
pieces when he runs that while some NUMA aware proglet is running.
