Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpvws66sRzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 19:20:29 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5G9J9sA143914
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 05:20:27 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b48hwtywt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 05:20:26 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 16 Jun 2017 19:20:24 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5G9KL5R47120532
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 19:20:21 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5G9KI9E031415
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 19:20:19 +1000
Subject: Re: [RFC PATCH 7/7 v1]powerpc: Deliver SEGV signal on protection key
 violation.
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
Cc: dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 16 Jun 2017 14:50:13 +0530
MIME-Version: 1.0
In-Reply-To: <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <622d7abf-3d99-8897-5afb-ef8c4f950fc0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2017 06:35 AM, Ram Pai wrote:
> The value of the AMR register at the time of the exception
> is made available in gp_regs[PT_AMR] of the siginfo.

But its already available there in uctxt->uc_mcontext.regs->amr
while inside the signal delivery context in the user space. The
pt_regs already got updated with new AMR register. Then why we
need gp_regs to also contain AMR as well ?
