Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xvbR1JmlzDrbW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 16:30:42 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w516SxYY109413
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2018 02:30:39 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jb05d1n6u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 02:30:39 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 1 Jun 2018 02:30:39 -0400
Date: Thu, 31 May 2018 23:30:32 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.ibm.com>
CC: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto/nx: Initialize 842 high and normal RxFIFO control
 registers
References: <1527789287.5945.23.camel@hbabu-laptop>
 <87sh672mf7.fsf@linux.vnet.ibm.com>
In-Reply-To: <87sh672mf7.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <5B10E808.3030502@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2018 08:52 PM, Stewart Smith wrote:
> Haren Myneni <haren@linux.vnet.ibm.com> writes:
>> NX increments readOffset by FIFO size in receive FIFO control register
>> when CRB is read. But the index in RxFIFO has to match with the
>> corresponding entry in FIFO maintained by VAS in kernel. Otherwise NX
>> may be processing incorrect CRBs and can cause CRB timeout.
>>
>> VAS FIFO offset is 0 when the receive window is opened during
>> initialization. When the module is reloaded or in kexec boot, readOffset
>> in FIFO control register may not match with VAS entry. This patch adds
>> nx_coproc_init OPAL call to reset readOffset and queued entries in FIFO
>> control register for both high and normal FIFOs.
>>
>> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> 
> I've yet to go and check out the skiboot patch properly, but should this
> be both:
> Fixes: b0d6c9bab crypto/nx: Add P9 NX support for 842 compression engine
> CC: stable # v4.14+
> 
> as otherwise "rmmod ; insmod" will crash, and possibly even issues over kexec?
> 

Correct, P9 NX support is included in 4.14. We also need fix in stable trees (4.14+). But this patch will not apply cleanly. I will post different patch for 4.14 and 4.16 stable trees. 

Thanks
Haren
