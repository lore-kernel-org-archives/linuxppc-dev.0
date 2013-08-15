Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by ozlabs.org (Postfix) with ESMTP id 61D3A2C0222
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 06:10:12 +1000 (EST)
Date: Thu, 15 Aug 2013 23:10:00 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
Message-ID: <20130815201000.GB3067@blackmetal.musicnaut.iki.fi>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
 <9298823.WUCyZreP9q@vostro.rjw.lan>
 <1374614043.3916.84.camel@pasglop>
 <1376269668.32100.148.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376269668.32100.148.camel@pasglop>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nick Piggin <npiggin@suse.de>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Viresh Kumar <viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Aug 12, 2013 at 11:07:48AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2013-07-24 at 07:14 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2013-07-23 at 23:20 +0200, Rafael J. Wysocki wrote:
> > > All looks good in the patchset from 10000 feet (or more), but I need
> > > Ben to speak here.
> > 
> > I want to give it a quick spin on the HW here, I'll ack then. But yes,
> > it looks good.
> 
> Seems to work here on the quad G5.
> 
> However, If I use on-demand, there's a huge latency of switch as far as
> I can tell (about 10s) after I start/stop a bunch of CPU eaters... I
> quite like how the userspace "powernowd" which I used to use switches
> more aggressively.
> 
> Is that expected ?

I guess we should keep the current 12us latency in g5_neo2_cpufreq_init()
(although I doubt it's correct...), and only add the new 10ms latency
value to g5_pm72_cpufreq_init() - that way we can enable the older systems
to use ondemand (despite long latencies), while not risking regressing
any of the current functionality.

I'll resend the series with the changes.

A.
