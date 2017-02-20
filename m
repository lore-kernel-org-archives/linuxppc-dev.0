Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRXST0YHZzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 16:36:56 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1K5Xm38101431
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 00:36:55 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28qd5jr62e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 00:36:54 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 15:36:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CB9CD3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 16:36:50 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1K5ag4G26083572
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 16:36:50 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1K5aH30006843
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 16:36:18 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hugetlb: Filter out hugepage size not
 supported by page table layout
In-Reply-To: <1487561746.23576.170.camel@kernel.crashing.org>
References: <1487499527-16166-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487538354.23576.158.camel@kernel.crashing.org>
 <fdc5f84d-f337-24e6-e116-e34cf6ff722b@linux.vnet.ibm.com>
 <1487561746.23576.170.camel@kernel.crashing.org>
Date: Mon, 20 Feb 2017 11:06:00 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87o9xxtoe7.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2017-02-20 at 09:02 +0530, Aneesh Kumar K.V wrote:
>> To avoid crashes like the one reported in the commit message due to=C2=A0
>> buggy firmware ?=20
>
> I don't want Linux to make those assumptions. We should fix the FW.
>

I was not suggesting to not fix FW. The idea was two fold.

We cannot support different hugetlb page sizes. They need to
be supported at linux page table level. So a generic check like
is_power_of_2/4() may not be what we want. The second is to document
clearly what are the different page sizes supported by a platform.

-aneesh
