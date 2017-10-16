Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yG3Dc26tlzDrG1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 03:09:35 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9GG59pF014966
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 12:09:33 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dmvwtk14q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 12:09:33 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 16 Oct 2017 17:09:30 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9GG9Of020054070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:09:26 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9GG9HF3027016
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 03:09:18 +1100
Subject: Re: [PATCH 2/2] powerpc/perf/imc: use NUMA_NO_NODE for
 alloc_pages_node
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
References: <1508093022-11496-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1508093022-11496-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20171016131858.73b37570@firefly.ozlabs.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 21:39:20 +0530
MIME-Version: 1.0
In-Reply-To: <20171016131858.73b37570@firefly.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ad7d35e7-565f-642a-1cb5-ef89b2f81414@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 16 October 2017 07:48 AM, Balbir Singh wrote:
> On Mon, 16 Oct 2017 00:13:42 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> alloc_pages_node() when passed NUMA_NO_NODE for the
>> node_id, could get memory from closest node. Cleanup
>> core imc and thread imc memory init functions to use
>> NUMA_NO_NODE.
>
> The changelog is not clear, alloc_pages_node() takes a
> preferred node id and creates a node zonelist from it.
> How is NUMA_NO_NODE better?

IIUC with NUMA_NO_NODE we could remove the __GFP_NOWARN
for alloc_pages_node(). That said, one must be careful to make
sure we dont end up allocating memory from the boot cpu.
And incase of In Memory Collection (IMC) counters, it is handled
in the cpu online path.

Will send a v2 with __GFP_NOWARN removed which
I missed in this :)  .

Maddy

> Balbir Singh.
>
