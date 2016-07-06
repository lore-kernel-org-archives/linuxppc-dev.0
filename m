Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl8YV61rbzDqxp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 04:34:38 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66IY3Vf049940
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:34:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xkkg4w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 14:34:36 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 19:34:33 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4E9C51B08061
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 19:35:48 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66IYULo10223974
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:34:30 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66IYTWq010949
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:34:29 -0600
Subject: Re: [PATCH 09/14] cxl: Add preliminary workaround for CX4 interrupt
 limitation
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-10-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 20:34:28 +0200
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-10-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577D4F34.5050309@linux.vnet.ibm.com>
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
> The Mellanox CX4 has a hardware limitation where only 4 bits of the
> AFU interrupt number can be passed to the XSL when sending an interrupt,
> limiting it to only 15 interrupts per context (AFU interrupt number 0 is
> invalid).
>
> In order to overcome this, we will allocate additional contexts linked
> to the default context as extra address space for the extra interrupts -
> this will be implemented in the next patch.
>
> This patch adds the preliminary support to allow this, by way of adding
> a linked list in the context structure that we use to keep track of the
> contexts dedicated to interrupts, and an API to simultaneously iterate
> over the related context structures, AFU interrupt numbers and hardware
> interrupt numbers. The point of using a single API to iterate these is
> to hide some of the details of the iteration from external code, and to
> reduce the number of APIs that need to be exported via base.c to allow
> built in code to call.
>

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Just one typo below


> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> index fc07ed4..ed81a17 100644
> --- a/include/misc/cxl.h
> +++ b/include/misc/cxl.h
> @@ -178,6 +178,15 @@ int cxl_set_max_irqs_per_process(struct pci_dev *dev, int irqs);
>   int cxl_get_max_irqs_per_process(struct pci_dev *dev);
>
>   /*
> + * Use to simultaneously iterate over hardware interrupt numbers, contexts and
> + * afu interrupt numbers allocated for the device via pci_enable_msix_range and
> + * is a useful convinience function when working with hardware that has

convenience
