Return-Path: <sudeep.holla@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 7C4052C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Mar 2014 22:27:46 +1100 (EST)
Message-ID: <531D9E3A.7040109@arm.com>
Date: Mon, 10 Mar 2014 11:12:58 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC/RFT v3 6/9] powerpc: move cacheinfo sysfs to generic
 cacheinfo infrastructure
References: <1392825976-17633-1-git-send-email-sudeep.holla@arm.com>
 <1392825976-17633-7-git-send-email-sudeep.holla@arm.com>
 <531945D1.7010503@linux.vnet.ibm.com> <531963D9.5040701@linux.vnet.ibm.com>
In-Reply-To: <531963D9.5040701@linux.vnet.ibm.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anshuman,

On 07/03/14 06:14, Anshuman Khandual wrote:
> On 03/07/2014 09:36 AM, Anshuman Khandual wrote:
>> On 02/19/2014 09:36 PM, Sudeep Holla wrote:
>>> From: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> This patch removes the redundant sysfs cacheinfo code by making use of
>>> the newly introduced generic cacheinfo infrastructure.
>>>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> ---
>>>   arch/powerpc/kernel/cacheinfo.c | 831 ++++++-------------------------=
---------
>>>   arch/powerpc/kernel/cacheinfo.h |   8 -
>>>   arch/powerpc/kernel/sysfs.c     |   4 -
>>>   3 files changed, 109 insertions(+), 734 deletions(-)
>>>   delete mode 100644 arch/powerpc/kernel/cacheinfo.h
>>>
>>> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cach=
einfo.c
>>> index 2912b87..05b7580 100644
>>> --- a/arch/powerpc/kernel/cacheinfo.c
>>> +++ b/arch/powerpc/kernel/cacheinfo.c
>>> @@ -10,38 +10,10 @@
>>>    * 2 as published by the Free Software Foundation.
>>>    */
>>>
>>> +#include <linux/cacheinfo.h>
>>>   #include <linux/cpu.h>
>>> -#include <linux/cpumask.h>
>>>   #include <linux/kernel.h>
>>> -#include <linux/kobject.h>
>>> -#include <linux/list.h>
>>> -#include <linux/notifier.h>
>>>   #include <linux/of.h>
>>> -#include <linux/percpu.h>
>>> -#include <linux/slab.h>
>>> -#include <asm/prom.h>
>>> -
>>> -#include "cacheinfo.h"
>>> -
>>> -/* per-cpu object for tracking:
>>> - * - a "cache" kobject for the top-level directory
>>> - * - a list of "index" objects representing the cpu's local cache hier=
archy
>>> - */
>>> -struct cache_dir {
>>> -=09struct kobject *kobj; /* bare (not embedded) kobject for cache
>>> -=09=09=09       * directory */
>>> -=09struct cache_index_dir *index; /* list of index objects */
>>> -};
>>> -
>>> -/* "index" object: each cpu's cache directory has an index
>>> - * subdirectory corresponding to a cache object associated with the
>>> - * cpu.  This object's lifetime is managed via the embedded kobject.
>>> - */
>>> -struct cache_index_dir {
>>> -=09struct kobject kobj;
>>> -=09struct cache_index_dir *next; /* next index in parent directory */
>>> -=09struct cache *cache;
>>> -};
>>>
>>>   /* Template for determining which OF properties to query for a given
>>>    * cache type */
>>> @@ -60,11 +32,6 @@ struct cache_type_info {
>>>   =09const char *nr_sets_prop;
>>>   };
>>>
>>> -/* These are used to index the cache_type_info array. */
>>> -#define CACHE_TYPE_UNIFIED     0
>>> -#define CACHE_TYPE_INSTRUCTION 1
>>> -#define CACHE_TYPE_DATA        2
>>> -
>>>   static const struct cache_type_info cache_type_info[] =3D {
>>>   =09{
>>>   =09=09/* PowerPC Processor binding says the [di]-cache-*
>>> @@ -77,246 +44,115 @@ static const struct cache_type_info cache_type_in=
fo[] =3D {
>>>   =09=09.nr_sets_prop    =3D "d-cache-sets",
>>>   =09},
>>>   =09{
>>> -=09=09.name            =3D "Instruction",
>>> -=09=09.size_prop       =3D "i-cache-size",
>>> -=09=09.line_size_props =3D { "i-cache-line-size",
>>> -=09=09=09=09     "i-cache-block-size", },
>>> -=09=09.nr_sets_prop    =3D "i-cache-sets",
>>> -=09},
>>> -=09{
>>>   =09=09.name            =3D "Data",
>>>   =09=09.size_prop       =3D "d-cache-size",
>>>   =09=09.line_size_props =3D { "d-cache-line-size",
>>>   =09=09=09=09     "d-cache-block-size", },
>>>   =09=09.nr_sets_prop    =3D "d-cache-sets",
>>>   =09},
>>> +=09{
>>> +=09=09.name            =3D "Instruction",
>>> +=09=09.size_prop       =3D "i-cache-size",
>>> +=09=09.line_size_props =3D { "i-cache-line-size",
>>> +=09=09=09=09     "i-cache-block-size", },
>>> +=09=09.nr_sets_prop    =3D "i-cache-sets",
>>> +=09},
>>>   };
>>
>>
>> Hey Sudeep,
>>
>> After applying this patch, the cache_type_info array looks like this.
>>
>> static const struct cache_type_info cache_type_info[] =3D {
>>          {
>>                  /*
>>                   * PowerPC Processor binding says the [di]-cache-*
>>                   * must be equal on unified caches, so just use
>>                   * d-cache properties.
>>                   */
>>                  .name            =3D "Unified",
>>                  .size_prop       =3D "d-cache-size",
>>                  .line_size_props =3D { "d-cache-line-size",
>>                                       "d-cache-block-size", },
>>                  .nr_sets_prop    =3D "d-cache-sets",
>>          },
>>          {
>>                  .name            =3D "Data",
>>                  .size_prop       =3D "d-cache-size",
>>                  .line_size_props =3D { "d-cache-line-size",
>>                                       "d-cache-block-size", },
>>                  .nr_sets_prop    =3D "d-cache-sets",
>>          },
>>          {
>>                  .name            =3D "Instruction",
>>                  .size_prop       =3D "i-cache-size",
>>                  .line_size_props =3D { "i-cache-line-size",
>>                                       "i-cache-block-size", },
>>                  .nr_sets_prop    =3D "i-cache-sets",
>>          },
>> };
>>
>> and this function computes the the array index for any given cache type
>> define for PowerPC.
>>
>> static inline int get_cacheinfo_idx(enum cache_type type)
>> {
>>          if (type =3D=3D CACHE_TYPE_UNIFIED)
>>                  return 0;
>>          else
>>                  return type;
>> }
>>
>> These types are define in include/linux/cacheinfo.h as
>>
>> enum cache_type {
>>          CACHE_TYPE_NOCACHE =3D 0,
>>          CACHE_TYPE_INST =3D BIT(0),=09=09---> 1
>>          CACHE_TYPE_DATA =3D BIT(1),=09=09---> 2
>>          CACHE_TYPE_SEPARATE =3D CACHE_TYPE_INST | CACHE_TYPE_DATA,
>>          CACHE_TYPE_UNIFIED =3D BIT(2),
>> };
>>
>> When it is UNIFIED we return index 0, which is correct. But the index
>> for instruction and data cache seems to be swapped which wrong. This
>> will fetch invalid properties for any given cache type.
>>

