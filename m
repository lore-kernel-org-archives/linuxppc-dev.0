Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BBE41A073F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:26:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 10:56:47 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B47971258056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 10:58:17 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K5QhbT18677800
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 10:56:43 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K5M8EA021633
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 10:52:08 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/dma: Remove ZONE_DMA completely
In-Reply-To: <1426711109.4770.78.camel@kernel.crashing.org>
References: <1424421344.27448.43.camel@kernel.crashing.org>
 <87zj7amlqn.fsf@linux.vnet.ibm.com>
 <1426711109.4770.78.camel@kernel.crashing.org>
Date: Fri, 20 Mar 2015 10:56:43 +0530
Message-ID: <87wq2cme7g.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Anton Blanchard <anton@au1.ibm.com>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2015-03-18 at 19:49 +0530, Aneesh Kumar K.V wrote:
>> Why not do it also for DMA32 as below. We call limit_zone_pfn() only
>> for few
>> platforms. They can select ZONE_DMA32. Everywhere else ZONE_DMA32 is
>> same as ZONE_NORMAL ? So instead of having confusing output for
>> show_mem(), we now have
>
> There may be cases where we want ZONE_DMA32, what's confusing ?
>
To see output like below

 Node 0 DMA32: 6*64kB (UM) 566*128kB (UEM) 367*256kB (UM) 185*512kB (UM)59*1024kB (UEM) 11*2048kB (UM) 4*4096kB (UM) 3*8192kB (UEM) 4016*16384kB

 Node 1 DMA32: 42*64kB (UEM) 14*128kB (UEM) 10*256kB (UM) 2*512kB (UM) 6*1024kB (UM) 7*2048kB (UEM) 5*4096kB (UM) 2*8192kB (U) 3644*16384kB (MR) =

 That is to find DMA32 convering more than 4GB range.

 -aneesh
