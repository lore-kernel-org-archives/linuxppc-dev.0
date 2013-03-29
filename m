Return-Path: <B29983@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8921C2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 13:51:38 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: RE: [PATCH 2/2 v2] cpufreq: Add cpufreq driver for Freescale e500mc
 SoCs
Date: Fri, 29 Mar 2013 02:51:29 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B0B1178B6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1364464508-25393-1-git-send-email-Yuantian.Tang@freescale.com>
 <CAKohpomPubV=E_wCLyOR6X0PQNvrJpTc94950PEF+YUam9ituw@mail.gmail.com>
In-Reply-To: <CAKohpomPubV=E_wCLyOR6X0PQNvrJpTc94950PEF+YUam9ituw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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

> > +static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy) {
> > +       unsigned int cpu =3D policy->cpu;
> > +       struct device_node *np;
> > +       int i, count;
> > +       struct clk *clk;
> > +       struct cpufreq_frequency_table *table;
> > +       struct cpu_data *data;
> > +
> > +       np =3D of_get_cpu_node(cpu, NULL);
> > +       if (!np)
> > +               return -ENODEV;
> > +
> > +       data =3D kzalloc(sizeof(struct cpu_data), GFP_KERNEL);
>=20
> I told you, you missed my comment earlier.
>=20
> You need to write: sizeof(*data) :(
>=20
This is new added statement, what you told last time is about the next kcal=
loc()...

Are there some reasons that we can't use sizeof(struct cpu_data)
instead of sizeof(*data)?

> > +       if (!data)
> > +               return -ENOMEM;
> > +
> > +       data->clk =3D of_clk_get(np, 0);
> > +       data->parent =3D of_parse_phandle(np, "clocks", 0);
> > +       if (!data->parent) {
> > +               pr_err("%s: could not get clock information\n",
> __func__);
> > +               goto err_nomem2;
> > +       }
> > +
> > +       count =3D of_property_count_strings(data->parent,
> > + "clock-names");
> > +
> > +       table =3D kcalloc(count + 1,
> > +                       sizeof(struct cpufreq_frequency_table),
> > + GFP_KERNEL);
>=20
> sizeof(*table)
>=20
Ditto.

> > +       if (!table) {
> > +               pr_err("%s: no memory\n", __func__);
> > +               goto err_nomem2;
> > +       }
> > +
> > +       for (i =3D cpu; i < freq_data.cpus_per_cluster + cpu; i++)
> > +               cpumask_set_cpu(i, policy->cpus);
>=20
> I can see some regression here. Suppose you have two clusters of 4 cpus
> each: (0123) and (4567).. Now at boot time above code will work perfectly
> fine. Now you hot unplug 0,1,2,3 and then hotplug 3 in.
>=20
> Here, init would be called for cpu 3 and so you will end up saving 3456
> in your policy->cpus
>=20
> :)
Good catch.. will fix.

Regards,
Yuantian
