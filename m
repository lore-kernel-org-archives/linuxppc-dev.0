Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A8B51A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 08:53:21 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 08:53:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F170D2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 08:53:13 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t91Mr5lA63438942
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 08:53:13 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t91Mqeqs032253
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 08:52:41 +1000
Date: Fri, 2 Oct 2015 06:51:59 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/iommu: use iommu_num_pages() to calculate the
 number of iommu page
Message-ID: <20151001225159.GA6145@Richards-MBP.lan>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1442667867-1802-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150930235054.GA1530@Richards-MBP.lan>
 <1443672945.3058.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443672945.3058.0.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 01, 2015 at 02:15:45PM +1000, Michael Ellerman wrote:
>On Thu, 2015-10-01 at 07:50 +0800, Wei Yang wrote:
>> Hmm... some comments on this one? like it or not?
>
>It sounds like it's fixing a bug, but you don't really say. Have you seen this
>fail in the wild?

Hmm... as described in the commit log, this would be a bug when 
PAGE_SIZE is much smaller than IOMMU Page Size. This configuration doesn't
happen on current platform. So I didn't see this failure yet.

>
>Which commit introduced the breakage?

Hmm...  maybe we could say it is 'commit d084775738b7
<powerpc/iommu: Update the generic code to use dynamic iommu page sizes>'.
>From this commit, powerpc iommu supports dynamic iommu page size. 

Before this commit, the size is aligned with PAGE_SIZE, so the value after
shift would be non-zero. After this commit, when PAGE_SIZE is smaller than
the IOMMU Page Size, shift right will make the size 0.

>
>cheers
>

-- 
Richard Yang
Help you, Help me
