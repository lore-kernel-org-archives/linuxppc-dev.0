Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20D701A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 05:47:01 +1000 (AEST)
Received: by pacex6 with SMTP id ex6so17827434pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:46:58 -0700 (PDT)
Date: Tue, 22 Sep 2015 12:46:54 -0700
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Russell King <linux@arm.linux.org.uk>, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: Re: [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock
 implementation details
Message-ID: <20150922194654.GJ24314@linux>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
 <1442723397-26329-6-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442723397-26329-6-git-send-email-scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19-09-15, 23:29, Scott Wood wrote:
> Get the CPU clock's potential parent clocks from the clock interface
> itself, rather than manually parsing the clocks property to find a
> phandle, looking at the clock-names property of that, and assuming that
> those are valid parent clocks for the cpu clock.
> 
> This is necessary now that the clocks are generated based on the clock
> driver's knowledge of the chip rather than a fragile device-tree
> description of the mux options.
> 
> We can now rely on the clock driver to ensure that the mux only exposes
> options that are valid.  The cpufreq driver was currently being overly
> conservative in some cases -- for example, the "min_cpufreq =
> get_bus_freq()" restriction only applies to chips with erratum
> A-004510, and whether the freq_mask used on p5020 is needed depends on
> the actual frequencies of the PLLs (FWIW, p5040 has a similar
> limitation but its .freq_mask was zero) -- and the frequency mask
> mechanism made assumptions about particular parent clock indices that
> are no longer valid.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v3: was patch 1/5 and patch 4/5, plus blacklist e6500 and changes
> to clk api usage
> 
>  drivers/cpufreq/qoriq-cpufreq.c | 137 ++++++++++++----------------------------
>  1 file changed, 40 insertions(+), 97 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
