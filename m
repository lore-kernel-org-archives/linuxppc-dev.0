Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRzCh34WtzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 23:42:40 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4GDYXGL116983
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 09:42:37 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ag1g2ucxw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 09:42:37 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 May 2017 23:42:34 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4GDgOuX62783680
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 23:42:32 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4GDfxvw001615
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 23:42:00 +1000
Date: Tue, 16 May 2017 19:11:41 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Subject: Re: [RFC 0/2] Consolidate patch_instruction
References: <20170516034913.21163-1-bsingharora@gmail.com>
 <886e774c-c555-5547-2c03-22d611f2551f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <886e774c-c555-5547-2c03-22d611f2551f@linux.vnet.ibm.com>
Message-Id: <20170516134141.GB19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/05/16 10:56AM, Anshuman Khandual wrote:
> On 05/16/2017 09:19 AM, Balbir Singh wrote:
> > patch_instruction is enhanced in this RFC to support
> > patching via a different virtual address (text_poke_area).
> 
> Why writing instruction directly into the address is not
> sufficient and need to go through this virtual address ?

To enable KERNEL_STRICT_RWX and map all of kernel text to be read-only?

> 
> > The mapping of text_poke_area->addr is RW and not RWX.
> > This way the mapping allows write for patching and then we tear
> > down the mapping. The downside is that we introduce a spinlock
> > which serializes our patching to one patch at a time.
> 
> So whats the benifits we get otherwise in this approach when
> we are adding a new lock into the equation.

Instruction patching isn't performance critical, so the slow down is 
likely not noticeable. Marking kernel text read-only helps harden the 
kernel by catching unintended code modifications whether through 
exploits or through bugs.

- Naveen
