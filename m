Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc57z0jrJzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 14:37:18 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v263YHge022797
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 22:37:13 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28yxxkynm9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 22:37:11 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 6 Mar 2017 13:37:09 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B74552CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 14:37:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v263aw8b41222172
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 14:37:06 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v263aYkp021347
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 14:36:34 +1100
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Gracefully fail if too
 many TCE levels requested
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, David Gibson
 <david@gibson.dropbear.id.au>
Date: Mon, 06 Mar 2017 14:36:09 +1100
In-Reply-To: <cd84399e-73d6-72dd-8509-f45db5e47d31@ozlabs.ru>
References: <20170222044359.3663-1-aik@ozlabs.ru>
 <87innvrj9h.fsf@concordia.ellerman.id.au>
 <1488755034.2870.114.camel@au1.ibm.com>
 <cd84399e-73d6-72dd-8509-f45db5e47d31@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1488771369.2870.123.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-06 at 12:28 +1100, Alexey Kardashevskiy wrote:
> 8192*8192*8192*65536>>40 = 32768TB of addressable memory (but there is no
> good reason not to use huge pages);

No, 39 bits is half a TB. That's not enough.

> 8192*8192*8192*4096>>40 = 2048TB or addressable memory (even with 2
> indirect levels but we can have all 5 levels with 4K IOMMU pages).
> 
> Looks enough to me...
> 
> And in this particular patch I am not limiting anything, I just replace
> already existing EEH condition with -EINVAL. If it is this important to
> have all 5 levels, then we can switch from alloc_pages_node() to
> kmem_cache_alloc_node(), in a separate patch.
> 
> 
> -- 
