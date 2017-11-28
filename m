Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymGw56LF2zDrJJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 19:26:13 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAS8PEeW069915
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 03:26:11 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eh0gv0bjr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 03:26:11 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 08:26:09 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vAS8Q6Iq42336494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 08:26:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D16011C054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 08:20:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5253D11C04A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 08:20:41 +0000 (GMT)
Received: from [9.164.132.126] (unknown [9.164.132.126])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 08:20:41 +0000 (GMT)
Subject: Re: [PATCH v4] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
To: linuxppc-dev@lists.ozlabs.org
References: <20171128025304.30574-1-vaibhav@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 09:26:05 +0100
MIME-Version: 1.0
In-Reply-To: <20171128025304.30574-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ed9d5ff5-babb-4b84-520e-a9e649eab5e6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 28/11/2017 à 03:53, Vaibhav Jain a écrit :
> There is an unsafe signed to unsigned conversion in set_thread_tidr()
> that may cause an error value to be assigned to SPRN_TIDR register and
> used as thread-id.
> 
> The issue happens as assign_thread_tidr() returns an int and
> thread.tidr is an unsigned-long. So a negative error code returned
> from assign_thread_tidr() will fail the error check and gets assigned
> as tidr as a large positive value.
> 
> To fix this the patch assigns the return value of assign_thread_tidr()
> to a temporary int and assigns it to thread.tidr iff its '> 0'.
> 
> The patch shouldn't impact the calling convention of set_thread_tidr()
> i.e all -ve return-values are error codes and a return value of '0'
> indicates success.
> 
> Fixes: ec233ede4c86("powerpc: Add support for setting SPRN_TIDR")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> 
> ---

sounds good for me
Thanks

Reviewed-by: Christophe Lombard clombard@linux.vnet.ibm.com
