Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfyxg19YwzDqlg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 09:07:32 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TMwtt9143413
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 19:07:29 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uuhuafex-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 19:07:29 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 30 Jun 2016 09:07:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1F2A02CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 09:07:25 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TN7PkW3277100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 09:07:25 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TN7OkS014203
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 09:07:24 +1000
Subject: Re: [PATCH 2/2] cxl: Fix allocating a minimum of 2 pages for the SPA
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
 <1467202586-13412-2-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 30 Jun 2016 09:07:23 +1000
MIME-Version: 1.0
In-Reply-To: <1467202586-13412-2-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <efa17cbb-f889-e705-7944-f716039ba41c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/06/16 22:16, Ian Munsie wrote:
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

Makes sense.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
