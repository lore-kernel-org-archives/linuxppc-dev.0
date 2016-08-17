Return-Path: <manoj@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sF4yb4pHPzDr4c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 09:22:47 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7HNJ3g6090246
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 19:22:44 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24vmf0p51a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 19:22:43 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Wed, 17 Aug 2016 17:22:43 -0600
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH 1/6] cxlflash: Avoid mutex when destroying context
References: <1470785888-9112-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1470785958-9152-1-git-send-email-mrochs@linux.vnet.ibm.com>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Date: Wed, 17 Aug 2016 18:22:38 -0500
MIME-Version: 1.0
In-Reply-To: <1470785958-9152-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <423f2766-2a70-9794-77bf-fbd14b66d7c7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>

On 8/9/2016 6:39 PM, Matthew R. Ochs wrote:
> Context information structures are protected by a mutex that is held
> when accessing/manipulating the context. When the code that manages
> these structures was authored, a decision was made to include taking
> the mutex as part of the allocation/initialization sequence and also
> handle the scenario where the mutex was already held when freeing the
> context.
>
> While not a problem outright, this design decision has been deemed as
> too flexible and the code should be made more rigid to avoid future bugs.
> In addition, further review of the code yields that the existing mutex
> manipulations in both of these context management paths are superfluous.
>
> This commit removes the obtaining of the context mutex in the context
> initialization routine and assumes the mutex is not held in the context
> free path.
>
> Inspired-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
