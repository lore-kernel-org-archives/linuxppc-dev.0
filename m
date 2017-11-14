Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybrsj6ShWzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 02:24:57 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAEFOZQf095058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 10:24:55 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e82qnhebn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 10:24:54 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Tue, 14 Nov 2017 10:24:53 -0500
Subject: Re: [PATCH] ibmveth: Kernel crash LSO offload flag toggle
To: Daniel Axtens <dja@axtens.net>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
References: <20171113230155.99682-1-bryantly@linux.vnet.ibm.com>
 <87wp2t3byi.fsf@linkitivity.dja.id.au>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 09:24:49 -0600
MIME-Version: 1.0
In-Reply-To: <87wp2t3byi.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <6b990276-6e6f-f892-72c9-b330c9a292c2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/13/17 7:07 PM, Daniel Axtens wrote:

> Hi Bryant,
>
> A few things:
>
> 1) The commit message could probably be trimmed, especially the stack
> traces.

Yes, I can trim it. 

> 2) What exactly are you changing and why does it fix the issue? I
> couldn't figure that out from the commit message.

The bounce buffer can be null when skb_copy_from_linear_data tries to use
it and that causes the kernel crash. Thus adding the check to see whether or
not bounce buffer is null prior to utilizing it.

>
> 3) Does this need a Fixes: tag?
>
Honestly, this bug has existed for a very long time. It only became more evident when 
commit 66aa0678efc29abd2ab02a09b23f9a8bc9f12a6c was committed. It is rare for a customer
to his this issue since a customer only toggles LSO once and leaves it, but to re-create
this bug one would need to write a script like the one in the commit message to toggle it
on and off in a loop. Its ultimately a legacy bug that was uncovered more recently. 

>>  	}
>>  
>> -	netdev->min_mtu = IBMVETH_MIN_MTU;
>> -	netdev->max_mtu = ETH_MAX_MTU;
>> -
> 4) What does the above hunk do? It seems unrelated...
>
You are right the above is just cleanup, I should have separated the patch. 

> Regards,
> Daniel
>
