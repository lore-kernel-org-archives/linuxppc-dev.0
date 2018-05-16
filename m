Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mJsd6gylzF15H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 01:54:45 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4GFsPVY069569
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 11:54:42 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j0pny3anm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 11:54:41 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 May 2018 11:54:40 -0400
Date: Wed, 16 May 2018 10:54:35 -0500
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/7] cxlflash: Acquire semaphore before invoking ioctl
 services
References: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1526065522-38933-1-git-send-email-ukrishn@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526065522-38933-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <20180516155435.GC8754@p8tul1-build.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 11, 2018 at 02:05:22PM -0500, Uma Krishnan wrote:
> When a superpipe process that makes use of virtual LUNs is terminated or
> killed abruptly, there is a possibility that the cxlflash driver could
> hang and deprive other operations on the adapter.
> 
> The release fop registered to be invoked on a context close, detaches
> every LUN associated with the context. The underlying service to detach
> the LUN assumes it has been called with the read semaphore held, and
> releases the semaphore before any operation that could be time consuming.
> 
> When invoked without holding the read semaphore, an opportunity is created
> for the semaphore's count to become negative when it is temporarily
> released during one of these potential lengthy operations. This negative
> count results in subsequent acquisition attempts taking forever, leading
> to the hang.
> 
> To support the current design point of holding the semaphore on the
> ioctl() paths, the release fop should acquire it before invoking any
> ioctl services.
> 
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
