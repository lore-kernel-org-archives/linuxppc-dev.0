Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCtQy4cwRzDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 19:24:26 +1000 (AEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rCtQy2Pvdz9sds
 for <linuxppc-dev@ozlabs.org>; Mon, 23 May 2016 19:24:26 +1000 (AEST)
Date: Mon, 23 May 2016 11:24:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Message-ID: <20160523092416.GE15728@worktop.ger.corp.intel.com>
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

Oh agreed, completely platform dependent. 'Luckily' all this cpuidle is
already very platform dependent.

> It is also true that there is power spent going to fmin (and then
> perhaps restoring the frequency when idle ends) which will be in part a
> function of how slow the frequency change operation is on that platform.

Agreed.

> I think Daniel Lezcano (added) was exploring the idea of having cpuidle
> drivers take the expected idle duration and potentially communicate to
> cpufreq to reduce the frequency depending on a platform-specific
> cost/benefit analysis.

Right; that's along the lines I was thinking. If the idle guestimate and
the idle QoS both allow (ie. it wins on power and doesn't violate
wake-up latency) muck with DVSF on the idle path.
