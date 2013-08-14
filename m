Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id F0A3E2C0191
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 19:23:04 +1000 (EST)
Message-ID: <520B4C76.8020900@arm.com>
Date: Wed, 14 Aug 2013 10:23:02 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
References: <5208E2D3.7060005@arm.com> <520A536C.3030600@arm.com>
 <CAL_JsqJdGXuTmb2kgBwgmRYGs9f92-dsawDXSXjmJW8cwjFVQQ@mail.gmail.com>
 <1974929.8mIZF44QnT@vostro.rjw.lan>
In-Reply-To: <1974929.8mIZF44QnT@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Rob Herring <robherring2@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/08/13 20:45, Rafael J. Wysocki wrote:
> On Tuesday, August 13, 2013 01:44:23 PM Rob Herring wrote:
>> On Tue, Aug 13, 2013 at 10:40 AM, Sudeep KarkadaNagesha
>> <Sudeep.KarkadaNagesha@arm.com> wrote:
>>> Adding PowerPC list
>>>
>>> On 13/08/13 14:00, Rafael J. Wysocki wrote:
>>>> On Monday, August 12, 2013 02:27:47 PM Sudeep KarkadaNagesha wrote:
>>>>> The following changes since commit
>>>>> d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
>>>>>
>>>>> Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
>>>>>
>>>>> are available in the git repository at:
>>>>>
>>>>> git://linux-arm.org/linux-skn.git cpu_of_node
>>
>> [snip]
>>
>>>> All error/warnings:
>>>>
>>>> warning: (MPC836x_RDK && MTD_NAND_FSL_ELBC && MTD_NAND_FSL_UPM)
>>>> selects FSL_LBC which has unmet direct dependencies (FSL_SOC)
>>>> warning: (MPC836x_RDK && MTD_NAND_FSL_ELBC && MTD_NAND_FSL_UPM)
>>>> selects FSL_LBC which has unmet direct dependencies (FSL_SOC)
>>>> In file included from arch/powerpc/include/asm/kvm_para.h:26:0, from
>>>> include/uapi/linux/kvm_para.h:26, from include/linux/kvm_para.h:4,
>>>> from include/linux/kvm_host.h:30, from
>>>> arch/powerpc/kernel/asm-offsets.c:53:
>>>> include/linux/of.h:269:28: error: conflicting types for
>>>> 'of_get_cpu_node'
>>>> extern struct device_node *of_get_cpu_node(int cpu); ^ In file
>>>> included from include/linux/of.h:139:0, from
>>>> arch/powerpc/include/asm/kvm_para.h:26, from
>>>> include/uapi/linux/kvm_para.h:26, from include/linux/kvm_para.h:4,
>>>> from include/linux/kvm_host.h:30, from
>>>> arch/powerpc/kernel/asm-offsets.c:53:
>>>> arch/powerpc/include/asm/prom.h:47:21: note: previous declaration
>>>> of 'of_get_cpu_node' was here
>>>> struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
>>>> ^ make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1 make[2]:
>>>> Target `__build' not remade because of errors. make[1]: ***
>>>> [prepare0] Error 2 make[1]: Target `prepare' not remade because of
>>>> errors. make: *** [sub-make] Error 2
>>>>
>>>
>>> There seems to be conflict in the new function "of_get_cpu_node" added.
>>> PowerPC also defines the same function name. Further microblaze and
>>> openrisc declares it(can be removed) but doesn't define it.
>>> To fix this:
>>> 1. I can rename the newly added function to something different like
>>>    `of_get_cpunode` or
>>> 2. If of_* namespace should be used by only OF/FDT and not by any
>>>    architecture specific code, then the arch specific version can be
>>>    renamed to some thing like arch_of_get_cpu_node.
>>>    Also most of the calls to arch specific function can be moved to
>>>    generic code.
>>>
>>> Let me know your thoughts.
>>
>> It is up to Rafael if he is willing/able to rebase his tree, but I
>> would drop this series until this is sorted out.
>=20
> Yeah, I've just done that.
>=20
Thanks Rafael, sorry for the trouble. I didn't expect of_* name-space to
be used in ARCH specific code.

>> I think the new common function should be and can be generalized to work=
 for
>> powerpc.
>> It would need to make reg property optional and pass in the device
>> node to the arch specific function.
>>
>> A short term solution would be just to make the function "#ifndef CONFIG=
_PPC".
>=20
> I wouldn't do that, it's almost guaranteed to be messy going forward.
>=20
> I'd go for 1 above personally.

Even though it's easier approach, I would go for fixing PPC and converge
at generic of_get_cpu_node implementation if possible.

Regards,
Sudeep
