Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCJ7q1TGgzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 May 2016 20:39:19 +1000 (AEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rCJ7p6CjMz9sp7
 for <linuxppc-dev@ozlabs.org>; Sun, 22 May 2016 20:39:18 +1000 (AEST)
Date: Sun, 22 May 2016 12:39:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Message-ID: <20160522103912.GN3193@twins.programming.kicks-ass.net>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
 <20160519114029.GW3193@twins.programming.kicks-ass.net>
 <201605201223.u4KCNWn9028105@mx0a-001b2d01.pphosted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201605201223.u4KCNWn9028105@mx0a-001b2d01.pphosted.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 20, 2016 at 05:53:41PM +0530, Shilpasri G Bhat wrote:
> 
> Below are the comparisons by disabling watchdog.
> Both schedutil and ondemand have a similar ramp-down trend. And in both the
> cases I can see that frequency of the cpu is not reduced in deterministic
> fashion. In a observation window of 30 seconds after running a workload I can
> see that the frequency is not ramped down on some cpus in the system and are
> idling at max frequency.

So does it actually matter what the frequency is when you idle? Isn't
the whole thing clock gated anyway?

Because this seems to generate contradictory requirements, on the one
hand we want to stay idle as long as possible while on the other hand
you seem to want to clock down while idle, which requires not being
idle.

If it matters; should not your idle state muck explicitly set/restore
frequency?
