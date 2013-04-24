Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 86C1A2C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 17:46:18 +1000 (EST)
Message-ID: <51778D97.4080409@asianux.com>
Date: Wed, 24 Apr 2013 15:45:27 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH] arch/powerpc/kernel: using %12.12s instead of %12s for
 avoiding memory overflow.
References: <5100B53C.3030109@asianux.com> <512055D0.7050100@asianux.com>
 <514FD2E0.5030805@asianux.com>
In-Reply-To: <514FD2E0.5030805@asianux.com>
Content-Type: text/plain; charset=GB2312
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Vasant Hegde:

How about this patch, is it OK ?

Thanks.


On 2013年03月25日 12:30, Chen Gang wrote:
> Hello Maintainers:
> 
>   could you help check this patch whether is ok ?
> 
>   thanks.
> 
> 
> On 2013年02月17日 12:00, Chen Gang wrote:
>> Hello relative members:
>>
>>   please give a glance to this patch, when you have time.
>>
>>   thanks.
>>
>>   :-)
>>
>> gchen.
>>
>>
>> 于 2013年01月24日 12:14, Chen Gang 写道:
>>>
>>>   for tmp_part->header.name:
>>>     it is "Terminating null required only for names < 12 chars".
>>>     so need to limit the %.12s for it in printk
>>>
>>>   additional info:
>>>
>>>     %12s  limit the width, not for the original string output length
>>>           if name length is more than 12, it still can be fully displayed.
>>>           if name length is less than 12, the ' ' will be filled before name.
>>>
>>>     %.12s truly limit the original string output length (precision)
>>>
>>>
>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>> ---
>>>  arch/powerpc/kernel/nvram_64.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
>>> index bec1e93..57bf6d2 100644
>>> --- a/arch/powerpc/kernel/nvram_64.c
>>> +++ b/arch/powerpc/kernel/nvram_64.c
>>> @@ -202,7 +202,7 @@ static void __init nvram_print_partitions(char * label)
>>>  	printk(KERN_WARNING "--------%s---------\n", label);
>>>  	printk(KERN_WARNING "indx\t\tsig\tchks\tlen\tname\n");
>>>  	list_for_each_entry(tmp_part, &nvram_partitions, partition) {
>>> -		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%12s\n",
>>> +		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%12.12s\n",
>>>  		       tmp_part->index, tmp_part->header.signature,
>>>  		       tmp_part->header.checksum, tmp_part->header.length,
>>>  		       tmp_part->header.name);
>>>
>>
>>
> 
> 


-- 
Chen Gang

Asianux Corporation
