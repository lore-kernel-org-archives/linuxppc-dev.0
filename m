Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMlF13xyHzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 17:29:24 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v727TBhT078793
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 03:29:22 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c385neqfd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 03:29:21 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 17:28:47 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v727SicG18939980
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 17:28:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v727ShUM022442
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 17:28:43 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Question on hugepages_supported()
In-Reply-To: <bbc6ae12-1705-32e1-109b-baefead9444b@c-s.fr>
References: <bbc6ae12-1705-32e1-109b-baefead9444b@c-s.fr>
Date: Wed, 02 Aug 2017 12:58:38 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a83i1l95.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> In include/linux/hugetlb.h, we find the following statement
>
> #ifndef hugepages_supported
> /*
>   * Some platform decide whether they support huge pages at boot
>   * time. Some of them, such as powerpc, set HPAGE_SHIFT to 0
>   * when there is no such support
>   */
> #define hugepages_supported() (HPAGE_SHIFT != 0)
> #endif
>
> But in arch/powerpc/include/asm/page.h we find:
>
> #ifdef CONFIG_HUGETLB_PAGE
> extern unsigned int HPAGE_SHIFT;
> #else
> #define HPAGE_SHIFT PAGE_SHIFT
> #endif
>
>
> Is that correct ? SHouldn't HPAGE_SHIFT be defined to 0 when 
> CONFIG_HUGETLB_PAGE is not defined ?
>

But then hugepages_supported() is only defined if HUGETLB_PAGE is
enabled. So yes we can possibly say HPAGE_SHIFT = 0 if HUGETLB is
disabled, I am not sure it has any impact with the current code ?


-aneesh
