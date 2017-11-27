Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yljQX256SzDr8d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 21:17:07 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vARAEQ6n116923
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 05:17:05 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2egexxx3sh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 05:17:04 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 27 Nov 2017 10:17:03 -0000
Subject: Re: [PATCH] cxl: Add support for ASB_Notify on POWER9
To: Michael Ellerman <mpe@ellerman.id.au>, benh@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
References: <1511435132-24020-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1511469668.2466.48.camel@au1.ibm.com>
 <49cd46e7-c13e-c82c-404c-2c9e989b9774@linux.vnet.ibm.com>
 <1511528547.2466.52.camel@au1.ibm.com>
 <d18c47e1-d40f-1d6e-e68c-99ae7be01737@linux.vnet.ibm.com>
 <87zi782ws1.fsf@concordia.ellerman.id.au>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 11:17:00 +0100
MIME-Version: 1.0
In-Reply-To: <87zi782ws1.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b3d193fb-22fa-c8e8-352b-366e219ed2d7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 27/11/2017 à 05:03, Michael Ellerman a écrit :
> christophe lombard <clombard@linux.vnet.ibm.com> writes:
> 
>> Le 24/11/2017 à 14:02, Benjamin Herrenschmidt a écrit :
>>> On Fri, 2017-11-24 at 11:14 +0100, christophe lombard wrote:
>>>> To my knowledge, there is no property (or similar), somewhere, that
>>>> indicating that the TIDR is supported or not.
>>>> For the time being, if I am not wrong, the only check we have, is
>>>> this condition in the function set_thread_tidr(struct task_struct *t):
>>>>
>>>>           if (!cpu_has_feature(CPU_FTR_ARCH_300))
>>>>                   return -EINVAL;
>>>>
>>>>
>>>> Christophe
>>>
>>> Then we need to fix that
>>>
>>> Ben.
>>>
>>
>> You are right. We will insert a checking in the cxl driver to allow
>> updating the TIDR if a P9 is present. This will be in the patch V2.
>> Thanks
> 
> A cxl_is_power9() check should be fine.
> 
> When the check fails you should return an error code that can be
> distinguished and interpreted correctly by userspace, ie. not EINVAL.
> That implies if the program calls with a different set of arguments the
> call might succeed, which is not true.
> 
> Either ENODEV or ENXIO would be best I think.
> 
> cheers
> 

This is what I had in mind about the function cxl_is_power9() and I am 
agree with the return codes.
Thanks for your help.

Christophe
