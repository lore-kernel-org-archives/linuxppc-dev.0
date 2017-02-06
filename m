Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vH844603dzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 00:50:12 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v16DnJWt039492
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 08:50:09 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28eqpdetfr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 08:50:08 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 08:50:07 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 73D5B6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 08:49:36 -0500 (EST)
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v16Do4B343253786
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 13:50:04 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9525512404E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 08:50:04 -0500 (EST)
Received: from oc5780617838.ibm.com (unknown [9.10.86.191])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP id 77BFA124035
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 08:50:04 -0500 (EST)
Subject: Re: xmon memory dump does not handle LE
To: linuxppc-dev@lists.ozlabs.org
References: <2a0e256f-4947-e94d-7f79-5451b3c90f9f@linux.vnet.ibm.com>
 <87a8a4avx3.fsf@concordia.ellerman.id.au>
 <d245dc28-5075-8631-4ff1-1039ad88ccd5@linux.vnet.ibm.com>
 <87vasra7lp.fsf@concordia.ellerman.id.au>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Mon, 6 Feb 2017 07:50:04 -0600
MIME-Version: 1.0
In-Reply-To: <87vasra7lp.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4efc7afd-647c-106d-ca90-5f736514f5fc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Yes, your patch seems a more complete solution. The idea of "d1", "d2", 
"d4", and "d8" commands is more what I needed and makes more sense to 
someone hitting xmon "cold". I'll work on getting your patch submitted.


Question on these sorts of patches (PPC only), do we submit initially to 
upstream, or here on this (PPC) mailing list? It would be nice to get 
this into the distros as soon as possible.

Thanks,

Doug


On 02/03/2017 04:31 AM, Michael Ellerman wrote:
> Douglas Miller <dougmill@linux.vnet.ibm.com> writes:
>
>> I'm referring to the three commands listed in the help:
>>
>> d     dump bytes
>>
>> df    dump float values
>>
>> dd    dump double values
>>
>> As it turns out, all three of these commands do exactly the same thing,
>> and it's certainly not what I'd expect based on experience with other
>> debuggers. Maybe the original intent was only to simply output bytes of
>> memory, but to me the help implies otherwise and certainly something
>> more is needed.
> OK. I don't think df/dd actually exist in the code, so I think the help
> is just out of date, by about 20 years.
>
> 'd' definitely works as intended and does what the help says as far as
> I'm concerned. The output is pretty similar to hexdump -C for example.
>
> Also xmon isn't a debugger it's a crash handler :)
>
>> I'll take a look at Balbir's patch and see if I can help move it along.
> Actually take a look at mine instead.
>
> cheers
>
