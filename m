Return-Path: <kernelfans@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDgnF46GCzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 14:29:05 +1000 (AEST)
Received: by mail-io0-x244.google.com with SMTP id k87so8438859ioi.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 21:29:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e07eb5d7-2c8f-1eb5-8ba5-109bb6262f12@linux.vnet.ibm.com>
References: <1493278988-26169-1-git-send-email-piliu@redhat.com>
 <e07eb5d7-2c8f-1eb5-8ba5-109bb6262f12@linux.vnet.ibm.com>
From: Liu ping fan <kernelfans@gmail.com>
Date: Fri, 28 Apr 2017 12:29:02 +0800
Message-ID: <CAFgQCTuCeCMdC-kJDXP69yoHOVG8+pPhJ5EVgyH1hdQrSWYaPA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pseries hotplug: prevent the reserved mem from
 removing
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 28, 2017 at 2:06 AM, Hari Bathini
<hbathini@linux.vnet.ibm.com> wrote:
> Hi Pingfan,
>
>
> On Thursday 27 April 2017 01:13 PM, Pingfan Liu wrote:
>>
>> E.g after fadump reserves mem regions, these regions should not be removed
>> before fadump explicitly free them.
>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
>> ---
>>   arch/powerpc/platforms/pseries/hotplug-memory.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index e104c71..201be23 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -346,6 +346,8 @@ static int pseries_remove_memblock(unsigned long base,
>> unsigned int memblock_siz
>>
>>         if (!pfn_valid(start_pfn))
>>                 goto out;
>> +       if (memblock_is_reserved(base))
>> +               return -EINVAL;
>
>
> I think memblock reserved regions are not hot removed even without this
> patch.
> So, can you elaborate on when/why this patch is needed?
>
I have not found code to prevent the reserved regions from free. Do I
miss anything?
I will try to reserve a ppc to have a test.

Thx,
Pingfan
