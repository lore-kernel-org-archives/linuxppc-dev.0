Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 731902C0155
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:24:04 +1000 (EST)
Message-ID: <52121C84.1030102@arm.com>
Date: Mon, 19 Aug 2013 14:24:20 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH v2 4/4] of: move of_get_cpu_node implementation to
 DT core library
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <5212196F.4060708@gmail.com>
In-Reply-To: <5212196F.4060708@gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Jonas Bonn <jonas@southpole.se>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
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

On 19/08/13 14:11, Rob Herring wrote:
> On 08/16/2013 12:39 PM, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> This patch moves the generalized implementation of of_get_cpu_node from
>> PowerPC to DT core library, thereby adding support for retrieving cpu
>> node for a given logical cpu index on any architecture.
>>
>> The CPU subsystem can now use this function to assign of_node in the
>> cpu device while registering CPUs.
>>
>> It is recommended to use these helper function only in pre-SMP/early
>> initialisation stages to retrieve CPU device node pointers in logical
>> ordering. Once the cpu devices are registered, it can be retrieved easil=
y
>> from cpu device of_node which avoids unnecessary parsing and matching.
>>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>=20
> [snip]
>=20
>> +/**
>> + * of_get_cpu_node - Get device node associated with the given logical =
CPU
>> + *
>> + * @cpu: CPU number(logical index) for which device node is required
>> + * @thread: if not NULL, local thread number within the physical core i=
s
>> + *          returned
>> + *
>> + * The main purpose of this function is to retrieve the device node for=
 the
>> + * given logical CPU index. It should be used to initialize the of_node=
 in
>> + * cpu device. Once of_node in cpu device is populated, all the further
>> + * references can use that instead.
>> + *
>> + * CPU logical to physical index mapping is architecture specific and i=
s built
>> + * before booting secondary cores. This function uses arch_match_cpu_ph=
ys_id
>> + * which can be overridden by architecture specific implementation.
>> + *
>> + * Returns a node pointer for the logical cpu if found, else NULL.
>> + */
>> +struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
>> +{
>> +=09struct device_node *cpun, *cpus;
>> +
>> +=09cpus =3D of_find_node_by_path("/cpus");
>> +=09if (!cpus) {
>> +=09=09pr_warn("Missing cpus node, bailing out\n");
>> +=09=09return NULL;
>> +=09}
>> +
>> +=09for_each_child_of_node(cpus, cpun) {
>> +=09=09if (of_node_cmp(cpun->type, "cpu"))
>> +=09=09=09continue;
>> +#ifdef CONFIG_PPC
>=20
> You don't really need this ifdef as this function should never succeed
> on other arches. Alternatively, you can use "IS_ENABLED(CONFIG_PPC)"
> instead.
>=20
Agreed, I can remove it as long as no other architecture use that
property. It's just to avoid checking for it on other architectures.
I will use IS_ENABLED as you suggested.

> Otherwise,
>=20
> Acked-by: Rob Herring <rob.herring@calxeda.com>
>=20
Thanks.

Regards,
Sudeep
