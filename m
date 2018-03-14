Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401PB53r08zF17Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:54:05 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2E7rcZu120501
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 03:54:03 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gpsxatx3d-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 03:54:03 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 07:54:00 -0000
Subject: Re: [PATCH] powerpc/numa: Correct kernel message severity
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
References: <1520935913-23593-1-git-send-email-vipin@linux.vnet.ibm.com>
 <29183547-d1c5-5282-86cb-3d5acbade58f@c-s.fr>
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 13:23:55 +0530
MIME-Version: 1.0
In-Reply-To: <29183547-d1c5-5282-86cb-3d5acbade58f@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c37aba4b-b4b9-e9b5-b36a-13bd594606b8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tuesday 13 March 2018 03:58 PM, Christophe LEROY wrote:
>
>
> Le 13/03/2018 à 11:11, Vipin K Parashar a écrit :
>> printk in unmap_cpu_from_node() uses KERN_ERR message severity
>> for a WARNING message. Correct message severity to KERN_WARNING.
>>
>> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/mm/numa.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index edd8d0b..79c94cc 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -163,7 +163,7 @@ static void unmap_cpu_from_node(unsigned long cpu)
>>       if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
>>           cpumask_clear_cpu(cpu, node_to_cpumask_map[node]);
>>       } else {
>> -        printk(KERN_ERR "WARNING: cpu %lu not found in node %d\n",
>> +        printk(KERN_WARNING "WARNING: cpu %lu not found in node %d\n",
> >                  cpu, node);
>
> Why not take the opportunity to use pr_warn() instead, hence to put 
> back the cpu and node vars on the same line.
>
> Christophe
>

Yes, Thanks!!

Send v2.


>>       }
>>   }
>>
>
