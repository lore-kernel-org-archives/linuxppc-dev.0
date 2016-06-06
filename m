Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 3rNYMW0NDvzDq7v
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 22:06:30 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
Date: Mon, 06 Jun 2016 14:10:26 +0200
Message-ID: <1649758.V7uyzAJShK@vostro.rjw.lan>
In-Reply-To: <20160606035231.GZ16176@vireshk-i7>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <20160603234854.GF14579@graphite.smuckle.net>
 <20160606035231.GZ16176@vireshk-i7>
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

On Monday, June 06, 2016 09:22:31 AM Viresh Kumar wrote:
> On 03-06-16, 16:48, Steve Muckle wrote:
> > On Fri, Jun 03, 2016 at 07:05:14PM +0530, Viresh Kumar wrote:
> > ...
> > > @@ -468,20 +469,15 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > >  	struct acpi_cpufreq_data *data = policy->driver_data;
> > >  	struct acpi_processor_performance *perf;
> > >  	struct cpufreq_frequency_table *entry;
> > > -	unsigned int next_perf_state, next_freq, freq;
> > > +	unsigned int next_perf_state, next_freq, index;
> > >  
> > >  	/*
> > >  	 * Find the closest frequency above target_freq.
> > > -	 *
> > > -	 * The table is sorted in the reverse order with respect to the
> > > -	 * frequency and all of the entries are valid (see the initialization).
> > >  	 */
> > > -	entry = policy->freq_table;
> > > -	do {
> > > -		entry++;
> > > -		freq = entry->frequency;
> > > -	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
> > > -	entry--;
> > > +	index = cpufreq_frequency_table_target(policy, target_freq,
> > > +					       CPUFREQ_RELATION_L);
> > 
> > Can we call cpufreq_find_index_l directly here? Seems like we could
> > phase out cpufreq_frequency_table_target() for the most part and call
> > the helpers directly. It would avoid some code bloat, an unnecessary
> > switch statement and an error check for an invalid frequency table which
> > seems unnecessary for every frequency table lookup.
> 
> I agree with that, though that requires larger changes across multiple
> sites.

What changes and where?

> I hope it will be fine if I do it in a separate patch on top of
> all this. Right ?

Depending.
