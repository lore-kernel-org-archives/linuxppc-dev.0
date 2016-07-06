Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl5xW0wl1zDr1B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 02:36:46 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66GXTN6115421
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:36:44 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 240nejf3pr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 12:36:44 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 17:36:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D52C22190063
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 17:36:08 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66GadBr19530222
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 16:36:39 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66GadI9031081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 10:36:39 -0600
Subject: Re: [PATCH 02/14] cxl: Add cxl_slot_is_supported API
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-3-git-send-email-imunsie@au.ibm.com>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 18:36:37 +0200
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-3-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577D3395.2080508@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/07/2016 15:22, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> This extends the check that the adapter is in a CAPI capable slot so
> that it may be called by external users in the kernel API. This will be
> used by the upcoming Mellanox CX4 support, which needs to know ahead of
> time if the card can be switched to cxl mode so that it can leave it in
> PCI mode if it is not.
>
> This API takes a parameter to check if CAPP DMA mode is supported, which
> it currently only allows on P8NVL systems, since that mode currently has
> issues accessing memory < 4GB on P8, and we cannot realistically avoid
> that.
>
> This API does not currently check if a CAPP unit is available (i.e. not
> already assigned to another PHB) on P8. Doing so would be racy since it
> is assigned on a first come first serve basis, and so long as CAPP DMA
> mode is not supported on P8 we don't need this, since the only
> anticipated user of this API requires CAPP DMA mode.

Is it me or that last sentence is more complicated than it should? :-) 
Anyway, I get it.

And the rest looks ok.

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
