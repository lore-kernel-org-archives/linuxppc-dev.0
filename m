Return-Path: <stewart@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xr513KjGzDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 13:52:37 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w513nX2J144710
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 23:52:35 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jaqqcwfh1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 23:52:34 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.ibm.com>;
 Thu, 31 May 2018 21:52:34 -0600
From: Stewart Smith <stewart@linux.ibm.com>
To: Haren Myneni <haren@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto/nx: Initialize 842 high and normal RxFIFO control
 registers
In-Reply-To: <1527789287.5945.23.camel@hbabu-laptop>
References: <1527789287.5945.23.camel@hbabu-laptop>
Date: Fri, 01 Jun 2018 13:52:28 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87sh672mf7.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Haren Myneni <haren@linux.vnet.ibm.com> writes:
> NX increments readOffset by FIFO size in receive FIFO control register
> when CRB is read. But the index in RxFIFO has to match with the
> corresponding entry in FIFO maintained by VAS in kernel. Otherwise NX
> may be processing incorrect CRBs and can cause CRB timeout.
>
> VAS FIFO offset is 0 when the receive window is opened during
> initialization. When the module is reloaded or in kexec boot, readOffset
> in FIFO control register may not match with VAS entry. This patch adds
> nx_coproc_init OPAL call to reset readOffset and queued entries in FIFO
> control register for both high and normal FIFOs.
>
> Signed-off-by: Haren Myneni <haren@us.ibm.com>

I've yet to go and check out the skiboot patch properly, but should this
be both:
Fixes: b0d6c9bab crypto/nx: Add P9 NX support for 842 compression engine
CC: stable # v4.14+

as otherwise "rmmod ; insmod" will crash, and possibly even issues over kexec?

-- 
Stewart Smith
OPAL Architect, IBM.
