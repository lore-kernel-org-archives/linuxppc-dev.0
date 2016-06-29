Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfyF628kGzDqm9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:35:54 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TMY0FJ094055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:35:52 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uuhu9nkp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:35:52 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 30 Jun 2016 08:35:49 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3E87B2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:35:48 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TMZmrn9306510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:35:48 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TMZlRd002660
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:35:48 +1000
Subject: Re: [PATCH 1/2] cxl: Fix allowing bogus AFU descriptors with 0
 maximum processes
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 30 Jun 2016 08:35:44 +1000
MIME-Version: 1.0
In-Reply-To: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <25e443a7-fb1b-4290-4d21-31ba9a0fda68@au1.ibm.com>
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
> If the AFU descriptor of an AFU directed AFU indicates that it supports
> 0 maximum processes, we will accept that value and attempt to use it.
> The SPA will still be allocated (with 2 pages due to another minor bug
> and room for 958 processes), and when a context is allocated we will
> pass the value of 0 to idr_alloc as the maximum. However, idr_alloc will
> treat that as meaning no maximum and will allocate a context number and
> we return a valid context.
>
> Conceivably, this could lead to a buffer overflow of the SPA if more
> than 958 contexts were allocated, however this is mitigated by the fact
> that there are no known AFUs in the wild with a bogus AFU descriptor
> like this, and that only the root user is allowed to flash an AFU image
> to a card.
>
> Add a check when validating the AFU descriptor to reject any with 0
> maximum processes.
>
> We do still allow a dedicated process only AFU to indicate that it
> supports 0 contexts even though that is forbidden in the architecture,
> as in that case we ignore the value and use 1 instead. This is just on
> the off-chance that such a dedicated process AFU may exist (not that I
> am aware of any), since their developers are less likely to have cared
> about this value at all.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Looks good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
