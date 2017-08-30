Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj41r5WTVzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 22:04:47 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UC44w7117856
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 08:04:44 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cnujhpy3f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 08:04:44 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 22:04:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7UC4e5m39583830
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 22:04:40 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7UC4V3n004409
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 22:04:32 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH] cxl: Set the valid bit in PE for dedicated mode
In-Reply-To: <87r2vu27b3.fsf@concordia.ellerman.id.au>
References: <20170828041522.32188-1-vaibhav@linux.vnet.ibm.com>
 <87r2vu27b3.fsf@concordia.ellerman.id.au>
Date: Wed, 30 Aug 2017 17:34:35 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgm1b6ss.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mpe,

Thanks for reviewing the patch

Michael Ellerman <mpe@ellerman.id.au> writes:

>> +	ctx->elem->software_state = cpu_to_be32(CXL_PE_SOFTWARE_STATE_V);
>> +	/* Make sure the changes to the PE are visible to the card */
>
> A barrier orders something vs something else. So what's the something
> else in this case? Is it the afu_reset() below, what does that actually do?
>

The issue is with call to afu_enable() after the call to afu_reset that
would start the AFU. If this load gets reordered and PSL doesnt see the
valid bit set for this structure then it will result in PSL entering a
freeze-state.

Though on second thoughts afu_enable() is grabbing a spin-lock before
doing an mmio to start the AFU that would be forcing a barrier
anyways. But since that spans the function boundary hence to be safe
have added a write barrier after populating the process element.

Lastly function is not performance critical as it will be usually called
in the life time of a process only once. So the impact smp_wmb() is
having would be minimal.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
