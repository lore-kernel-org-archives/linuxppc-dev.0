Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C068714028F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 10:24:02 +1000 (EST)
Message-ID: <53697B5C.6090107@Freescale.com>
Date: Tue, 6 May 2014 19:16:28 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH 2/2 v2] powerpc: Enable NO_BOOTMEM
References: <1399402084-6325-1-git-send-email-Emilian.Medve@Freescale.com>
 <1399402084-6325-2-git-send-email-Emilian.Medve@Freescale.com>
 <1399412988.15726.202.camel@snotra.buserror.net>
In-Reply-To: <1399412988.15726.202.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 05/06/2014 04:49 PM, Scott Wood wrote:
> On Tue, 2014-05-06 at 13:48 -0500, Emil Medve wrote:
>> Currently bootmem is just a wrapper around memblock. This gets rid of
>> the wrapper code just as other ARHC(es) did: x86, arm, etc.
>>
>> For now only cover !NUMA systems/builds
>>
>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>> ---
>>
>> v2: Acknowledge that NUMA systems/builds are not covered by this patch
>>
>>  arch/powerpc/Kconfig  | 3 +++
>>  arch/powerpc/mm/mem.c | 8 ++++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index e099899..07b164b 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -475,6 +475,9 @@ config SYS_SUPPORTS_HUGETLBFS
>>  
>>  source "mm/Kconfig"
>>  
>> +config NO_BOOTMEM
>> +	def_bool !NUMA
> 
> This will allow a user to manually turn on CONFIG_NO_BOOTMEM in the
> presence of NUMA.  From the changelog it sounds like this is not what
> you intended.
> 
> What are the issues with NUMA?

Well, I don't have access to a NUMA box/board. I could enable NUMA for a
!NUMA board but I'd feel better if I could actually test/debug on a
relevant system

> As is, you're not getting rid of wrapper code -- only adding ifdefs.

First, you're talking about the bootmem initialization wrapper code for
powerpc. The actual bootmem code is in include/linux/bootmem.h and
mm/bootmem.c. We can't remove those files as they are still used by
other arches. Also, the word wrapper is somewhat imprecise as in powerpc
land bootmem sort of runs on top of memblock

When NO_BOOTMEM is configured the mm/nobootmem.c is used that is the
bootmem API actually re-implemented with memblock. The bootmem API is
used in various places in the arch independent code

This patch wants to isolate for removal the bootmem initialization code
for powerpc and to exclude mm/bootmem.c from being built. This being the
first step I didn't want to actually remove the code, so it will be easy
to debug if some issues crop up. Also, people that want the use the
bootmem code for some reason can easily do that. Once this change spends
some time in the tree, we can actually remove the bootmem initialization
code


Cheers,
