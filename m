Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKxQp4hYWzF0ZT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 02:02:10 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0FF0OGj082489
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 10:02:07 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fgscfxefv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 10:02:07 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 15 Jan 2018 10:02:06 -0500
Subject: Re: [PATCH V2] powerpc/kernel: Add 'ibm, thread-groups' property for
 CPU allocation
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <aeffc542-db28-7d1f-3263-52919b2d07c2@linux.vnet.ibm.com>
 <d7825e1c-ca1f-3bbe-be41-897b3e98e928@linux.vnet.ibm.com>
 <87tvvqbi82.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
In-Reply-To: <87tvvqbi82.fsf@concordia.ellerman.id.au>
Date: Mon, 15 Jan 2018 09:01:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <95dc3b09-63f1-e79e-9fc9-56c4b7b1bcdd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/12/2018 08:33 PM, Michael Ellerman wrote:
> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
...
>>
>> One thing I don't see addressed in the comments or in the code is
>> migration support. I think we need to update the thread group mask
>> post-migration to reflect the threads per core on the new system.
> 
> Normally I'd agree with you, but I don't see any prospect of the kernel
> surviving if the threads per core changes across a migration. We'll have
> data structures allocated based on the old value and things will
> definitely crash if the value increases. If it shrinks maybe we'd get
> away with it, but either way is dicey.
> 
> If there's an expectation that we'll be able to migrate between systems
> with different settings then we have a much bigger problem.
> 
> cheers
> 
> 

>From what I recall of my tests a few months ago, the device-tree is read in
and flattened before the kernel starts processing the migration state.
I am trying to get access to a couple of P9 systems on which I may test
migration to verify the ordering of events between initializing the kernel
and post-migration processing.

Regards,

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
