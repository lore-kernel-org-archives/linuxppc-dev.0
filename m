Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNXp25WWhzDt1n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 04:41:30 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMHdSeH023042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 12:41:28 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vpp74q27-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 12:41:28 -0500
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 17:41:26 -0000
Subject: Re: [PATCH 2/2] cxl: Set VPD timeout to avoid access failures
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1479762606-51632-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 22 Nov 2016 18:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <1479762606-51632-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <05398bfe-5bd4-116b-a9d7-b974d4cc032a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 21/11/2016 à 22:10, Matthew R. Ochs a écrit :
> Some IBM CXL devices can take up to ~120ms to complete a VPD access
> transaction when under heavy load. With an existing default VPD timeout
> of 50ms, reads/writes can fail despite there not being an issue with the
> underlying hardware.
>
> To avoid these false failures, increase the VPD wait timeout for certain
> CXL devices to a value that allows appropriate VPD access delay when faced
> with a worst-case scenario.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---

If the new pci API gets in, then I'm ok with the cxl change, at least 
for now. For longer term, we should consider opening up the cxl kernel 
API to give access to the new pci API so that it can be tuned by the AFU 
driver directly, since it would know better than cxl what the proper vpd 
access timeout should be.

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred
