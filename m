Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A72661A0007
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:14:23 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id g62so10414491wme.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 10:14:23 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <2148611.GEpYdTfpoR@vostro.rjw.lan>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
 <3374654.Hks5DeSGVV@vostro.rjw.lan>
 <1443215827.32298.130.camel@freescale.com>
 <2148611.GEpYdTfpoR@vostro.rjw.lan>
Date: Fri, 26 Feb 2016 12:14:20 -0600
Message-ID: <CADRPPNRiU-9b5J_9+0ofk6huLCn4LPm1s_2yd=Py0eBBi9GGXg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock implementation
 details
From: Li Yang <leoli@freescale.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Scott Wood <scottwood@freescale.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 Russell King <linux@arm.linux.org.uk>, linux-clk@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Tang Yuantian <Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 25, 2015 at 4:50 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, September 25, 2015 04:17:07 PM Scott Wood wrote:
>> On Fri, 2015-09-25 at 23:42 +0200, Rafael J. Wysocki wrote:
>> > On Tuesday, September 22, 2015 12:46:54 PM Viresh Kumar wrote:
>> > > On 19-09-15, 23:29, Scott Wood wrote:
>> > > > Get the CPU clock's potential parent clocks from the clock interface
>> > > > itself, rather than manually parsing the clocks property to find a
>> > > > phandle, looking at the clock-names property of that, and assuming that
>> > > > those are valid parent clocks for the cpu clock.
>> > > >
>> > > > This is necessary now that the clocks are generated based on the clock
>> > > > driver's knowledge of the chip rather than a fragile device-tree
>> > > > description of the mux options.
>> > > >
>> > > > We can now rely on the clock driver to ensure that the mux only exposes
>> > > > options that are valid.  The cpufreq driver was currently being overly
>> > > > conservative in some cases -- for example, the "min_cpufreq =
>> > > > get_bus_freq()" restriction only applies to chips with erratum
>> > > > A-004510, and whether the freq_mask used on p5020 is needed depends on
>> > > > the actual frequencies of the PLLs (FWIW, p5040 has a similar
>> > > > limitation but its .freq_mask was zero) -- and the frequency mask
>> > > > mechanism made assumptions about particular parent clock indices that
>> > > > are no longer valid.
>> > > >
>> > > > Signed-off-by: Scott Wood <scottwood@freescale.com>
>> > > > ---
>> > > > v3: was patch 1/5 and patch 4/5, plus blacklist e6500 and changes
>> > > > to clk api usage
>> > > >
>> > > >  drivers/cpufreq/qoriq-cpufreq.c | 137 ++++++++++++---------------------
>> > > > -------
>> > > >  1 file changed, 40 insertions(+), 97 deletions(-)
>> > >
>> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >
>> > I'm wondering who's supposed to be merging this set?
>>
>> As I noted in the cover letter, I'm looking for acks so that I can apply
>> these to a topic branch which can be pulled through the PPC and ARM trees,
>> each of which will have patches that depend on it.
>
> OK, so no objections from the cpufreq side and you have the ACK from Viresh.

Hi Scott,

Did you drop this patch later?  I can not find it in 4.5-rc still.

Regards,
Leo
