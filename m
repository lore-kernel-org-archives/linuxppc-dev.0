Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5F5F1A050B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 10:52:19 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Thu, 10 Dec 2015 05:22:16 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E1BD0394005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 05:22:14 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB9NqECX38994022
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 05:22:14 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB9NqEVP008564
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 05:22:14 +0530
Subject: Re: [PATCH] powerpc/nvram: Fix a memory leak in err path
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 xinhui <xinhui.pan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <5667FBD5.2050206@linux.vnet.ibm.com>
 <566846F5.2020507@linux.vnet.ibm.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: xinhui <xinhui@linux.vnet.ibm.com>
Message-ID: <5668BEA5.1000002@linux.vnet.ibm.com>
Date: Thu, 10 Dec 2015 07:52:05 +0800
MIME-Version: 1.0
In-Reply-To: <566846F5.2020507@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2015/12/9 23:21, Nathan Fontenot wrote:
> On 12/09/2015 04:00 AM, xinhui wrote:
>>
>> If kmemdup fails, We need kfree *buff* first then return -ENOMEM.
>> Otherwise there is a memory leak.
>>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>

Hi Nathan,
	thank you for doing that :)

thanks
xinhui

>> ---
>>   arch/powerpc/kernel/nvram_64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
>> index 32e2652..21a278b7 100644
>> --- a/arch/powerpc/kernel/nvram_64.c
>> +++ b/arch/powerpc/kernel/nvram_64.c
>> @@ -542,9 +542,9 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
>>   			time->tv_nsec = 0;
>>   		}
>>   		*buf = kmemdup(buff + hdr_size, length, GFP_KERNEL);
>> +		kfree(buff);
>>   		if (*buf == NULL)
>>   			return -ENOMEM;
>> -		kfree(buff);
>>
>>   		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ)
>>   			*compressed = true;
>>
