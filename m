Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCNhD5g2JzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 19:05:48 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9C85DeK136229
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 04:05:46 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dj28yprq6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 04:05:45 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 12 Oct 2017 09:05:12 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9C858Tc16973874
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 08:05:10 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9C858FT025438
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 19:05:08 +1100
Subject: Re: [PATCH] powerpc/powernv: Add kernel cmdline parameter to disable
 imc
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 hemant@linux.vnet.ibm.com
References: <1507531597-25947-1-git-send-email-anju@linux.vnet.ibm.com>
 <87wp43wf2v.fsf@concordia.ellerman.id.au> <87infmeonf.fsf@linux.vnet.ibm.com>
 <06fe39eb-d5fe-4472-56b4-f66390d7fad9@linux.vnet.ibm.com>
 <87sheoby7c.fsf@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 12 Oct 2017 13:35:05 +0530
MIME-Version: 1.0
In-Reply-To: <87sheoby7c.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <69dfcb10-2d7d-f6d3-3bb6-34ef6676b6b1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 12 October 2017 01:21 PM, Stewart Smith wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>> On Wednesday 11 October 2017 01:55 AM, Stewart Smith wrote:
>>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>>> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>>>>
>>>>> Add a kernel command line parameter option to disable In-Memory Collection
>>>>> (IMC) counters and add documentation. This helps in debug.
>>>> I'd really rather we didn't. Do we *really* need this?
>>>>
>>>> We don't have command line parameters to disable any of the other ~20
>>>> PMUs, why is this one special?
>> This one is really helpful in debugging, incase if we want to proceed
>> without nest counters  OR
>> core counters . But if we have the facility to do the same from
>> petitboot, its fine.
> https://patchwork.ozlabs.org/patch/824497/ (skiboot patch) should do the
> same thing, right? That means we come up with them off (as we should
> have from the start) and if you don't use the PMUs then the ucode won't
> be started.
Stewart,

Thats right. With that skiboot patch, IMC will be paused at start.
