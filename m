Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 809661A001B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 10:17:01 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
Date: Thu, 14 May 2015 02:42:11 +0200
Message-ID: <3381363.cclTYyKPz9@vostro.rjw.lan>
In-Reply-To: <CAMAWPa_69wXtOAKkerLcXN3AcCMC7oBCH_K3MQ-A7A8nmXQzfQ@mail.gmail.com>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <1842725.60y5FMGEPh@vostro.rjw.lan>
 <CAMAWPa_69wXtOAKkerLcXN3AcCMC7oBCH_K3MQ-A7A8nmXQzfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rlippert@google.com, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Lina Iyer <lina.iyer@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, May 13, 2015 05:13:27 PM Kevin Hilman wrote:
> On Wed, May 13, 2015 at 5:16 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, May 13, 2015 03:59:55 PM Kevin Hilman wrote:
> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> >>
> >> [...]
> >>
> >> > Second, quite honestly, I don't see a connection to genpd here.
> >>
> >> The connection with genpd is because the *reason* the timer was
> >> shutdown/stopped is because it shares power with the CPU, which is why
> >> the timer stops when the CPU hits ceratin low power states.  IOW, it's
> >> in the same power domain as the CPU.
> >
> > Well, what if you don't have genpd on that system?  Is the problem at hand not
> > relevant then magically?
> 
> Well, if you're not using genpd to model hardware power domain
> dependencies, then yes you'll definitely need a different solution.
> 
> And, as we discussed on IRC.  If you only care about timers, and genpd
> is not in use, then $SUBJECT series is a fine approach, and I have no
> objections.  But for SoCs where there are several other things that
> share power with CPU, we need a more generic, genpd based solution,
> which it seems we're in agreement on.  And since the two approaches
> are not mutually exclusive, then I have real objections to applying
> this series.

I guess a "no" is missing in the last sentence. ;-)

> Acked-by: Kevin Hilman <khilman@linaro.org>

Thanks!

Rafael
