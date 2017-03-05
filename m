Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbz9H48G0zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:08:03 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v25N7NvZ010092
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 18:07:54 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ytm407v2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 18:07:54 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 6 Mar 2017 09:07:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6C90B2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:07:50 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v25N7gZ540960032
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:07:50 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v25N7Hx5007788
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:07:18 +1100
Subject: Re: [PATCH] powerpc/xics: Fix migrate_irqs_away - set CPPR to
 lowest priority
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 06 Mar 2017 10:06:49 +1100
In-Reply-To: <87fuizrgbc.fsf@concordia.ellerman.id.au>
References: <20170227003655.18459-1-bsingharora@gmail.com>
 <87fuizrgbc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1488755209.2870.116.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-27 at 23:03 +1100, Michael Ellerman wrote:
> It took me a while to parse that.
> 
> So because of the way the OPAL XICS emulation is implemented, setting
> the CPPR to DEFAULT_PRIORITY has the effect of masking all
> interrupts.
> 
> That is because the OPAL code internally maps all priorities that are
> >
> 0 and < 0xff to a single priority. It happens to use 7, but I don't
> think that matters does it? It's just that there's no differentiation
> between DEFAULT and IPI.
> 
> I realise we need to work around it anyway, but are we calling this a
> bug in the XICS emulation? Or just an alternate feature? :)
> 
> Have we thought about doing the fix in icp_opal_set_cpu_priority()
> instead?

The fix in OPAL is doable but requires churn. I would have to do IPIs
differently (the way I do them in KVM XICS emulation actually which is
noticeably better).

I will eventually do it I think but for now, I favor this patch instead
because the existing code is also broken for Balbir WIP patch that
removes the separate priority for IPIs to do lazy masking in the XICS.

Cheers,
Ben.
