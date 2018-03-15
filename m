Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401ywX0FSZzDrRX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 17:14:19 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2F6DbjY053813
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 02:14:17 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gqjxyrwyn-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 02:14:16 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 15 Mar 2018 06:14:15 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cxl: Perform NULL check for 'cxl_afu *' at various places
 in cxl
In-Reply-To: <c97946a0-2488-5892-66ae-5ad8e5a0007f@linux.vnet.ibm.com>
References: <20180308100547.2994-1-vaibhav@linux.vnet.ibm.com>
 <c97946a0-2488-5892-66ae-5ad8e5a0007f@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 11:44:10 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87605x7tn1.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for reviewing this patch Fred,

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> So we are calling functions with an invalid afu argument. We can verify 
> in the callees the value of the afu pointer, like you're doing here, but 
> why not tackle it at source and avoid calling the function in the first 
> place?
Couple of reasons:
* Having checks for NULL afu at the call sites rather than the functions
  being called will lead to these checks scattered at more than a few
  places in code. Many of these functions are called via indirect branch
  from cxl_backend_ops and have their call sites scattered in the
  code. Having this check in the called functions is a much smaller change
  in comparison.

* Some of these functions are called are called from outside CXL e.g
  cxl_dev_context_init(). So putting the NULL check at every caller site
  might not be possible.

* Some funtions need to handle AFU init failures in special way e.g like
  cxl_vphb_error_detected() need to force a card hotplug so that AFU
  reinit can be tried.

* None of these functions are in any hotpath in the code so having an
  extra check at the beginning of the code wont have a much performance
  impact.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
