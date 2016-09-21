Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfMbG4DYhzDsgh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 00:34:50 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LEXTvg110634
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:34:48 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25kta9dvy6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:34:47 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 11:34:45 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 73459352006C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:34:18 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LEYgpr39452680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:34:42 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8LEYfGv020698
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:34:42 -0300
Subject: Re: powerpc: add kernel parameter iommu_alloc_quiet
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <3sfLdY1WwLz9syB@ozlabs.org>
Cc: jthumshirn@suse.com, duwe@suse.com
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 21 Sep 2016 11:34:38 -0300
MIME-Version: 1.0
In-Reply-To: <3sfLdY1WwLz9syB@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d5a4d7c5-a700-b990-620d-132f09d69be0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Thanks for the review.

On 09/21/2016 10:51 AM, Michael Ellerman wrote:
>> That is important/requirement for the distribution kernels - where
>> the DMA_ATTR_NO_WARN changes to 'enum dma_attr' are not acceptable
>> because it breaks the kernel ABI.
[snip]
 > Removing an entry from an enum would break the API (Note _P_). But I 
don't see
 > how adding one does.

Agree.. I should have worded 'already-built out-of-tree modules'.

If I understand it correctly, this chunk will change the value of
DMA_ATTR_MAX, and thus break the ABI for out-of-tree modules that
depend on it. (Not that I know of any that use it, but that's the
reason that causes distro kernel builds to fail w/ this applied.)

@@ -19,6 +19,7 @@ enum dma_attr {
  	DMA_ATTR_SKIP_CPU_SYNC,
  	DMA_ATTR_FORCE_CONTIGUOUS,
  	DMA_ATTR_ALLOC_SINGLE_PAGES,
+	DMA_ATTR_NO_WARN,
  	DMA_ATTR_MAX,
  };

> Also kernel command line parameters are really poor in terms of usability. Folks
> really don't want to have to change their kernel command line.
>
> If we really need a hack for distros then I'd suggest we add a global struct
> driver * in the powerpc iommu code, and then when nvme loads it sets that to
> point at itself, and then the check becomes:

Agree w/ cmdline args are poor for usability, and that this new hack is
certainly smarter -- however, it does not provide any option/choice for
the user of whether enable/disable it (ie driver automatically sets it).

Although that isn't a problem for older downstream nvme drivers, which
have a single OK-to-fail dma mapping callsite (so the message doesn't
matter at all), the newer downstream drivers also have a Not-OK-to-fail
callsite, which is still worth to get the 'iommu_alloc failed' message
(per Ben's point of 'message useful for debugging').

For the latter, I think an upstream patch like this suggestion is not
a generally acceptable approach.

So, the intent is to have a single/common hack that upstream is OK w/,
then apply that downstream in the multiple distros.  Of course, if you
are not OK w/ this patch (which is obviously fair) we'll have to try it
downstream only, and there we can diverge in the implementations.

Please let me know your thoughts on it.

Thanks!

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
