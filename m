Return-Path: <lorenzo.pieralisi@arm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCstb6pzrzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 18:59:51 +1000 (AEST)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by ozlabs.org (Postfix) with ESMTP id 3rCstb2nRdz9s9n
 for <linuxppc-dev@ozlabs.org>; Mon, 23 May 2016 18:59:50 +1000 (AEST)
Date: Mon, 23 May 2016 10:00:04 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Message-ID: <20160523090004.GA21186@red-moon>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
 <20160519114029.GW3193@twins.programming.kicks-ass.net>
 <201605201223.u4KCNWn9028105@mx0a-001b2d01.pphosted.com>
 <20160522103912.GN3193@twins.programming.kicks-ass.net>
 <20160522204252.GH15383@graphite.smuckle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160522204252.GH15383@graphite.smuckle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 22, 2016 at 01:42:52PM -0700, Steve Muckle wrote:
> On Sun, May 22, 2016 at 12:39:12PM +0200, Peter Zijlstra wrote:
> > On Fri, May 20, 2016 at 05:53:41PM +0530, Shilpasri G Bhat wrote:
> > > 
> > > Below are the comparisons by disabling watchdog.
> > > Both schedutil and ondemand have a similar ramp-down trend. And in both the
> > > cases I can see that frequency of the cpu is not reduced in deterministic
> > > fashion. In a observation window of 30 seconds after running a workload I can
> > > see that the frequency is not ramped down on some cpus in the system and are
> > > idling at max frequency.
> > 
> > So does it actually matter what the frequency is when you idle? Isn't
> > the whole thing clock gated anyway?
> > 
> > Because this seems to generate contradictory requirements, on the one
> > hand we want to stay idle as long as possible while on the other hand
> > you seem to want to clock down while idle, which requires not being
> > idle.
> > 
> > If it matters; should not your idle state muck explicitly set/restore
> > frequency?
> 
> AFAIK this is very platform dependent. Some will waste more power than
> others when a CPU idles above fmin due to things like resource (bus
> bandwidth, shared cache freq etc) voting.

It is also related to static leakage power that depends on the operating
voltage (ie higher operating frequencies require higher voltage) so in a
way scaling frequency before going idle may not be effective if voltage
does not scale too in turn.

Lorenzo
