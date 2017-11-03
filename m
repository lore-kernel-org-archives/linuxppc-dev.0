Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yT1T61j1JzDrD1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 23:28:25 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA3CLUoK089649
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Nov 2017 08:28:23 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e0r831776-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Nov 2017 08:28:23 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Fri, 3 Nov 2017 08:28:22 -0400
Subject: Re: [PATCH] selftests/powerpc: Check FP/VEC on exception in TM
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1509564221-7049-1-git-send-email-gromero@linux.vnet.ibm.com>
 <1509574233.1667.4.camel@gmail.com>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Cc: leitao@debian.org
Date: Fri, 3 Nov 2017 10:28:10 -0200
MIME-Version: 1.0
In-Reply-To: <1509574233.1667.4.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <59FC60DA.6060100@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril!

On 01-11-2017 20:10, Cyril Bur wrote:
> Thanks Gustavo,
> 
> I do have one more thought on an improvement for this test which is
> that:
> +	/* Counter for busy wait *
> +	uint64_t counter = 0x1ff000000;
> is a bit fragile, what we should do is have the test work out long it
> should spin until it reliably gets a TM_CAUSE_FAC_UNAV failure and then
> use that for these tests.
> 
> This will only become a problem if we were to change kernel heuristics
> which is fine for now. I'll try to get that added soon but for now this
> test has proven too useful to delay adding as is.

I see. Yup, 'counter' value was indeed determined experimentally under many
different scenarios (VM and BM, different CPU loads, etc). At least if the
heuristics changes hurting the test it will catch that pointing out that
the expected failure did not happen, like:

Checking if FP/VEC registers are sane after a FP unavailable exception...
If MSR.FP=0 MSR.VEC=0:
    Expecting the transaction to fail, but it didn't
    FP ok VEC ok
...

So it won't let the hurting change pass fine silently :-)


>> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Thanks a lot for reviewing it.

Cheers,
Gustavo
