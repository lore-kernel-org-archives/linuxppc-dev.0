Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfnc71gm6zDqxK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 02:06:47 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TFwqvC037768
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 12:06:45 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwnmgt9f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 12:06:44 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 17:06:42 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 51AAB1B08072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:07:43 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TG6SEu66519054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:06:28 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TG6Rpo023322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 10:06:27 -0600
Subject: Re: [PATCH 2/2] cxl: Fix allocating a minimum of 2 pages for the SPA
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
 <1467202586-13412-2-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 29 Jun 2016 18:06:26 +0200
MIME-Version: 1.0
In-Reply-To: <1467202586-13412-2-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5773F202.5010709@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/06/2016 14:16, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The Scheduled Process Area is allocated dynamically with enough pages to
> fit at least as many processes as the AFU descriptor indicated. Since
> the calculation is non-trivial, it does this by calculating how many
> processes could fit in an allocation of a given order, and increasing
> that order until it can fit enough processes or hits the maximum
> supported size.
>
> Currently, it will start this search using a SPA of 2 pages instead of
> 1. This can waste a page of memory if the AFU's maximum number of
> supported processes was small enough to fit in one page.
>
> Fix the algorithm to start the search at 1 page.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>


Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
