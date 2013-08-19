Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id B892E2C0116
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 20:13:14 +1000 (EST)
Message-ID: <5211EFC7.9090800@arm.com>
Date: Mon, 19 Aug 2013 11:13:27 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376691186.25016.4.camel@pasglop>
In-Reply-To: <1376691186.25016.4.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
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

On 16/08/13 23:13, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-16 at 18:39 +0100, Sudeep KarkadaNagesha wrote:
>> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
>> +                       const char *prop_name, int cpu, unsigned int
>> *thread)
>> +{
>> +       const __be32 *cell;
>> +       int ac, prop_len, tid;
>> +       u64 hwid;
>> +
>> +       ac =3D of_n_addr_cells(cpun);
>> +       cell =3D of_get_property(cpun, prop_name, &prop_len);
>> +       if (!cell)
>> +               return false;
>> +       prop_len /=3D sizeof(*cell);
>> +       for (tid =3D 0; tid < prop_len; tid++) {
>> +               hwid =3D of_read_number(cell, ac);
>> +               if (arch_match_cpu_phys_id(cpu, hwid)) {
>> +                       if (thread)
>> +                               *thread =3D tid;
>> +                       return true;
>> +               }
>> +               cell +=3D ac;
>> +       }
>> +       return false;
>> +}
>=20
> The only problem I can see here is if "ac" is not 1, that will not work
> for the ibm,ppc-interrupt-server#s case. IE. The latter is always 1 cell
> per entry, only "reg" depends on #address-cells.
>=20
> However that's only a theorical problem since on ppc #address-cells of
> /cpus is always 1...
>=20
Ok agreed, but I assume in future if thread ids need 2 ac, it would use
standard 'reg' instead of 'ibm,ppc-interrupt-server#' property.

So I assume the above function is generic and need not be modified to
handle non '1' ac case  with non standard 'ibm,ppc-interrupt-server#'.

Regards,
Sudeep
