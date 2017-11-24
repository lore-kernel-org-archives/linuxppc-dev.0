Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjnNG2MmSzDrMB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 18:08:30 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAO75tqr013887
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 02:08:27 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eedvxt4gt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 02:08:27 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 24 Nov 2017 07:08:25 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
In-Reply-To: <87lgiw19qd.fsf@concordia.ellerman.id.au>
References: <20171123124718.16839-1-vaibhav@linux.vnet.ibm.com>
 <87lgiw19qd.fsf@concordia.ellerman.id.au>
Date: Fri, 24 Nov 2017 12:38:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fu94f925.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Mpe for reviewing the patch

Michael Ellerman <mpe@ellerman.id.au> writes:

>> To fix this the patch assigns the return value of assign_thread_tidr()
>> to a temporary int and assigns it to thread.tidr iff its '> 0'.
>
> .. and changes the calling convention of the function.
>
> Now it returns -ve error values, or a +ve TIDR value when it succeeds,
> or possibly 0 if that's returned by assign_thread_tidr().
>
> Which I'm not sure you meant to do. If you did, you should at least
> document it.
>

Yes this is intentional and this was supposed to be the calling
convention of set_thread_tidr() in first place. At-least that what I
gather from subsequent cxl patch to add its support
http://patchwork.ozlabs.org/patch/840719/

set_thread_tidr() is a wrapper around assign_thread_tidr() which follows
similar calling convention i.e return -ve values for error and  +ve
value successfully allocated tidr. The way assign_thread_tidr() is
implemented it will never return a '0'.

Currently set_thread_tidr() will wrongly assign an incorrect tidr value
to SPRN_TIDR in case assign_thread_tidr() returns an error. This patch
fixes this issue and should not impact the existing calling convention
of set_thread_tidr(). The patch should not have an impact on the calling
convention of set_thread_tidr().

I also have unintentionally left a tidr leak in this patch and will send
a v2 with the fix and also updating the patch description mentioning the
calling convention of the function.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
