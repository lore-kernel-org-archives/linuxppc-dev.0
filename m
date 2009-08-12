Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep16-int.chello.at (viefep16-int.chello.at [62.179.121.36])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 6455DB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 22:11:11 +1000 (EST)
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20090812115806.GK24339@elf.ucw.cz>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
	<20090809120818.GA1338@ucw.cz> <200908091522.02898.rjw@sisk.pl>
	<20090810081941.GA18649@elf.ucw.cz>
	<1249950137.11545.38184.camel@localhost.localdomain>
	<20090812115806.GK24339@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 12 Aug 2009 14:05:43 +0200
Message-Id: <1250078743.10001.41.camel@twins>
Mime-Version: 1.0
Cc: "Brown, Len" <len.brown@intel.com>, Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>, "Li,
	Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-12 at 13:58 +0200, Pavel Machek wrote:
> Hi!
> 
> > May be having (to pick a number) 3 possible offline states for all
> > platforms with one for halt equivalent and one for deepest possible that
> > CPU can handle and one for deepest possible that platform likes for
> > C-states may make sense. Will keeps things simpler in terms of usage
> > expectations and possibly reduce the misuse oppurtubity?
> 
> Maybe just going to the deepest offline state automatically is the
> easiest option?
> 
> cpu hotplug/unplug should be rare-enough operation that the latencies
> do not really matter, right?

Ha, it uses kstopmachine, anybody caring about hotplug latencies is
insane.

And yeah, I'm not quite sure what this user-interface is good for
either. Having an in-kernel management layer where you can register
various idle routines makes sense. But exposing it to userspace,.. not
so much.

The idle thread can select an idle routine under constraints of the QoS
latency constraints, the unplug loop however should indeed select the
one that is available to dead cpus (not all idle routines are available
from what people tell me), and yields the best power savings.
