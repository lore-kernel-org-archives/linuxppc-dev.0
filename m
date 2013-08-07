Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC7B42C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 15:37:59 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 7 Aug 2013 10:58:54 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2012D3940053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 11:07:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r775d40s42205412
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 11:09:04 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r775brxw031831
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 15:37:53 +1000
Received: from [9.111.29.246] (win-q68h7f9m03i.cn.ibm.com [9.111.29.246])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r775bqk3031676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 15:37:52 +1000
Message-ID: <5201DD27.9010805@linux.vnet.ibm.com>
Date: Wed, 07 Aug 2013 13:37:43 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh: Fix undefined variable
References: <1375842286-26521-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20130807051124.GA19998@concordia> <20130807052548.GA6070@shangw.(null)>
In-Reply-To: <20130807052548.GA6070@shangw.(null)>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013/8/7 13:25, Gavin Shan 写道:
> On Wed, Aug 07, 2013 at 03:11:24PM +1000, Michael Ellerman wrote:
>> On Tue, Aug 06, 2013 at 10:24:46PM -0400, Mike Qiu wrote:
>>> 'pe_no' hasn't been defined, it should be an typo error,
>>> it should be 'frozen_pe_no'.
>>>
>>> Also '__func__' should be added to IODA_EEH_DBG(),
>>>
>>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>>> index 0cd1c4a..a49bee7 100644
>>> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>>> @@ -843,7 +843,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>>>   		 * specific PHB.
>>>   		 */
>>>   		IODA_EEH_DBG("%s: Error (%d, %d, %d) on PHB#%x\n",
>>> -			err_type, severity, pe_no, hose->global_number);
>>> +			__func__, err_type, severity,
>>> +			frozen_pe_no, hose->global_number);
>> Why is it using a custom macro? If you use pr_devel() or similar you
>> avoid these bugs, because the argument list is always expanded.
>>
> The custom macro at least can save some CPU cycles, but that's not
> safe as you mentioned. It's resonable to use pr_devel() here.
>
> Mike, could you help to replace IODA_EEH_DBG() with pr_devel() as
> Michael suggested?
OK, I will change the patch in V2

Thanks
Mike
>
> Thanks,
> Gavin
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
