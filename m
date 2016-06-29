Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfnbp562pzDqvv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 02:06:30 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TFwrXC040373
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 12:06:28 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23uvaekrax-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 12:06:27 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 17:06:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 463A217D805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:07:43 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TG6MmS21823780
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:06:22 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TG6Mi8023123
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 10:06:22 -0600
Subject: Re: [PATCH 1/2] cxl: Fix allowing bogus AFU descriptors with 0
 maximum processes
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 29 Jun 2016 18:06:21 +0200
MIME-Version: 1.0
In-Reply-To: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5773F1FD.8060901@linux.vnet.ibm.com>
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


Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