Ah, that's silly mistake on my side, will fix it.

>> I have done some initial review and testing for this patch's impact on
>> PowerPC (ppc64 POWER specifically). I am trying to do some code clean-up
>> and re-arrangements. Will post out soon. Thanks !

Thanks for taking time for testing and reviewing these patches.

>
> It does not work correctly on POWER.
>
> The new patchset adds some more attributes for every cache entry apart fr=
om
> what we used to have on PowerPC before. From the ABI perspective, the old=
 ones
> should reflect the correct value in the same manner as before. Looks like
> the generic code will make any attribute as "Unknown" if the arch code do=
es
> not populate them in the respective callback.
>

Yes this is on my list, I need to avoid populating the sysfs files with=20
"Unknown" as value, will do that in next version.

> Here are some problems found on a POWER7 system
>
> (1) L1 instruction cache (cpu<N>/cache/index1/)
>
> =09=3D=3D=3D=3D=3D=3D Before patch =3D=3D=3D=3D=3D=3D
>
> =09coherency_line_size: =09128
> =09level:=09=09=091
> =09shared_cpu_map:=09=0900000000,00000000,00000000,00000000,00000000,0000=
0000,00000000,00000000,00000000,
>          =09=09=0900000000,00000000,00000000,00000000,00000000,00000000,0=
0000000,00000000,00000000,
> =09=09=09=0900000000,00000000,00000000,00000000,00000000,00000000,0000000=
0,00000000,00000000,
> =09=09=09=0900000000,00000000,00000000,00000000,00000f00
> =09size:=09=09=0932K
> =09type:=09=09=09Instruction
>
> =09=3D=3D=3D=3D=3D After patch =3D=3D=3D=3D=3D=3D=3D=3D
>
> =09coherency_line_size:=09Unknown=09=09=09=09=09=09----> Wrong
> =09level:=09=09=091
> =09shared_cpu_map:=09=0900000000,00000000,00000000,00000000,00000000,0000=
0000,00000000,00000000,00000000,
>          =09=09=0900000000,00000000,00000000,00000000,00000000,00000000,0=
0000000,00000000,00000000,
> =09=09=09=0900000000,00000000,00000000,00000000,00000000,00000000,0000000=
0,00000000,00000000,
> =09=09=09=0900000000,00000000,00000000,00000000,00ffffff=09----> Wrong
> =09size:=09=09=090K=09=09=09=09=09=09----> Wrong
> =09type:=09=09=09Instruction=09
>
> (2) L3 cache (cpu<N>/cache/index3/)
>
> =09=3D=3D=3D=3D=3D=3D Before patch =3D=3D=3D=3D=3D=3D
>
> =09number_of_sets:=09=091
> =09size:=09=09=094096K
> =09ways_of_associativity:=090
>
> =09=3D=3D=3D=3D=3D After patch =3D=3D=3D=3D=3D=3D=3D=3D
>
> =09number_of_sets:=09=091
> =09size:=09=09=094096K
> =09ways_of_associativity:=09Unknown=09=09----> Wrong
>
> Need to revisit this implementation on PowerPC and figure out the cause o=
f these problems.
>

Yes, based on the logs you have provided, I will check for the root=20
cause of these issues. I will get back with questions if I need=20
clarifications.

Regards,
Sudeep
