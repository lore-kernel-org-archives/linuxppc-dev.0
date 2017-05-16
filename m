Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRmD10kPhzDqPX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 15:27:12 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G5IW2k111686
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 01:27:07 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afqcmsjnf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 01:27:07 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 May 2017 15:27:04 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4G5Qsu75243248
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 15:27:02 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4G5QTWT020105
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 15:26:30 +1000
Subject: Re: [RFC 0/2] Consolidate patch_instruction
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <20170516034913.21163-1-bsingharora@gmail.com>
Cc: naveen.n.rao@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 16 May 2017 10:56:10 +0530
MIME-Version: 1.0
In-Reply-To: <20170516034913.21163-1-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <886e774c-c555-5547-2c03-22d611f2551f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2017 09:19 AM, Balbir Singh wrote:
> patch_instruction is enhanced in this RFC to support
> patching via a different virtual address (text_poke_area).

Why writing instruction directly into the address is not
sufficient and need to go through this virtual address ?

> The mapping of text_poke_area->addr is RW and not RWX.
> This way the mapping allows write for patching and then we tear
> down the mapping. The downside is that we introduce a spinlock
> which serializes our patching to one patch at a time.

So whats the benifits we get otherwise in this approach when
we are adding a new lock into the equation.
