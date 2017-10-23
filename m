Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLRBH6K6MzDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 06:22:47 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NJL1bG064737
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 15:22:45 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dsj2tmf90-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 15:22:45 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 23 Oct 2017 13:22:44 -0600
Date: Mon, 23 Oct 2017 12:22:36 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com,
 mhocko@kernel.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH 4/7] powerpc: Free up four 64K PTE bits in 64K backed
 HPTE pages
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-5-git-send-email-linuxram@us.ibm.com>
 <1505376837.12628.192.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505376837.12628.192.camel@kernel.crashing.org>
Message-Id: <20171023192236.GA5488@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 06:13:57PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2017-09-08 at 15:44 -0700, Ram Pai wrote:
> > The second part of the PTE will hold
> > (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
> > NOTE: None of the bits in the secondary PTE were not used
> > by 64k-HPTE backed PTE.
> 
> Have you measured the performance impact of this ? The second part of
> the PTE being in a different cache line there could be one...

hmm..missed responding to this comment.

I did a preliminay measurement running mmap bench in the selftest.
Ran it multiple times. almost always the numbers were either equal-to
or better-than without the patch-series.

RP
