Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 9F1F92C019B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 20:01:43 +1000 (EST)
Message-ID: <520B5584.7030608@arm.com>
Date: Wed, 14 Aug 2013 11:01:40 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com> <520A7B00.8060405@arm.com>
 <1376428024.4255.14.camel@pasglop>
In-Reply-To: <1376428024.4255.14.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Olof Johansson <olof@lixom.net>,
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

On 13/08/13 22:07, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-13 at 19:29 +0100, Sudeep KarkadaNagesha wrote:
>> I don't understand completely the use of ibm,ppc-interrupt-server#s and
>> its implications on generic of_get_cpu_node implementation.
>> I see the PPC specific definition of of_get_cpu_node uses thread id only
>> in 2 instances. Based on that, I have tried to move all the other
>> instances to use generic definition.
>>
>> Let me know if the idea is correct.
>=20
> No. The device-tree historically only represents cores, not HW threads, s=
o
> it makes sense to retrieve also the thread number corresponding to the CP=
U.
>=20
Ok

> However, the mechanism to represent HW threads in the device-tree is curr=
ently
> somewhat platform specific (the ibm,ppc-interrupt-server#s).
I see most of the callers pass NULL to thread id argument except 2
instances in entire tree. If that's the case why can't we move to use
generic of_get_cpu_node in most of those cases and have PPC specific
implementation for the ones using thread id.

>=20
> So what you could do for now is:
>=20
>  - Have a generic version that always returns 0 as the thread, which is w=
eak
I would prefer to move to generic of_get_cpu_node where ever possible
and rename the function that takes thread id rather than making generic
one weak.

>=20
>  - powerpc keeps its own implementation
How about only in cases where it needs thread_id.

>=20
>  - Start a discussion on the bindings (if not already there) to define th=
reads
> in a better way at which point the generic function can be updated.
>=20
I am not sure if we need to define any new bindings. Excerpts from ePAPR
(v1.1):
"3.7.1 General Properties of CPU nodes
The value of "reg" is a <prop-encoded-array> that defines a unique
CPU/thread id for the CPU/threads represented by the CPU node.
If a CPU supports more than one thread (i.e. multiple streams of
execution) the reg property is an array with 1 element per thread. The
#address-cells on the /cpus node specifies how many cells each element
of the array takes. Software can determine the number of threads by
dividing the size of reg by the parent node's #address-cells."

And this is exactly in agreement to what's implemented in the generic
of_get_cpu_node:

for_each_child_of_node(cpus, cpun) {
        if (of_node_cmp(cpun->type, "cpu"))
                continue;
        cell =3D of_get_property(cpun, "reg", &prop_len);
        if (!cell) {
                pr_warn("%s: missing reg property\n", cpun->full_name);
                continue;
        }
        prop_len /=3D sizeof(*cell);
        while (prop_len) {
                hwid =3D of_read_number(cell, ac);
                prop_len -=3D ac;
                if (arch_match_cpu_phys_id(cpu, hwid))
                        return cpun;
        }
}

Yes this doesn't cover the historical "ibm,ppc-interrupt-server#s", for
which we can have PPC specific wrapper above the generic one i.e. get
the cpu node and then parse for thread id under custom property.

Let me know your thoughts.

Regards,
Sudeep
