Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWBLq3VD0zDsPX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 08:14:11 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u89MDW2v096671
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2016 18:14:09 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25c3egcehh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Sep 2016 18:14:09 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 9 Sep 2016 16:14:08 -0600
Subject: Re: [PATCH 4/6] cxlflash: Improve EEH recovery time
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
References: <1472848612-64888-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1472848803-65143-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Date: Fri, 9 Sep 2016 17:14:09 -0500
MIME-Version: 1.0
In-Reply-To: <1472848803-65143-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9e9da53c-80f9-bd11-f44f-26f9fc7c13ba@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/2/2016 3:40 PM, Uma Krishnan wrote:
> From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
>
> When an EEH occurs during device initialization, the port timeout
> logic can cause excessive delays as MMIO reads will fail. Depending
> on where they are experienced, these delays can lead to a prolonged
> reset, causing an unnecessary triggering of other timeout logic in
> the SCSI stack or user applications.
>
> To expedite recovery, the port timeout logic is updated to decay the
> timeout at a much faster rate when in the presence of a likely EEH
> frozen event.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Acked-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
