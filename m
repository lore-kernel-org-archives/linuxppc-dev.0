Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkx1z4g26zDqdV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 17:55:51 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2H6rlgX128075
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 02:55:44 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297nkp800v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 02:55:44 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 17 Mar 2017 12:25:41 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2H6tZsh17563768
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 12:25:35 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2H6tcER023025
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 12:25:39 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 02/11] powerpc/mm/slice: when computing slice mask
 limit lowe slice max addr correctly
In-Reply-To: <20170316220304.GB10100@fergus.ozlabs.ibm.com>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1489660329-22501-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170316220304.GB10100@fergus.ozlabs.ibm.com>
Date: Fri, 17 Mar 2017 12:25:37 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fuicfl3q.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Thu, Mar 16, 2017 at 04:02:00PM +0530, Aneesh Kumar K.V wrote:
>> For low slice max addr should be less that 4G
>                                         ^^^^ than
>
> A more verbose explanation of the off-by-1 error that you are fixing
> is needed here.  Tell us what goes wrong with the current code and why
> your fix is the correct one.

How about

powerpc/mm/slice: when computing slice mask limit low slice max addr correctly

For low slice, max addr should be less that 4G. Without limiting this correctly
we will end up with a low slice mask which has 17th bit set. This is not
a problem with the current code because our low slice mask is of type u16. But
in later patch I am switching low slice mask to u64 type and having the 17bit
set result in wrong slice mask which in turn results in mmap failures.


>
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> For the code change:
>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
