Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20B641A0100
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 22:30:23 +1100 (AEDT)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Sat, 21 Nov 2015 11:30:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 80BF01B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 11:30:38 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tALBUGSs10158566
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 11:30:17 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tALBUFnY026760
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 04:30:16 -0700
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
To: Michael Ellerman <mpe@ellerman.id.au>, Ming Lei <ming.lei@canonical.com>
References: <1447838334.1564.2.camel@ellerman.id.au>
 <1447855399.3974.24.camel@redhat.com>
 <1447894964.15206.0.camel@ellerman.id.au>
 <20151119082325.GA11419@infradead.org>
 <1448021448.14769.7.camel@ellerman.id.au>
Cc: Christoph Hellwig <hch@infradead.org>, Mark Salter <msalter@redhat.com>,
 "James E. J. Bottomley" <JBottomley@odin.com>,
 brking <brking@us.ibm.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <565055C6.5040801@linux.vnet.ibm.com>
Date: Sat, 21 Nov 2015 12:30:14 +0100
MIME-Version: 1.0
In-Reply-To: <1448021448.14769.7.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/11/2015 13:10, Michael Ellerman wrote:
> On Thu, 2015-11-19 at 00:23 -0800, Christoph Hellwig wrote:
> 
>> It's pretty much guaranteed a block layer bug, most likely in the
>> merge bios to request infrastucture where we don't obey the merging
>> limits properly.
>>
>> Does either of you have a known good and first known bad kernel?
> 
> Not me, I've only hit it one or two times. All I can say is I have hit it in
> 4.4-rc1.
> 
> Laurent, can you narrow it down at all?

It seems that the panic is triggered by the commit bdced438acd8 ("block:
setup bi_phys_segments after splitting") which has been pulled by the
merge d9734e0d1ccf ("Merge branch 'for-4.4/core' of
git://git.kernel.dk/linux-block").

My system is panicing promptly when running a kernel built at
d9734e0d1ccf, while reverting the commit bdced438acd8, it can run hours
without panicing.

This being said, I can't explain what's going wrong.

May Ming shed some light here ?

Cheers
