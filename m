Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNLPd3VlNzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 13:52:36 +1000 (AEST)
Received: by mail-pf0-x22b.google.com with SMTP id z187so8410571pfz.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jun 2016 20:52:36 -0700 (PDT)
Date: Mon, 6 Jun 2016 09:22:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>,
 Steven Miao <realmz6@gmail.com>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
Message-ID: <20160606035231.GZ16176@vireshk-i7>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <e155257e7f76c3dc71f9347e0433fb1e4d9a3358.1464960877.git.viresh.kumar@linaro.org>
 <20160603234854.GF14579@graphite.smuckle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160603234854.GF14579@graphite.smuckle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03-06-16, 16:48, Steve Muckle wrote:
> On Fri, Jun 03, 2016 at 07:05:14PM +0530, Viresh Kumar wrote:
> ...
> > @@ -468,20 +469,15 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> >  	struct acpi_cpufreq_data *data = policy->driver_data;
> >  	struct acpi_processor_performance *perf;
> >  	struct cpufreq_frequency_table *entry;
> > -	unsigned int next_perf_state, next_freq, freq;
> > +	unsigned int next_perf_state, next_freq, index;
> >  
> >  	/*
> >  	 * Find the closest frequency above target_freq.
> > -	 *
> > -	 * The table is sorted in the reverse order with respect to the
> > -	 * frequency and all of the entries are valid (see the initialization).
> >  	 */
> > -	entry = policy->freq_table;
> > -	do {
> > -		entry++;
> > -		freq = entry->frequency;
> > -	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
> > -	entry--;
> > +	index = cpufreq_frequency_table_target(policy, target_freq,
> > +					       CPUFREQ_RELATION_L);
> 
> Can we call cpufreq_find_index_l directly here? Seems like we could
> phase out cpufreq_frequency_table_target() for the most part and call
> the helpers directly. It would avoid some code bloat, an unnecessary
> switch statement and an error check for an invalid frequency table which
> seems unnecessary for every frequency table lookup.

I agree with that, though that requires larger changes across multiple
sites. I hope it will be fine if I do it in a separate patch on top of
all this. Right ?

-- 
viresh
