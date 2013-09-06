Return-Path: <SRS0=iwe1=SU=gmx.de=g.liakhovetski@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 061DA2C0122
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2013 01:29:09 +1000 (EST)
Date: Fri, 6 Sep 2013 15:44:12 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH v4 12/19] cpufreq: cpufreq-cpu0: remove device tree
 parsing for cpu nodes
In-Reply-To: <1376991021-12160-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <Pine.LNX.4.64.1309061539310.11068@axis700.grange>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonas Bonn <jonas@southpole.se>, devicetree@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

On Tue, 20 Aug 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Now that the cpu device registration initialises the of_node(if available)
> appropriately for all the cpus, parsing here is redundant.
> 
> This patch removes all DT parsing and uses cpu->of_node instead.
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.=
> c
> index ad1fde2..5b05c26 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -174,29 +174,17 @@ static struct cpufreq_driver cpu0_cpufreq_driver =3D =
> {
> =20
>  static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  {
> -=09struct device_node *np, *parent;
> +=09struct device_node *np;
>  =09int ret;
> =20
> -=09parent =3D of_find_node_by_path("/cpus");
> -=09if (!parent) {
> -=09=09pr_err("failed to find OF /cpus\n");
> -=09=09return -ENOENT;
> -=09}
> -
> -=09for_each_child_of_node(parent, np) {
> -=09=09if (of_get_property(np, "operating-points", NULL))
> -=09=09=09break;
> -=09}
> +=09cpu_dev =3D &pdev->dev;
> =20
> +=09np =3D of_node_get(cpu_dev->of_node);

Has this actually been tested? This seems to break cpufreq-cpu0. The 
reason is, that this probe function is called not for the DT CPU node, but 
for a special virtual cpufreq-cpu0 platform device, typically created by 
platforms, using

	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);

which then of course doesn't have on .of_node associated with it.

Thanks
Guennadi

>  =09if (!np) {
>  =09=09pr_err("failed to find cpu0 node\n");
> -=09=09ret =3D -ENOENT;
> -=09=09goto out_put_parent;
> +=09=09return -ENOENT;
>  =09}
> =20
> -=09cpu_dev =3D &pdev->dev;
> -=09cpu_dev->of_node =3D np;
> -
>  =09cpu_reg =3D devm_regulator_get(cpu_dev, "cpu0");
>  =09if (IS_ERR(cpu_reg)) {
>  =09=09/*
> @@ -269,15 +257,12 @@ static int cpu0_cpufreq_probe(struct platform_device =
> *pdev)
>  =09}
> =20
>  =09of_node_put(np);
> -=09of_node_put(parent);
>  =09return 0;
> =20
>  out_free_table:
>  =09opp_free_cpufreq_table(cpu_dev, &freq_table);
>  out_put_node:
>  =09of_node_put(np);
> -out_put_parent:
> -=09of_node_put(parent);
>  =09return ret;
>  }
> =20
> --=20
> 1.8.1.2
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
