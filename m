Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EB742C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:15:34 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 13:40:14 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1D067125804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 13:47:02 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O8FLEF7799132
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 13:45:22 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O8FO4r001417
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 08:15:24 GMT
Message-ID: <51779491.10307@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 13:45:13 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch/powerpc/kernel: using %12.12s instead of %12s for
 avoiding memory overflow.
References: <5100B53C.3030109@asianux.com> <512055D0.7050100@asianux.com>
 <514FD2E0.5030805@asianux.com> <51778D97.4080409@asianux.com>
In-Reply-To: <51778D97.4080409@asianux.com>
Content-Type: text/plain; charset=GB2312
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2013 01:15 PM, Chen Gang wrote:
> Hello Vasant Hegde:
> 
> How about this patch, is it OK ?
> 
> Thanks.
> 
> 
> On 2013年03月25日 12:30, Chen Gang wrote:
>> Hello Maintainers:
>>
>>    could you help check this patch whether is ok ?
>>
>>    thanks.
>>
>>
>> On 2013年02月17日 12:00, Chen Gang wrote:
>>> Hello relative members:
>>>
>>>    please give a glance to this patch, when you have time.
>>>
>>>    thanks.
>>>
>>>    :-)
>>>
>>> gchen.
>>>
>>>
>>> 于 2013年01月24日 12:14, Chen Gang 写道:
>>>>
>>>>    for tmp_part->header.name:
>>>>      it is "Terminating null required only for names<  12 chars".
>>>>      so need to limit the %.12s for it in printk
>>>>
>>>>    additional info:
>>>>
>>>>      %12s  limit the width, not for the original string output length
>>>>            if name length is more than 12, it still can be fully displayed.
>>>>            if name length is less than 12, the ' ' will be filled before name.
>>>>
>>>>      %.12s truly limit the original string output length (precision)
>>>>
>>>>
>>>> Signed-off-by: Chen Gang<gang.chen@asianux.com>
>>>> ---
>>>>   arch/powerpc/kernel/nvram_64.c |    2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
>>>> index bec1e93..57bf6d2 100644
>>>> --- a/arch/powerpc/kernel/nvram_64.c
>>>> +++ b/arch/powerpc/kernel/nvram_64.c
>>>> @@ -202,7 +202,7 @@ static void __init nvram_print_partitions(char * label)
>>>>   	printk(KERN_WARNING "--------%s---------\n", label);
>>>>   	printk(KERN_WARNING "indx\t\tsig\tchks\tlen\tname\n");
>>>>   	list_for_each_entry(tmp_part,&nvram_partitions, partition) {
>>>> -		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%12s\n",
>>>> +		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%12.12s\n",

First, this code in inside NVRAM_DEBUG which is used only for debug purpose and
AFAIK, all partition names are less than 20 character. So I don't think we need
this patch.

-Vasant

>>>>   		       tmp_part->index, tmp_part->header.signature,
>>>>   		       tmp_part->header.checksum, tmp_part->header.length,
>>>>   		       tmp_part->header.name);
>>>>
>>>
>>>
>>
>>
> 
> 
