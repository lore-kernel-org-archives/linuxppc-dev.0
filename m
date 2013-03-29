Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f45.google.com (mail-oa0-f45.google.com
 [209.85.219.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EBDB2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 14:17:01 +1100 (EST)
Received: by mail-oa0-f45.google.com with SMTP id o6so146137oag.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 20:16:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B0B1178B6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1364464508-25393-1-git-send-email-Yuantian.Tang@freescale.com>
 <CAKohpomPubV=E_wCLyOR6X0PQNvrJpTc94950PEF+YUam9ituw@mail.gmail.com>
 <D07C73A334FF604B95B3CBD2A545D07B0B1178B6@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Fri, 29 Mar 2013 08:46:58 +0530
Message-ID: <CAKohpom9=HmVDvSVvgPC1zdzHmd+YpMU85SW34b9jun1dp6+HA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] cpufreq: Add cpufreq driver for Freescale e500mc
 SoCs
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "rjw@sisk.pl" <rjw@sisk.pl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29 March 2013 08:21, Tang Yuantian-B29983 <B29983@freescale.com> wrote:
>> > +static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy) {
>> > +       unsigned int cpu = policy->cpu;
>> > +       struct device_node *np;
>> > +       int i, count;
>> > +       struct clk *clk;
>> > +       struct cpufreq_frequency_table *table;
>> > +       struct cpu_data *data;
>> > +
>> > +       np = of_get_cpu_node(cpu, NULL);
>> > +       if (!np)
>> > +               return -ENODEV;
>> > +
>> > +       data = kzalloc(sizeof(struct cpu_data), GFP_KERNEL);
>>
>> I told you, you missed my comment earlier.
>>
>> You need to write: sizeof(*data) :(
>>
> This is new added statement, what you told last time is about the next kcalloc()...

I said about using sizeof() in generic, I copied below from my first
mail on this topic

> +       table = kcalloc(count + 1,

kzalloc??

> +                       sizeof(struct cpufreq_frequency_table), GFP_KERNEL);

sizeof(*table)

And you missed this one as you never replied to it. :)

> Are there some reasons that we can't use sizeof(struct cpu_data)
> instead of sizeof(*data)?

Documentation/CodiingStyle: Chapter 14: Allocating memory

>> > +       if (!table) {
>> > +               pr_err("%s: no memory\n", __func__);
>> > +               goto err_nomem2;
>> > +       }
>> > +
>> > +       for (i = cpu; i < freq_data.cpus_per_cluster + cpu; i++)
>> > +               cpumask_set_cpu(i, policy->cpus);
>>
>> I can see some regression here. Suppose you have two clusters of 4 cpus
>> each: (0123) and (4567).. Now at boot time above code will work perfectly
>> fine. Now you hot unplug 0,1,2,3 and then hotplug 3 in.
>>
>> Here, init would be called for cpu 3 and so you will end up saving 3456
>> in your policy->cpus
>>
>> :)
> Good catch.. will fix.

Thanks.
