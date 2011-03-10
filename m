Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E17DB6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 01:10:30 +1100 (EST)
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1299675674.2308.2924.camel@twins>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins> <1299675674.2308.2924.camel@twins>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Mar 2011 15:10:11 +0100
Message-ID: <1299766211.2308.4468.camel@twins>
Mime-Version: 1.0
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Wed, 2011-03-09 at 14:01 +0100, Peter Zijlstra wrote:
> On Wed, 2011-03-09 at 11:19 +0100, Peter Zijlstra wrote:
> > No, the domain stuff is good, we allocate new domains and have a
> > synchronize_sched() between us installing the new ones and freeing the
> > old ones.=20
>=20
> Gah, if only..

OK, so for hotplug and cpusets it works because they change the doms_cur
set, when the old and the new set don't match it destroys the current
sched_domain/sched_group sets for the relevant cpus and then calls
synchronize_sched() to wait for any current activity to go away.

Only then does it rebuild stuff for the new set, reusing the static
allocated sched_domain and sched_group data.

Now, supposedly when your new and old domain set is the same it should
be a nop, unless arch_update_cpu_topology() returns true in which case
it will do a full destroy and rebuild.

So I'm not quite sure what power does to make it go bang..

Anyway, I'm now rewriting the sched_domain creation stuff because I've
utterly had it with that code..

Also, still waiting to hear from the Power7 folks on how often they
think to rebuild the topology and how they think that makes sense,
afaict Power7 does have actual NUMA nodes unlike s390, so I'm still not
seeing how that's going to work properly at all.
