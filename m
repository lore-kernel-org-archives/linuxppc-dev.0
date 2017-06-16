Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq92B1fRmzDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 05:10:57 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5GJAF48139732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 15:10:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b4h6k9h1a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 15:10:54 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 16 Jun 2017 13:10:54 -0600
Date: Fri, 16 Jun 2017 12:10:41 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 7/7 v1]powerpc: Deliver SEGV signal on protection key
 violation.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
 <622d7abf-3d99-8897-5afb-ef8c4f950fc0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <622d7abf-3d99-8897-5afb-ef8c4f950fc0@linux.vnet.ibm.com>
Message-Id: <20170616191041.GA17588@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 16, 2017 at 02:50:13PM +0530, Anshuman Khandual wrote:
> On 06/06/2017 06:35 AM, Ram Pai wrote:
> > The value of the AMR register at the time of the exception
> > is made available in gp_regs[PT_AMR] of the siginfo.
> 
> But its already available there in uctxt->uc_mcontext.regs->amr
> while inside the signal delivery context in the user space. The
> pt_regs already got updated with new AMR register. Then why we
> need gp_regs to also contain AMR as well ?

It should not be available in uctxt->uc_mcontext.regs->amr.
In fact that field itself should not be there.

The ideas was to use one of the unused fields in gp_regs; without
extending gp_regs, to provide the contents of AMR. the 
PT_AMR offset in gp_regs is currently not used, which I am using
in this patch.

However this patch needs to be modified not to extend pt_regs,
or uctxt->uc_mcontext.regs

Thanks for initiating this concern.
RP

-- 
Ram Pai
