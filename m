Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmfYX42bNzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 13:10:40 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2K29Bsw066267
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 22:10:34 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2991e0svt1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 22:10:33 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 20 Mar 2017 12:10:31 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2K2ALZY54984730
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 13:10:29 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2K29svZ014966
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 13:09:54 +1100
Subject: Re: [PATCH 3/7] cxl: Keep track of mm struct associated with a context
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
References: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1485970213-25532-4-git-send-email-clombard@linux.vnet.ibm.com>
 <d90a3fca-9bc9-82ce-c0e8-1632ba409b31@au1.ibm.com>
 <66dee4f8-5897-2948-5813-c021b83379f8@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 20 Mar 2017 13:09:32 +1100
MIME-Version: 1.0
In-Reply-To: <66dee4f8-5897-2948-5813-c021b83379f8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <58f313ae-ec2a-f0aa-0a0b-986c50c1a9a1@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/17 21:57, christophe lombard wrote:
>>> @@ -281,7 +212,6 @@ void cxl_handle_fault(struct work_struct
>>> *fault_work)
>>>      if (!ctx->kernel) {
>>>
>>>          mm = get_mem_context(ctx);
>>> -        /* indicates all the thread in task group have exited */
>>>          if (mm == NULL) {
>>>              pr_devel("%s: unable to get mm for pe=%d pid=%i\n",
>>>                   __func__, ctx->pe, pid_nr(ctx->pid));
>>
>> Is there still a case where mm can equal NULL?
> Yes. The context may be in the process of being closed.

But where does ctx->mm get reset to NULL? I've had a cursory look and 
can't see it.


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
