Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQFtl2sQlzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 11:37:34 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9U0YNcU133697
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Oct 2017 20:37:30 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dwdxqyb04-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Oct 2017 20:37:30 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sun, 29 Oct 2017 18:37:30 -0600
Date: Sun, 29 Oct 2017 17:37:19 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 mhocko@kernel.org, paulus@samba.org, ebiederm@xmission.com,
 bauerman@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH 20/25] powerpc: Handle exceptions caused by pkey violation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-29-git-send-email-linuxram@us.ibm.com>
 <874lqo4kf9.fsf@concordia.ellerman.id.au>
 <8737622gr6.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737622gr6.fsf@linux.vnet.ibm.com>
Message-Id: <20171030003719.GC5587@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 29, 2017 at 07:33:25PM +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > Ram Pai <linuxram@us.ibm.com> writes:
> >
> >> Handle Data and  Instruction exceptions caused by memory
> >> protection-key.
> >>
> >> The CPU will detect the key fault if the HPTE is already
> >> programmed with the key.
> >>
> >> However if the HPTE is not  hashed, a key fault will not
> >> be detected by the  hardware. The   software will detect
> >> pkey violation in such a case.
> >
> > That seems like the wrong trade off to me.
> >
> > It means every fault has to go through arch_vma_access_permitted(),
> > which is at least a function call in the best case, even when pkeys are
> > not in use, and/or the range in question is not protected by a key.
> 
> We don't really need to call arch_vma_access_permitted() in
> arch/powerpc/ do_page_fault(). Core kernel does that in
> handle_mm_fault(). So if the first fault is a bad access handle_mm_fault
> handle this. If it is a valid access we insert the right hash page table
> entry and then we do a wrong access, we detect that a key fault in the
> low level hash fault handler. IIUC, the call the
> arch_vma_access_permitted() from arch/powerpc/ can go away?


Yes. since handle_mm_fault() checks for key-violation, we can leverage
that in __do_page_fault(), instead of calling arch_vma_access_permitted().

Have fixed it in the next version of patches, about to to hit the mailing
list this week.

RP
