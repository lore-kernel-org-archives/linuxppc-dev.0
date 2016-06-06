Return-Path: <viresh.kumar@linaro.org>
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com
 [209.85.216.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNYpC5RJmzDq7v
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 22:26:11 +1000 (AEST)
Received: by mail-qt0-f180.google.com with SMTP id 23so12976676qtq.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jun 2016 05:26:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1649758.V7uyzAJShK@vostro.rjw.lan>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <20160603234854.GF14579@graphite.smuckle.net>
 <20160606035231.GZ16176@vireshk-i7> <1649758.V7uyzAJShK@vostro.rjw.lan>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 6 Jun 2016 17:54:06 +0530
Message-ID: <CAKohponw8wjFTXA+JyH0A2yXwtF4DxPSVCLcji4=yYV14OC3fw@mail.gmail.com>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>,
 Steven Miao <realmz6@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6 June 2016 at 17:40, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, June 06, 2016 09:22:31 AM Viresh Kumar wrote:

>> I agree with that, though that requires larger changes across multiple
>> sites.
>
> What changes and where?

s/larger/some :)

So we can change all the callers of cpufreq_frequency_table_target(),
like the governors, ondemand-bias stub drivers, core, etc and call
the dedicated 'relation' specific routines directly, as we mostly know
in advance the 'relation' in which we want to update the freq.

And, so doing that with a dedicated patch might be better.

--
vireshj
