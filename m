Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id D5718B7BB3
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 07:30:02 +1100 (EST)
Date: Thu, 5 Nov 2009 23:30:01 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/83xx/suspend: Clear deep_sleeping after
	devices resume
Message-ID: <20091105203001.GA629@oksana.dev.rtsoft.ru>
References: <20090923190041.GA18944@oksana.dev.rtsoft.ru>
	<20090923190113.GA19932@oksana.dev.rtsoft.ru>
	<043A102D-9F70-4287-B34E-17FF9AE90EE1@kernel.crashing.org>
	<4AF30406.3080101@freescale.com>
	<2F8E2E66-8398-4ACD-9697-6C2AB6E39CD3@kernel.crashing.org>
	<4AF32C0B.4010109@freescale.com>
	<7A8DBFC0-69D9-406B-B1AC-3EAC8EE26C58@kernel.crashing.org>
	<4AF32F82.8040801@freescale.com>
	<20091105200931.GA30577@oksana.dev.rtsoft.ru>
	<4AF334AB.1030401@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4AF334AB.1030401@freescale.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2009 at 02:25:15PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
> >On Thu, Nov 05, 2009 at 02:03:14PM -0600, Scott Wood wrote:
> >>Kumar Gala wrote:
> >>>On Nov 5, 2009, at 1:48 PM, Scott Wood wrote:
> >>>>As for patch 3, Ben objected to the sleep-nexus stuff on IRC.
> >>>Is sleep-nexus new?  I thought we've had that for a bit.
> >>It's been around in a few dts files, but as was noted, nothing uses
> >>this stuff yet.
> >
> >So I should just drop the sleep-nexus changes? I can also
> >prepare a patch that removes sleep-nexus from 8313rdb.dts.
> >But how should we handle the sleep = <> properties then?
> 
> We could still have some sort of nexus node that is off to the side
> (pointed to with sleep-parent) and not inserting itself into the
> hierarchy.
> 
> Or, we could allow multiple nodes to refer to the same sleep ID, and
> use the ID rather than a node to tie things together.  If we do
> that, we'll probably want a simple index rather than a set of bits
> in the sleep property, so it can correspond to some kernel object
> that has some bookeeping info.  Perhaps we could tie into the clock
> bindings that were discussed on devtree-discuss in August.

Yeah, reusing the clk api would be the best.

Anyway, since we don't use the sleep-nexus stuff, I'd rather
just add the power management controller nodes.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
