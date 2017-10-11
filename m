Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBnsK2nWTzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 19:56:37 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9B8u4F1119382
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:56:35 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dhb71cafu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:56:34 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 11 Oct 2017 04:56:33 -0400
Subject: Re: [PATCH] powerpc/powernv: Add kernel cmdline parameter to disable
 imc
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com
References: <1507531597-25947-1-git-send-email-anju@linux.vnet.ibm.com>
 <87wp43wf2v.fsf@concordia.ellerman.id.au> <87infmeonf.fsf@linux.vnet.ibm.com>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 14:26:27 +0530
MIME-Version: 1.0
In-Reply-To: <87infmeonf.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <06fe39eb-d5fe-4472-56b4-f66390d7fad9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi mpe, stewart,


On Wednesday 11 October 2017 01:55 AM, Stewart Smith wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>>
>>> Add a kernel command line parameter option to disable In-Memory Collection
>>> (IMC) counters and add documentation. This helps in debug.
>> I'd really rather we didn't. Do we *really* need this?
>>
>> We don't have command line parameters to disable any of the other ~20
>> PMUs, why is this one special?

This one is really helpful in debugging, incase if we want to proceed 
without nest counters  OR
core counters . But if we have the facility to do the same from 
petitboot, its fine.

> You could also do the same thing by editing the device tree before
> booting your kernel, we do have the facility to do that in petitboot.
>
> A recent firmware patch: https://patchwork.ozlabs.org/patch/823249/
> would fix the firmware implementation where the counters were already
> running before the INIT/START calls, which are likely the cause of the
> problems that this patch is trying to work around.
>
> I propose we have the firmware do the right thing and nothing special in
> kernel. i.e. not to merge this.
>

Agreed.



Thanks,
Anju
