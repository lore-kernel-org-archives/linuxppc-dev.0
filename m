Return-Path: <clombard@linux.vnet.ibm.com>
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DEE61A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 20:21:33 +1100 (AEDT)
Received: from /spool/local
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 6 Oct 2015 10:21:30 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 02BA32190066
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 10:21:26 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t969LQvC36241576
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 09:21:26 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t969LQBJ010915
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 03:21:26 -0600
Subject: Re: [PATCH] cxl: Fix number of allocated pages in SPA
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1443794485-30565-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1444112342.16578.1.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
From: christophe lombard <clombard@linux.vnet.ibm.com>
Message-ID: <56139295.3050109@linux.vnet.ibm.com>
Date: Tue, 6 Oct 2015 11:21:25 +0200
MIME-Version: 1.0
In-Reply-To: <1444112342.16578.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The field 'num_procs' of the structure cxl_afu is not updated to the
right value (maximum number of processes that can be supported by
the AFU) when the pages are allocated (i.e. when  cxl_alloc_spa() is called).
The number of allocates pages depends on the max number of processes.

Thanks


On 06/10/2015 08:19, Michael Ellerman wrote:
> On Fri, 2015-10-02 at 16:01 +0200, Christophe Lombard wrote:
>> This moves the initialisation of the num_procs to before the SPA
>> allocation.
> Why? What does it fix? I can't tell from the diff or the change log.
>
> cheers
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
