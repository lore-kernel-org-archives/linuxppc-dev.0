Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id C1E2E1A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 04:13:16 +1100 (AEDT)
Message-ID: <551AD5E4.2040103@arm.com>
Date: Tue, 31 Mar 2015 18:14:12 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC/RFT,
 RESEND] powerpc: move cacheinfo sysfs to generic cacheinfo
 infrastructure
References: <20150331105637.39B451400DE@ozlabs.org>
In-Reply-To: <20150331105637.39B451400DE@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Sudeep Holla <sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 31/03/15 11:56, Michael Ellerman wrote:
> On Mon, 2015-23-02 at 18:18:20 UTC, Sudeep Holla wrote:
>> This patch removes the redundant sysfs cacheinfo code by reusing
>> the newly introduced generic cacheinfo infrastructure through the
>> commit 246246cbde5e ("drivers: base: support cpu cache information
>> interface to userspace via sysfs")
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>>   arch/powerpc/kernel/cacheinfo.c | 811 +++++-----------------------------------
>>   arch/powerpc/kernel/cacheinfo.h |   8 -
>>   arch/powerpc/kernel/sysfs.c     |  12 +-
>>   3 files changed, 91 insertions(+), 740 deletions(-)
>>   delete mode 100644 arch/powerpc/kernel/cacheinfo.h
>>
>> Hi,
>>
>> This patch is not tested. Last time Anshuman tested, he had seen issues.
>> The core driver has changed a lot after that. Since PPC depends a lot
>> on DT for cache information, there might be issues in the core later
>> which I could not identify with ARM/ARM64. It would be much appreciable
>> if someone help me in testing and fixing those so that PPC can migrate
>> to new/common cacheinfo infrastructure. This resend is rebased on v4.0-rc1
>
> Doesn't build for me.
>
>    arch/powerpc/platforms/pseries/suspend.c:29:36: fatal error: ../../kernel/cacheinfo.h: No such file or directory
>    #include "../../kernel/cacheinfo.h"
>

Right, sorry for missing this. I just tested corenet32_smp_defconfig.
Also after some digging I found that this patch was written before the
commit 6b36ba8492ab (" powerpc/pseries: Update dynamic cache nodes for
suspend/resume operation"). I had a quick looks at that patch and I am
not sure if we can support that with generic cacheinfo implementation.

> Anshuman must have worked around that somehow to test it previously?
>

I think he tried before the above mentioned commit was introduced.

> Removing the include doesn't fix it, it needs cacheinfo_cpu_on/offline().
>

I agree, had a quick look at that, and it requires some rework not sure
if that should be in generic code or ppc specific.

Regards,
Sudeep
