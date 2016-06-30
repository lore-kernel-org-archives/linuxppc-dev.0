Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgGtC05BNzDqm9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 21:05:38 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UAwiDb112801
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:05:36 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uuhuw1mc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:05:35 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 12:05:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 21AFC1B08077
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:06:47 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UB5V5858458190
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:05:31 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UB5UL4012772
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:05:31 -0400
Subject: Re: [PATCH 2/2] cxl: Workaround XSL bug that does not clear the RA
 bit after a reset
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
 <1467226286-28547-2-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 30 Jun 2016 13:05:30 +0200
MIME-Version: 1.0
In-Reply-To: <1467226286-28547-2-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5774FCFA.4030009@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/06/2016 20:51, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> An issue was noted in our debug logs where the XSL would leave the RA
> bit asserted after an AFU reset operation, which would effectively
> prevent further AFU reset operations from working.
>
> Workaround the issue by clearing the RA bit with an MMIO write if it is
> still asserted after any AFU control operation.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>


OK, should be safe and valid even on non-xsl hardware.

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


   Fred
