Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0pwt2dXZzDvXp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 02:09:02 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9LF3ZEu034414
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 11:09:00 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 267f7f31cp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 11:08:59 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Fri, 21 Oct 2016 16:08:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0DCBF1B08023
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 16:11:01 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9LF8u7Y26476588
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 15:08:56 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9LF8tvv015488
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 09:08:56 -0600
Subject: Re: [PATCH/RFC 0/5] cpu_relax: introduce yield, remove lowlatency
To: David Miller <davem@davemloft.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
 <20161021.105727.140184460493941551.davem@davemloft.net>
Cc: peterz@infradead.org, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
 schwidefsky@de.ibm.com, noamc@ezchip.com,
 virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, KVM list <kvm@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 Oct 2016 17:08:54 +0200
MIME-Version: 1.0
In-Reply-To: <20161021.105727.140184460493941551.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <2cf23cb7-05c5-0a2d-2ed5-aa90d582f802@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/21/2016 04:57 PM, David Miller wrote:
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> Date: Fri, 21 Oct 2016 13:58:53 +0200
> 
>> For spinning loops people did often use barrier() or cpu_relax().
>> For most architectures cpu_relax and barrier are the same, but on
>> some architectures cpu_relax can add some latency. For example on s390
>> cpu_relax gives up the time slice to the hypervisor. On power cpu_relax
>> tries to give some of the CPU to the neighbor threads. To reduce the
>> latency another variant cpu_relax_lowlatency was introduced. Before this
>> is used in more and more places, lets revert the logic of provide a new
>> function cpu_relax_yield that can spend some time and for s390 yields
>> the guest CPU.
> 
> Sparc64, fwiw, behaves similarly to powerpc.

As sparc currently defines cpu_relax_lowlatency to cpu_relax, this patch set
should be a no-op then for sparc, correct?

My intend was that cpu_relax should not add a huge latency but can certainly
push some cpu power to hardware threads of the same core. This seems to be
the case for sparc/power and some arc variants. 

Christian
