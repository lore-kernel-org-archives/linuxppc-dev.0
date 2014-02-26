Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3F2392C0081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 01:04:46 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 26 Feb 2014 14:04:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3CD0717D804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 14:05:12 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1QE4QIA64422122
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 14:04:27 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1QE4cPG009859
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 07:04:38 -0700
Message-ID: <530DF475.2040507@linux.vnet.ibm.com>
Date: Wed, 26 Feb 2014 15:04:37 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/crashdump : fix page frame number check in
 copy_oldmem_page
References: <20140224163055.7263.86979.stgit@nimbus>
 <1393292822.13244.5.camel@concordia>
In-Reply-To: <1393292822.13244.5.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/02/2014 02:47, Michael Ellerman wrote:
> On Mon, 2014-02-24 at 17:30 +0100, Laurent Dufour wrote:
>> In copy_oldmem_page, the current check using max_pfn and min_low_pfn to
>> decide if the page is backed or not, is not valid when the memory layout is
>> not continuous.
>>
>> This happens when running as a QEMU/KVM guest, where RTAS is mapped higher
>> in the memory. In that case max_pfn points to the end of RTAS, and a hole
>> between the end of the kdump kernel and RTAS is not backed by PTEs. As a
>> consequence, the kdump kernel is crashing in copy_oldmem_page when accessing
>> in a direct way the pages in that hole.
>>
>> This fix relies on the memblock's service memblock_is_region_memory to
>> check if the read page is part or not of the directly accessible memory.
> 
> Hi Laurent,
> 
> This looks good to me, assuming you've tested it on a PowerVM system as well as
> under KVM.

Hi Michael,

Yes I tested it on PowerVM (BE), KVM (BE) and Qemu TCG (BE).

Cheers,
Laurent.
