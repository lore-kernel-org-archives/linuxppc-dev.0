Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQRfh1xnkzDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 18:57:47 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9U7vgKZ130468
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 03:57:45 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dwxpxkw6u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 03:57:45 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Oct 2017 07:57:43 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/16] Remove hash page table slot tracking from linux PTE
In-Reply-To: <20171027054136.GC27483@fergus.ozlabs.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171027043430.GA27483@fergus.ozlabs.ibm.com>
 <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
 <20171027054136.GC27483@fergus.ozlabs.ibm.com>
Date: Mon, 30 Oct 2017 13:27:38 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp3d130t.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Fri, Oct 27, 2017 at 10:57:13AM +0530, Aneesh Kumar K.V wrote:
>> 
>> 
>> On 10/27/2017 10:04 AM, Paul Mackerras wrote:
>> >How do we interpret these numbers?  Are they times, or speed?  Is
>> >larger better or worse?
>> 
>> Sorry for not including the details. They are time in seconds. Test case is
>> a modified mmap_bench included in powerpc/selftest.
>> 
>> >
>> >Can you give us the mean and standard deviation for each set of 5
>> >please?
>> >
>> 
>> powernv without patch
>> median= 51.432255
>> stdev = 0.370835
>> 
>> with patch
>> median = 50.739922
>> stdev = 0.06419662
>> 
>> pseries without patch
>> median = 116.617884
>> stdev = 3.04531023
>> 
>> with patch no hcall
>> median = 119.42494
>> stdev = 0.85874552
>> 
>> with patch and hcall
>> median = 117.735808
>> stdev = 2.7624151
>
> So on powernv, the patch set *improves* performance by about 1.3%
> (almost 2 standard deviations).  Do we know why that is?

I haven't looked at that closely. I was considering it within runtime
variance (no impact with patch series). I will get perf record collected
and will see if that points to any details.

>
> On pseries, performance is about 2.4% worse without new hcalls, but
> that is less than 1 standard deviation.  With new hcalls, performance
> is 0.95% worse, only a third of a standard deviation.  I think we need
> to do more measurements to try to get a more accurate picture here.
>
> Were the pseries numbers done on KVM or PowerVM?  Could you do a set
> of measurements on the other one too please?  (I assume the numbers
> with the new hcall were done on KVM, and can't be done on PowerVM.)
>


The above pseries numbers were collected on KVM.

PowerVM numbers on a different machine:
Without patch
31.194165                           
31.372913                           
31.253494
31.416198
31.199180
MEDIAN = 31.253494
STDEV = 0.1018900

With patch series
31.538281
31.385996
31.492737
31.452514
31.259461
MEDIAN = 31.452514
STDEV  = 0.108511

-aneesh
