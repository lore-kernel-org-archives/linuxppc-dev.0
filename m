Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGS2Y51MDzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 02:47:01 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6OGiLqk123110
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 12:46:59 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bwfsypa8y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 12:46:59 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 24 Jul 2017 10:46:58 -0600
Date: Mon, 24 Jul 2017 09:46:50 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org, benh@kernel.crashing.org, suka@us.ibm.com,
 ddstreet@ieee.org, npiggin@gmail.com, hbabu@us.ibm.com
Subject: Re: [PATCH V3 6/6] crypto/nx: Add P9 NX support for 842 compression
 engine
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1500699702.23205.8.camel@hbabu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500699702.23205.8.camel@hbabu-laptop>
Message-Id: <20170724164650.GA5628@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 21, 2017 at 10:01:42PM -0700, Haren Myneni wrote:
> 
> This patch adds P9 NX support for 842 compression engine. Virtual
> Accelerator Switchboard (VAS) is used to access 842 engine on P9.
> 
> For each NX engine per chip, setup receive window using
> vas_rx_win_open() which configures RxFIFo with FIFO address, lpid,
> pid and tid values. This unique (lpid, pid, tid) combination will
> be used to identify the target engine.
> 
> For crypto open request, open send window on the NX engine for
> the corresponding chip / cpu where the open request is executed.
> This send window will be closed upon crypto close request.
> 
> NX provides high and normal priority FIFOs. For compression /
> decompression requests, we use only hight priority FIFOs in kernel.
> 
> Each NX request will be communicated to VAS using copy/paste
> instructions with vas_copy_crb() / vas_paste_crb() functions.
> 

Reviewed-by: Ram Pai <linuxram@us.ibm.com>

> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> ---
>  drivers/crypto/nx/Kconfig          |   1 +
>  drivers/crypto/nx/nx-842-powernv.c | 375 ++++++++++++++++++++++++++++++++++++-
>  drivers/crypto/nx/nx-842.c         |   2 +-
>  3 files changed, 371 insertions(+), 7 deletions(-)
