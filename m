Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlRp1492CzDqxH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:01:29 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u675xEpp109967
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 02:01:27 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xkcrqa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 02:01:26 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 7 Jul 2016 16:01:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4DB203578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:01:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6761LA07471588
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:01:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6761KiB024165
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:01:21 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Huy Nguyen <huyn@mellanox.com>
Subject: Re: [PATCH 08/14] cxl: Add kernel APIs to get & set the max irqs per
 context
In-reply-to: <577D49E4.2030803@linux.vnet.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-9-git-send-email-imunsie@au.ibm.com>
 <577D49E4.2030803@linux.vnet.ibm.com>
Date: Thu, 07 Jul 2016 16:00:48 +1000
Message-Id: <1467871047-sup-8682@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-07-06 20:11:48 +0200:
> 
> Le 04/07/2016 15:22, Ian Munsie a écrit :
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >
> > These APIs will be used by the Mellanox CX4 support. While they function
> > standalone to configure existing behaviour, their primary purpose is to
> > allow the Mellanox driver to inform the cxl driver of a hardware
> > limitation, which will be used in a future patch.
> >
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> 
> Any way to add a check that the "set max" API is called before the 
> interrupts are allocated?

I don't think there is any real need - if the set max API has not been
called then we use the maximum number of interrupts possible on the PHB,
which is the correct thing to do if we don't need the workaround. We
could try adding a WARN in the set max API if interrupts have previously
been allocated, but realistically - if a driver developer needs to use
this they already know it and will be testing for it.

Cheers,
-Ian
