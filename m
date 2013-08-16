Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 9D5A52C0200
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 18:48:17 +1000 (EST)
Message-ID: <520DE753.8090601@arm.com>
Date: Fri, 16 Aug 2013 09:48:19 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376628563.4255.137.camel@pasglop>
In-Reply-To: <1376628563.4255.137.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Jonas Bonn <jonas@southpole.se>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
 "linux@openrisc.net" <linux@openrisc.net>,
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

On 16/08/13 05:49, Benjamin Herrenschmidt wrote:
> On Thu, 2013-08-15 at 18:09 +0100, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Currently different drivers requiring to access cpu device node are
>> parsing the device tree themselves. Since the ordering in the DT need
>> not match the logical cpu ordering, the parsing logic needs to consider
>> that. However, this has resulted in lots of code duplication and in some
>> cases even incorrect logic.
>=20
>  .../...
>=20
>> =20
>> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>> +{
>> +=09return (int)phys_id =3D=3D get_hard_smp_processor_id(cpu);
>> +}
>=20
> Naming is a bit gross. You might want to make it clearer that
> we are talking about CPU IDs in the device-tree here.
>=20
Any particular preference to the name or just a note is sufficient.
Also unlike PPC, in ARM we don't set hard processor id value based
values read from device tree. DT must contain the values matching to the
hardware ID registers.

>> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
>> +=09=09=09const char *prop_name, int cpu, unsigned int *thread)
>> +{
>> +=09const __be32 *cell;
>> +=09int ac, prop_len, tid;
>> +=09u64 hwid;
>> +
>> +=09ac =3D of_n_addr_cells(cpun);
>> +=09cell =3D of_get_property(cpun, prop_name, &prop_len);
>> +=09if (!cell)
>> +=09=09return false;
>> +=09prop_len /=3D sizeof(*cell);
>> +=09for (tid =3D 0; tid < prop_len; tid++) {
>> +=09=09hwid =3D of_read_number(cell, ac);
>> +=09=09if (arch_match_cpu_phys_id(cpu, hwid)) {
>> +=09=09=09if (thread)
>> +=09=09=09=09*thread =3D tid;
>> +=09=09=09return true;
>> +=09=09}
>=20
> Missing:          cell +=3D ac;
Ah, missed it while refactoring, will fix it. Thanks

Regards,
Sudeep
