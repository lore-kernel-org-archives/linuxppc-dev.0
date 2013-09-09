Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 94DBF2C0120
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2013 19:23:47 +1000 (EST)
Message-ID: <522D93D7.4010307@arm.com>
Date: Mon, 09 Sep 2013 10:24:39 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
 Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 12/19] cpufreq: cpufreq-cpu0: remove device tree parsing
 for cpu nodes
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <Pine.LNX.4.64.1309061539310.11068@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309061539310.11068@axis700.grange>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Jonas Bonn <jonas@southpole.se>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/09/13 14:44, Guennadi Liakhovetski wrote:
> Hi
>=20
> On Tue, 20 Aug 2013, Sudeep KarkadaNagesha wrote:
>=20
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Now that the cpu device registration initialises the of_node(if availabl=
e)
>> appropriately for all the cpus, parsing here is redundant.
>>
>> This patch removes all DT parsing and uses cpu->of_node instead.
>>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> ---
>>  drivers/cpufreq/cpufreq-cpu0.c | 23 ++++-------------------
>>  1 file changed, 4 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cp=
u0.=3D
>> c
>> index ad1fde2..5b05c26 100644
>> --- a/drivers/cpufreq/cpufreq-cpu0.c
>> +++ b/drivers/cpufreq/cpufreq-cpu0.c
>> @@ -174,29 +174,17 @@ static struct cpufreq_driver cpu0_cpufreq_driver =
=3D3D =3D
>> {
>> =3D20
>>  static int cpu0_cpufreq_probe(struct platform_device *pdev)
>>  {
>> -=3D09struct device_node *np, *parent;
>> +=3D09struct device_node *np;
>>  =3D09int ret;
>> =3D20
>> -=3D09parent =3D3D of_find_node_by_path("/cpus");
>> -=3D09if (!parent) {
>> -=3D09=3D09pr_err("failed to find OF /cpus\n");
>> -=3D09=3D09return -ENOENT;
>> -=3D09}
>> -
>> -=3D09for_each_child_of_node(parent, np) {
>> -=3D09=3D09if (of_get_property(np, "operating-points", NULL))
>> -=3D09=3D09=3D09break;
>> -=3D09}
>> +=3D09cpu_dev =3D3D &pdev->dev;
>> =3D20
>> +=3D09np =3D3D of_node_get(cpu_dev->of_node);
>=20
> Has this actually been tested? This seems to break cpufreq-cpu0. The=20
> reason is, that this probe function is called not for the DT CPU node, bu=
t=20
> for a special virtual cpufreq-cpu0 platform device, typically created by=
=20
> platforms, using
>=20
> =09platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
>=20
> which then of course doesn't have on .of_node associated with it.
>=20

Hi Guennadi,

Based on my understanding of the original code:
        cpu_dev =3D &pdev->dev;
=09...
=09ret =3D of_init_opp_table(cpu_dev);

of_init_opp_table needs cpu_dev to be get_cpu_device(0). My
understanding was that platform using cpufreq-cpu0 sets &pdev->dev to
get_cpu_device(0). But looks like that's not the case.

Hi Shawn,

Can you please clarify ? The fix would be as below but I would like to
know if setting cpu_dev to get_cpu_device(0) instead of &pdev->dev has
any impact on other parts of code using cpu_dev ?

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.=
c
index cbfffa9..871c336 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -177,7 +177,7 @@ static int cpu0_cpufreq_probe(struct platform_device
*pdev)
        struct device_node *np;
        int ret;

-       cpu_dev =3D &pdev->dev;
+       cpu_dev =3D get_cpu_device(0);

        np =3D of_node_get(cpu_dev->of_node);
        if (!np) {


Regards,
Sudeep
