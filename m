Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8B8D1A05BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 17:30:06 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 16:29:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B82D93578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 17:29:42 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0M6TC5L43843674
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 17:29:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0M6T9QV011732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 17:29:10 +1100
Message-ID: <56A1CC1C.3000009@linux.vnet.ibm.com>
Date: Fri, 22 Jan 2016 11:58:44 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
CC: Dan Williams <dan.j.williams@intel.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Allow user space to map rtas_rmo_buf
References: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1453440564.21683.8.camel@ellerman.id.au>
In-Reply-To: <1453440564.21683.8.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2016 10:59 AM, Michael Ellerman wrote:
> On Thu, 2016-01-21 at 21:45 +0530, Vasant Hegde wrote:
> 
>> With commit 90a545e9 (restrict /dev/mem to idle io memory ranges) mapping
>> rtas_rmo_buf from user space is failing. Hence we are not able to make
>> RTAS syscall.
>>
>> This patch calls page_is_rtas_user_buf before calling iomem_is_exclusive
>> in  devmem_is_allowed(). This will allow user space to map rtas_rmo_buf
>> and we are able to make RTAS syscall.

Michael,

> 
> Thanks for the patch.
> 
> I'll put it in my fixes branch for next week.

Thanks!

> 
> 
> Having said that, why the <expletive deleted> is librtas mapping /dev/mem in
> the first place? Unless there is a very good reason, and probably even if there
> is, we should fix that to use a sane API.

We use rtas system call. We use /dev/mem interface to map the RTAS memory region
(allocated by kernel and information is passed to user space via procfs) so that
we can read/write to RTAS memory.

I do not have historical information. May be Nathan has more information on this.

-Vasant
