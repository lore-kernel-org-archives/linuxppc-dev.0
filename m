Return-Path: <jallen@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl5330MnNzDr0y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 01:56:31 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rl53225Ccz9sD9
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Jul 2016 01:56:28 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66Fsueo053034
 for <linuxppc-dev@ozlabs.org>; Wed, 6 Jul 2016 11:56:26 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240nk9wtkg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Jul 2016 11:56:26 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 11:56:25 -0400
Subject: Re: [PATCH 0/3] powerpc/pseries: Add pseries hotplug queue and
 PowerVM/PowerKVM use cases
To: linuxppc-dev@ozlabs.org, nfont@linux.vnet.ibm.com, mpe@ellerman.id.au
References: <20160706154142.19739.90609.stgit@ltcbrazos2-lp13.aus.stglabs.ibm.com>
Cc: mdroth@linux.vnet.ibm.com
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 10:56:55 -0500
MIME-Version: 1.0
In-Reply-To: <20160706154142.19739.90609.stgit@ltcbrazos2-lp13.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <789e6fbb-8e6b-06b8-ba75-9e7ac4cfb5f4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I forgot to run this series through checkpatch before sending. Looks like there
are some various whitespace errors. Will fix these and send with v2 after any
comments on the patches.

On 07/06/2016 10:44 AM, John Allen wrote:
> This series introduces a new workqueue for handling hotplug events. On
> PowerKVM guests, this provides a work deferral mechanism to avoid
> processing hotplug events in interrupt context. On PowerVM lpars, this
> will be used to ensure that hotplug events initiated from the HMC and
> from PRRN events are handled and serialized properly.
> 
> ---
> 
> John Allen (3):
>       powerpc/pseries: Add pseries hotplug workqueue
>       powerpc/pseries: Add support for hotplug interrupt source
>       powerpc/pseries: Use kernel hotplug queue for PowerVM hotplug events
> 
> 
>  arch/powerpc/platforms/pseries/dlpar.c   |   57 +++++++++++++++++++++++++++++-
>  arch/powerpc/platforms/pseries/pseries.h |    2 +
>  arch/powerpc/platforms/pseries/ras.c     |   38 ++++++++++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
> 
> --
> John Allen
> 
