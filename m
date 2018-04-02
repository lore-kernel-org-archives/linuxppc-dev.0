Return-Path: <prvs=0630b54844=ppaidipe@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FFY06W5DzF259
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 00:51:24 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w32EoT3B060368
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Apr 2018 10:51:21 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h3ne9khp2-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Apr 2018 10:51:21 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ppaidipe@linux.vnet.ibm.com>;
 Mon, 2 Apr 2018 10:51:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 02 Apr 2018 20:22:45 +0530
From: ppaidipe <ppaidipe@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Vasant Hegde
 <hegdevasant@linux.vnet.ibm.com>, Linuxppc-dev
 <linuxppc-dev-bounces+ppaidipe=linux.vnet.ibm.com@lists.ozlabs.org>
Subject: Re: [PATCH 0/3] stop secondaries for reboot/shutdown
In-Reply-To: <20180401103615.15454-1-npiggin@gmail.com>
References: <20180401103615.15454-1-npiggin@gmail.com>
Message-Id: <4c58f75d7ddfd61b171400a73721aa9d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018-04-01 16:06, Nicholas Piggin wrote:
> I'm rebasing and resending this series because the hard
> lockup messages are being seen in the field.
> 
> Since last time, one of the patches was merged, and patches
> were split and reordered a bit. No major changes.
> 
> This still hasn't been tested with the FSP firmware update.
> 

I have tested this series on a FSP platform with firmware update
and multiple reboot/shutdown tests. Not seen any issues.

Tested-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>

Thanks
Pridhiviraj

> Thanks,
> Nick
> 
> Nicholas Piggin (3):
>   powerpc: use NMI IPI for smp_send_stop
>   powerpc: hard disable irqs in smp_send_stop loop
>   powerpc/powernv: Always stop secondaries before reboot/shutdown
> 
>  arch/powerpc/include/asm/opal.h             |  2 +-
>  arch/powerpc/kernel/smp.c                   | 13 +++++++++++--
>  arch/powerpc/platforms/powernv/opal-flash.c | 28 
> +---------------------------
>  arch/powerpc/platforms/powernv/setup.c      | 15 +++++----------
>  4 files changed, 18 insertions(+), 40 deletions(-)
