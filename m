Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Tdw08FhzDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 21:40:36 +1000 (AEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r9Tdv4p6qz9snm
 for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2016 21:40:35 +1000 (AEST)
Date: Thu, 19 May 2016 13:40:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Message-ID: <20160519114029.GW3193@twins.programming.kicks-ass.net>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 18, 2016 at 11:11:51PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 18, 2016 at 2:53 PM, Shilpasri G Bhat
> <shilpa.bhat@linux.vnet.ibm.com> wrote:
> > This patch adds driver callback for fast_switch and below observations
> > on schedutil governor are done with this patch.
> >
> > In POWER8 there is a regression observed with schedutil compared to
> > ondemand. With schedutil the frequency is not ramping down and is
> > mostly stuck at max frequency during idle . This is because of the
> > watchdog timer, an RT task which is fired every 4 seconds which
> > results in requesting max frequency.
> 
> Well, yes, that would be problematic.
> 

Right; we need to come up with something for RT tasks; but what happens
if you disable the watchdog? This should be entirely doable and might
give a better comparison.
