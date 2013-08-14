Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 311B32C0205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:21:47 +1000 (EST)
Message-ID: <520B8468.7050307@arm.com>
Date: Wed, 14 Aug 2013 14:21:44 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com> <520A7B00.8060405@arm.com>
 <1376428024.4255.14.camel@pasglop> <520B5584.7030608@arm.com>
 <1376480227.4255.66.camel@pasglop>
In-Reply-To: <1376480227.4255.66.camel@pasglop>
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

On 14/08/13 12:37, Benjamin Herrenschmidt wrote:
> On Wed, 2013-08-14 at 11:01 +0100, Sudeep KarkadaNagesha wrote:
>> Yes this doesn't cover the historical "ibm,ppc-interrupt-server#s",
>> for
>> which we can have PPC specific wrapper above the generic one i.e. get
>> the cpu node and then parse for thread id under custom property.
>=20
> A wrapper is wrong. I don't want to have to have all ppc callers to use
> a different function.
Ok.

On the side note the main intention of this patch series[1] is to avoid
calling of_get_cpu_node function once CPU devices are registered. It
initialises the of_node in all the cpu devices using this function when
registering the CPU device. It can be retrieved from cpu_dev->of_node.
So direct users of of_get_cpu_node can be reduced to avoid unnecessary
parsing of DT to find cpu node.

>=20
> As I said, just make a generic one that returns a thread ID, ie, same
> signature as the powerpc one. Make it weak, we can override it in
> powerpc-land,
IMO, making generic definition which adhere to the ePAPR specification
as weak is not so clean.

> or we can move the ibm,ppc-interrupt-server#s handling
> into the generic one, it won't hurt, but leave the thread_id return
> there, it doesn't hurt it will come in handy in a few cases without
> causing code duplication.
>=20

IMO moving of handling ibm,ppc-interrupt-server#s to generic code under
#ifdef CONFIG_PPC seems to be cleaner approach than weak definitation.

As per my understanding each thread is a different logical cpu.
Each logical cpu is mapped to unique physical id(either present in reg
field or legacy ibm,ppc-interrupt-server#s field). So given a logical
cpu id we can get the cpu node corresponding to it.
Looking @ smp_setup_cpu_maps in arch/powerpc/kernel/setup-common.c
and the comment in the same file: "This implementation only supports
power of 2 number of threads.." the thread id id is implicit in the
logical cpu id. Do we need to fetch that from DT ?

Regards,
Sudeep

[1] https://lkml.org/lkml/2013/7/22/219
