Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id C58481A03A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 07:21:00 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Scott Wood <scottwood@freescale.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: Re: [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock implementation
 details
Date: Fri, 25 Sep 2015 23:42:34 +0200
Message-ID: <3374654.Hks5DeSGVV@vostro.rjw.lan>
In-Reply-To: <20150922194654.GJ24314@linux>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
 <1442723397-26329-6-git-send-email-scottwood@freescale.com>
 <20150922194654.GJ24314@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, September 22, 2015 12:46:54 PM Viresh Kumar wrote:
> On 19-09-15, 23:29, Scott Wood wrote:
> > Get the CPU clock's potential parent clocks from the clock interface
> > itself, rather than manually parsing the clocks property to find a
> > phandle, looking at the clock-names property of that, and assuming that
> > those are valid parent clocks for the cpu clock.
> > 
> > This is necessary now that the clocks are generated based on the clock
> > driver's knowledge of the chip rather than a fragile device-tree
> > description of the mux options.
> > 
> > We can now rely on the clock driver to ensure that the mux only exposes
> > options that are valid.  The cpufreq driver was currently being overly
> > conservative in some cases -- for example, the "min_cpufreq =
> > get_bus_freq()" restriction only applies to chips with erratum
> > A-004510, and whether the freq_mask used on p5020 is needed depends on
> > the actual frequencies of the PLLs (FWIW, p5040 has a similar
> > limitation but its .freq_mask was zero) -- and the frequency mask
> > mechanism made assumptions about particular parent clock indices that
> > are no longer valid.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > v3: was patch 1/5 and patch 4/5, plus blacklist e6500 and changes
> > to clk api usage
> > 
> >  drivers/cpufreq/qoriq-cpufreq.c | 137 ++++++++++++----------------------------
> >  1 file changed, 40 insertions(+), 97 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm wondering who's supposed to be merging this set?

Rafael
