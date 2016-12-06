Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tY3yQ6GqqzDvhJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 01:33:17 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB6EUiBQ082788
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 09:33:14 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 275xs69v2e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 09:33:14 -0500
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 14:33:13 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id AD089219006D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 14:32:20 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB6EX9BM32899324
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 14:33:09 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB6EX9Ig012850
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 07:33:09 -0700
Subject: Re: [PATCH] cxl: prevent read/write to AFU config space while AFU not
 configured
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20161205132242.13517-1-andrew.donnellan@au1.ibm.com>
Cc: ukrishn@linux.vnet.ibm.com, pradghos@in.ibm.com, imunsie@au1.ibm.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 6 Dec 2016 15:33:08 +0100
MIME-Version: 1.0
In-Reply-To: <20161205132242.13517-1-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <72b468c5-0187-07b9-79a4-2170f4d75b92@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/12/2016 à 14:22, Andrew Donnellan a écrit :
> During EEH recovery, we deconfigure all AFUs whilst leaving the
> corresponding vPHB and virtual PCI device in place.
>
> If something attempts to interact with the AFU's PCI config space (e.g.
> running lspci) after the AFU has been deconfigured and before it's
> reconfigured, cxl_pcie_{read,write}_config() will read invalid values from
> the deconfigured struct cxl_afu and proceed to Oops when they try to
> dereference pointers that have been set to NULL during deconfiguration.
>
> Add a rwsem to struct cxl_afu so we can prevent interaction with config
> space while the AFU is deconfigured.
>
> Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
> Suggested-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org # 4.4+
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


Thanks for adding the comments!

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
