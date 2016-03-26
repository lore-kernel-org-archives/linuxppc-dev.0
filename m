Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXMXh2jXLzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:11:16 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 00:11:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B12243578052
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:11:06 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2QEAwUB21430296
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:11:06 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2QEAXgC009256
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:10:34 +1100
Date: Sat, 26 Mar 2016 23:50:08 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 zhlcindy@linux.vnet.ibm.com, bsingharora@gmail.com
Subject: Re: [RFC] powerpc/mm: Support bootmem for PPC64 again
Message-ID: <20160326125008.GA30131@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1458921821-14960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <3qXF961KWTz9s4x@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3qXF961KWTz9s4x@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 26, 2016 at 08:23:54PM +1100, Michael Ellerman wrote:
>On Fri, 2016-25-03 at 16:03:41 UTC, Gavin Shan wrote:
>> CONFIG_NO_BOOTMEM is enabled on PPC platforms by default. However,
>> user might disable that to have bootmem for other purpose. So it's
>> resonable to support it.
>
>Hi Gavin,
>
>Sorry but I don't understand. We deliberately removed bootmem support, and don't
>want it back, it doesn't add anything other than complexity. See 10239733ee86
>("powerpc: Remove bootmem allocator").
>
>I wasn't aware there was any way to enable it? If there is we should fix that.
>

[Cc Balbir so that I needn't reply separately]

Michael, here's the history: Li, who is in the cc list, backports deferred
page initialization feature from upstream kernel to RHEL 7.2 (3.10.0-357.el7,
or RHEL7.3?). Eventually, she runs into system kernel crash that should be caused
by memory corruption. In RHEL kernel, CONFIG_BOOTMEM and CONFIG_DEFERRED_STRUCT_PAGE_INIT
are enabled at same time. Li observed the issue on pSeries platform.

I jumped in to help understanding what was going on. I tried to reproduce the issue
on PowerNV platform with upstream kernel (v4.5-rc7) and found bootmem is never supported.
In order to trigger the system crash with exact scenario that Li had. I have to support
bootmem first of all.

I guess it's fine to remove bootmem which allocates memory in page granularity. From
the perspective, it's not different from memblock. But user might still need bootmem
supported in code level. The story I told might be not enough to get bootmem to be
supported in code level. If that's the case, please ignore the patch. At least, we
won't support bootmem in long term :-)

Thanks,
Gavin
