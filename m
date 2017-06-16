Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq97s42FNzDqLD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 05:15:53 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5GJDdI1098458
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 15:15:51 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b4n9f02e1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 15:15:50 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 16 Jun 2017 13:15:50 -0600
Date: Fri, 16 Jun 2017 12:15:37 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 7/7 v1]powerpc: Deliver SEGV signal on protection key
 violation.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
 <622d7abf-3d99-8897-5afb-ef8c4f950fc0@linux.vnet.ibm.com>
 <1497609181.2897.100.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497609181.2897.100.camel@kernel.crashing.org>
Message-Id: <20170616191537.GB17588@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 16, 2017 at 08:33:01PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2017-06-16 at 14:50 +0530, Anshuman Khandual wrote:
> > On 06/06/2017 06:35 AM, Ram Pai wrote:
> > > The value of the AMR register at the time of the exception
> > > is made available in gp_regs[PT_AMR] of the siginfo.
> > 
> > But its already available there in uctxt->uc_mcontext.regs->amr
> > while inside the signal delivery context in the user space. The
> > pt_regs already got updated with new AMR register. Then why we
> > need gp_regs to also contain AMR as well ?
> 
> Also changing gp_regs layout/size is a major ABI issue...

Ben,
	
gp_regs size is not changed, nor is the layout. A unused field in
the gp_regs is used to fill in the AMR contents. Old binaries will not
be knowing about this unused field, and hence should not break.

New binaries can leverage this already existing but newly defined
field; to read the contents of AMR.

Is it still a concern?
RP

> 
> Ben.

-- 
Ram Pai
