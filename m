Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmdmg3PNJzDqYx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 00:36:18 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LDPs9r113673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:36:15 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g97enemnu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:36:14 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Wed, 21 Feb 2018 13:36:13 -0000
Date: Wed, 21 Feb 2018 19:06:07 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 mwb@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v0 1/2] powerpc, drmem: Fix unexpected flag value in
 ibm, dynamic-memory-v2
Reply-To: bharata@linux.vnet.ibm.com
References: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
 <1519209387-29767-2-git-send-email-bharata@linux.vnet.ibm.com>
 <87zi42r2bh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zi42r2bh.fsf@concordia.ellerman.id.au>
Message-Id: <20180221133607.GA30038@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 21, 2018 at 10:48:18PM +1100, Michael Ellerman wrote:
> Bharata B Rao <bharata@linux.vnet.ibm.com> writes:
> 
> > Memory addtion and removal by count and indexed-count methods
> > temporarily mark the LMBs that are being added/removed by a special
> > flag value DRMEM_LMB_RESERVED. Accessing flags value directly at
> > a few places without proper accessor method is causing two unexpected
> > side-effects:
> >
> > - DRMEM_LMB_RESERVED bit is becoming part of the flags word of
> >   drconf_cell_v2 entries in ibm,dynamic-memory-v2 DT property.
> > - This results in extra drconf_cell entries in ibm,dynamic-memory-v2.
> >   For example if 1G memory is added, it leads to one entry for 3 LMBs
> >   and 1 separate entry for the last LMB. All the 4 LMBs should be
> >   defined by one entry here.
> >
> > Fix this by always accessing the flags by its accessor method
> > drmem_lmb_flags().
> >
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> Presumably:
> 
>   Fixes: 2b31e3aec1db ("powerpc/drmem: Add support for ibm, dynamic-memory-v2 property")

Yes.

Regards,
Bharata.
