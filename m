Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tK1d62sRRzDvRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 11:06:34 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id e9so15562035pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 16:06:34 -0800 (PST)
Subject: Re: [powerpc v6 1/3] Setup AMOR in HV mode
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, mpe@ellerman.id.au
References: <1479192976-17847-1-git-send-email-bsingharora@gmail.com>
 <1479192976-17847-2-git-send-email-bsingharora@gmail.com>
 <871sybn9ex.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <2a046f94-f20c-cd66-9dca-54d05cb917bc@gmail.com>
Date: Thu, 17 Nov 2016 11:06:27 +1100
MIME-Version: 1.0
In-Reply-To: <871sybn9ex.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/11/16 18:58, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> AMOR should be setup in HV mode, we set it up once
>> and let the generic kernel handle IAMR. This patch is
>> used to enable storage keys in a following patch as
>> defined in ISA 3. We don't setup AMOR in DD1, since we
>> can't setup IAMR in DD1 (bits have to be 0). If we setup
>> AMOR some other code could potentially try to set IAMR
>> (guest kernel for example).
>>
>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>>  arch/powerpc/mm/pgtable-radix.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
>> index ed7bddc..7aa104d 100644
>> --- a/arch/powerpc/mm/pgtable-radix.c
>> +++ b/arch/powerpc/mm/pgtable-radix.c
>> @@ -320,6 +320,27 @@ static void update_hid_for_radix(void)
>>  		cpu_relax();
>>  }
>>  
>> +/*
>> + * In HV mode, we init AMOR so that the hypervisor
>> + * and guest can setup IMAR, enable key 0 and set
>> + * it to 1
>> + * AMOR = 1100....00 (Mask for key 0 is 11)
>> + */
>> +static void radix_init_amor(void)
>> +{
>> +	unsigned long amor_mask = 0xc000000000000000;
>> +	unsigned long amor;
> 
> I guess michael mentioned this in another email, why two variables ?
> 
Left overs from when we did the OR'ing of the mask. But luckily
the compiler does the right thing when generating code

Balbir
