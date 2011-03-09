Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55527B6FBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 00:19:44 +1100 (EST)
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
From: Peter Zijlstra <peterz@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20110309141548.722e4f56@mschwide.boeblingen.de.ibm.com>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins> <1299670429.2308.2834.camel@twins>
	<20110309141548.722e4f56@mschwide.boeblingen.de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Mar 2011 14:19:29 +0100
Message-ID: <1299676769.2308.2944.camel@twins>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-09 at 14:15 +0100, Martin Schwidefsky wrote:
> On Wed, 09 Mar 2011 12:33:49 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > On Wed, 2011-03-09 at 11:19 +0100, Peter Zijlstra wrote:
> > > > It appears that this corresponds to one CPU deciding to rebuild the
> > > > sched domains. There's various reasons why that can happen, the typ=
ical
> > > > one in our case is the new VPNH feature where the hypervisor inform=
s us
> > > > of a change in node affinity of our virtual processors. s390 has a
> > > > similar feature and should be affected as well.
> > >=20
> > > Ahh, so that's triggering it :-), just curious, how often does the HV=
 do
> > > that to you?=20
> >=20
> > OK, so Ben told me on IRC this can happen quite frequently, to which I
> > must ask WTF were you guys smoking? Flipping the CPU topology every tim=
e
> > the HV scheduler does something funny is quite insane. And you did that
> > without ever talking to the scheduler folks, not cool.
> >=20
> > That is of course aside from the fact that we have a real bug there tha=
t
> > needs fixing, but really guys, WTF!
>=20
> Just for info, on s390 the topology change events are rather infrequent.
> They do happen e.g. after an LPAR has been activated and the LPAR
> hypervisor needs to reshuffle the CPUs of the different nodes.

But if you don't also update the cpu->node memory mappings (which I
think it near impossible) what good is it to change the scheduler
topology?
