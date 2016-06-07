Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-f181.google.com (mail-pf0-f181.google.com
 [209.85.192.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNzBZ0g4XzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 14:30:14 +1000 (AEST)
Received: by mail-pf0-f181.google.com with SMTP id c2so899763pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jun 2016 21:30:13 -0700 (PDT)
Date: Tue, 7 Jun 2016 09:58:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Steve Muckle <steve.muckle@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Steven Miao <realmz6@gmail.com>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
Message-ID: <20160607042807.GC21466@vireshk-i7>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <20160603234854.GF14579@graphite.smuckle.net>
 <20160606035231.GZ16176@vireshk-i7>
 <1649758.V7uyzAJShK@vostro.rjw.lan>
 <CAKohponw8wjFTXA+JyH0A2yXwtF4DxPSVCLcji4=yYV14OC3fw@mail.gmail.com>
 <CAJZ5v0hR+XM3KM1Q9c9_kK8n3QbkNzCr7V73m09-nP8KBKq=3Q@mail.gmail.com>
 <CAKohpoms8AquTkv9ZB0w390eS2WcB2PeeNLVo4UUcwPNskwsBg@mail.gmail.com>
 <CAJZ5v0hG9X_zoHHFBiiZnn5x0rMfukF4RpFMxr73r3C0VzrUHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hG9X_zoHHFBiiZnn5x0rMfukF4RpFMxr73r3C0VzrUHw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06-06-16, 23:56, Rafael J. Wysocki wrote:
> Since you are adding new code, you can write it so it doesn't do
> unnecessary checks from the start.

Hmm, I will do all that in this series only now.

> While at it, the "if ((freq < policy->min) || (freq > policy->max))"
> checks in cpufreq_find_index_l() and cpufreq_find_index_h() don't look
> good to me, because they very well may cause those function to return
> -EINVAL even when there's a valid table and that may cause
> acpi_cpufreq_fast_switch() to do bad things.

Hmm. So, the checks are for sure required here, otherwise we may end up
returning a frequency which we aren't allowed to. Also note that 'freq' here
isn't the target-freq, but the entry in the freq-table.

This routine should be returning a valid freq within the ranges specified by
policy->min/max.

Also note that these routines shall *never* return -EINVAL, otherwise it is
mostly a bug we are hitting.

We have enough checks in place to make sure that there is at least one valid
entry in the freq-table which is >= policy->min and <= policy->max.

I will take care of rest of the comments though. Thanks.

-- 
viresh
