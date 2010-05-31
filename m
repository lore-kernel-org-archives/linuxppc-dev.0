Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11E7CB7D5E
	for <linuxppc-dev@ozlabs.org>; Mon, 31 May 2010 18:33:18 +1000 (EST)
Subject: Re: [PATCH 1/5] sched: fix capacity calculations for SMT4
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1271426308.1674.429.camel@laptop>
References: <20100409062118.D4096CBB6C@localhost.localdomain>
	<1271161766.4807.1280.camel@twins>  <2906.1271219317@neuling.org>
	<1271426308.1674.429.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 May 2010 10:33:16 +0200
Message-ID: <1275294796.27810.21554.camel@twins>
Mime-Version: 1.0
Cc: Suresh Siddha <suresh.b.siddha@intel.com>,
	Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-04-16 at 15:58 +0200, Peter Zijlstra wrote:
>=20
>=20
> Hrmm, my brain seems muddled but I might have another solution, let me
> ponder this for a bit..
>=20

Right, so the thing I was thinking about is taking the group capacity
into account when determining the capacity for a single cpu.

Say the group contains all the SMT siblings, then use the group capacity
(usually larger than 1024) and then distribute the capacity over the
group members, preferring CPUs with higher individual cpu_power over
those with less.

So suppose you've got 4 siblings with cpu_power=3D294 each, then we assign
capacity 1 to the first member, and the remaining 153 is insufficient,
and thus we stop and the rest lives with 0 capacity.

Now take the example that the first sibling would be running a heavy RT
load, and its cpu_power would be reduced to say, 50, then we still got
nearly 933 left over the others, which is still sufficient for one
capacity, but because the first sibling is low, we'll assign it 0 and
instead assign 1 to the second, again, leaving the third and fourth 0.

If the group were a core group, the total would be much higher and we'd
likely end up assigning 1 to each before we'd run out of capacity.


For power savings, we can lower the threshold and maybe use the maximal
individual cpu_power in the group to base 1 capacity from.

So, suppose the second example, where sibling0 has 50 and the others
have 294, you'd end up with a capacity distribution of: {0,1,1,1}.
