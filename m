Return-Path: <rjwysocki@gmail.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNZY36FBczDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 22:59:51 +1000 (AEST)
Received: by mail-wm0-f51.google.com with SMTP id m124so71150930wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jun 2016 05:59:51 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAKohponw8wjFTXA+JyH0A2yXwtF4DxPSVCLcji4=yYV14OC3fw@mail.gmail.com>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <20160603234854.GF14579@graphite.smuckle.net>
 <20160606035231.GZ16176@vireshk-i7> <1649758.V7uyzAJShK@vostro.rjw.lan>
 <CAKohponw8wjFTXA+JyH0A2yXwtF4DxPSVCLcji4=yYV14OC3fw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Jun 2016 14:57:47 +0200
Message-ID: <CAJZ5v0hR+XM3KM1Q9c9_kK8n3QbkNzCr7V73m09-nP8KBKq=3Q@mail.gmail.com>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
To: Viresh Kumar <viresh.kumar@linaro.org>
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

On Mon, Jun 6, 2016 at 2:24 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 6 June 2016 at 17:40, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Monday, June 06, 2016 09:22:31 AM Viresh Kumar wrote:
>
>>> I agree with that, though that requires larger changes across multiple
>>> sites.
>>
>> What changes and where?
>
> s/larger/some :)
>
> So we can change all the callers of cpufreq_frequency_table_target(),

But why?

It just works as a static inline wrapper around cpufreq_find_index_l()
for the code in question after this patch, doesn't it?

So if the caller knows it will always ask for RELATION_L, why bother
with using the wrapper?

Also I'm wondering about the cpufreq_for_each_valid_entry() used all
over.  Can't the things be arranged so all of the entries are valid?
