Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNx6w6HfpzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 15:58:16 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v745s3sx023316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 01:58:14 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c4h1pq1xk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 01:58:14 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 15:58:11 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v745w1pS26542104
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 15:58:09 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v745vaRt003780
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 15:57:37 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Victor Aoqui <victora@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com
Cc: victora@br.ibm.com, victora@linux.vnet.ibm.com, mauricfo@linux.vnet.ibm.com
Subject: Re: [PATCH v3] powerpc/mm: Implemented default_hugepagesz
 verification for powerpc
In-Reply-To: <20170724235202.5675-1-victora@linux.vnet.ibm.com>
References: <20170724235202.5675-1-victora@linux.vnet.ibm.com>
Date: Fri, 04 Aug 2017 11:27:07 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zibf3mfg.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Victor Aoqui <victora@linux.vnet.ibm.com> writes:

> Implemented default hugepage size verification (default_hugepagesz=)
> in order to allow allocation of defined number of pages (hugepages=)
> only for supported hugepage sizes.
>
> Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>

I am still not sure about this. With current upstream we get

 PCI: Probing PCI hardware                                     
 PCI: Probing PCI hardware done                                                                                                                       
 HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 16777216                                                                               
 HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages                                                                                         
 HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages  

That warning is added by

d715cf804a0318e83c75c0a7abd1a4b9ce13e8da

Which should be good enough right ?

-aneesh
