Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0058.outbound.protection.outlook.com [207.46.100.58])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9DD841401A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 05:18:38 +1000 (EST)
Message-ID: <536A7D7E.8070509@Freescale.com>
Date: Wed, 7 May 2014 13:37:50 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2 v2] powerpc: Enable NO_BOOTMEM
References: <1399402084-6325-1-git-send-email-Emilian.Medve@Freescale.com>
 <1399402084-6325-2-git-send-email-Emilian.Medve@Freescale.com>
 <87lhueumdp.fsf@linux.vnet.ibm.com>
In-Reply-To: <87lhueumdp.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Aneesh,


On 05/07/2014 01:35 AM, Aneesh Kumar K.V wrote:
> Emil Medve <Emilian.Medve@Freescale.com> writes:
> 
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
> 
> There is actually one in  mm/Kconfig
> 
> So I guess you should make the platform that you are interested
> /tested just do select No_BOOTMEM like we do in arch/arm/Kconfig etc ?

I had a look at what was done for x86 and I missed why the mm/Kconfig
symbol was added. Will include your suggestion in the next version


Cheers,
