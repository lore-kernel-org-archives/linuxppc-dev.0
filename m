Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl7Jn4RDKzDr1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 03:38:32 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66HTbgm046668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 13:38:30 -0400
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xkhgmx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 13:38:30 -0400
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 18:38:28 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id AF3DF2190046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 18:37:54 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66HcPaD6422818
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 17:38:25 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66HcPTs007388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 11:38:25 -0600
Subject: Re: [PATCH 06/14] powerpc/powernv: Add support for the cxl kernel api
 on the real phb
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-7-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 19:38:18 +0200
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-7-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577D420A.9060806@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> +	/* No special handling for cxl function: */
> +	if (PCI_FUNC(dev->devfn) == 0)
> +		return true;

I believe that is the first time we're getting a hint of the black magic 
which is going to occur when the card is switched to cxl mode and the 
appearance of a new pci function. I think a general comment explaining 
it is needed somewhere. In this patch or a later one. Also "peer model" 
is used several times in the commit messages, though it's not clear to 
the novice what it really means.

At this point of the review, I was a bit overwhelmed by all the new 
APIs, wondering how everything would end up working together. By the 
last patch, it's understandable, but a few extra comments would help.
For the vPHB model, pretty much all the relevant code is in one file, 
which helps grabbing the full picture. But here it's spread between the 
phb platform code and the cxl driver.

   Fred
