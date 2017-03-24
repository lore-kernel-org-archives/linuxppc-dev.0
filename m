Return-Path: <srs0=h86y=3b=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqbrT5TbnzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 08:18:49 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vqbrT4wmNz8t3h
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 08:18:49 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vqbrT1S0qz9s3s
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2017 08:18:49 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2OLIcLM016844
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 17:18:39 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29cxexbrgq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 17:18:39 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 24 Mar 2017 17:18:36 -0400
Date: Fri, 24 Mar 2017 14:18:22 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <michael.neuling@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stewart@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, apopple@au1.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v3 04/10] VAS: Define helpers for access MMIO regions
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490331198.28113.61.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490331198.28113.61.camel@au1.ibm.com>
Message-Id: <20170324211822.GB8330@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling [michael.neuling@au1.ibm.com] wrote:
> > +static inline void get_uwc_mmio_bar(struct vas_window *window,
> > +			uint64_t *start, int *len)
> > +{
> > +	uint64_t pbaddr;
> > +
> > +	pbaddr = window->vinst->uwc_bar_start;
> > +	*start = pbaddr + window->winid * VAS_UWC_SIZE;
> > +	*len = VAS_UWC_SIZE;
> 
> I'm not sure this works for 4K pages since VAS_UWC_SIZE = PAGE_SIZE but in
> reality I think it's always 64K.  Right?

I believe the idea is that each user process will have its OS/User Window
context on a separate page - to provide proper protection of the window
context between processes. So, the OS/User Window context size _is_ 
dependent on page size.

The page size is set to 64K in init_north_ctl() in skiboot but can be
set to 4K as well. The amount of memory allocated for the OS/User Window
Context MMIO BAR (init_uwcm() in skiboot) also depends on the page size
256MB for 4K or 4GB for 64K.

> 
> Seem like we are mixing pages sizes and hardware sizes here.
> 
> (I realise 4K isn't supported yet, but....)

Yes, only 64K page-size for now.

Thanks,

Sukadev
