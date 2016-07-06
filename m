Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl8TH3Bp4zDqxp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 04:30:59 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66ITBM4078130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:30:57 -0400
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xju9cd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 14:30:57 -0400
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 19:30:55 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6F4062190056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 19:30:17 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66IUmqf13762900
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:30:48 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66IUlPs023619
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:30:48 -0600
Subject: Re: [PATCH 07/14] cxl: Add support for using the kernel API with a
 real PHB
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-8-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 20:30:41 +0200
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-8-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577D4E51.4040108@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> @@ -1572,6 +1575,9 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>   		 */
>   		for (i = 0; i < adapter->slices; i++) {
>   			afu = adapter->afu[i];
> +			/* Only participate in EEH if we are on a virtual PHB */
> +			if (afu->phb == NULL)
> +				return PCI_ERS_RESULT_NONE;
>   			cxl_vphb_error_detected(afu, state);
>   		}


Sorry, I had my notes out of order, something is bugging me here. Don't 
we always define afu->phb, though for Mellanox (or if there's no config 
record in the general case), we don't have any devices attached to it?

Which raises the question of the handling of slot_reset and resume 
callbacks...


   Fred
