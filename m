Return-Path: <prvs=06256b6fe5=mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B9cH0YSSzF24W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:43:39 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2SEfOND056999
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 10:43:37 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h0bpnmhwe-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 10:43:36 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 28 Mar 2018 08:43:35 -0600
Date: Wed, 28 Mar 2018 09:43:32 -0500
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 39/41] cxlflash: Synchronize reset and remove ops
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1522082127-58900-1-git-send-email-ukrishn@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522082127-58900-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <20180328144332.GA61145@p8tul1-build.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 26, 2018 at 11:35:27AM -0500, Uma Krishnan wrote:
> The following Oops can be encountered if a device removal or system
> shutdown is initiated while an EEH recovery is in process:
> 
> [c000000ff2f479c0] c008000015256f18 cxlflash_pci_slot_reset+0xa0/0x100
>                                       [cxlflash]
> [c000000ff2f47a30] c00800000dae22e0 cxl_pci_slot_reset+0x168/0x290 [cxl]
> [c000000ff2f47ae0] c00000000003ef1c eeh_report_reset+0xec/0x170
> [c000000ff2f47b20] c00000000003d0b8 eeh_pe_dev_traverse+0x98/0x170
> [c000000ff2f47bb0] c00000000003f80c eeh_handle_normal_event+0x56c/0x580
> [c000000ff2f47c60] c00000000003fba4 eeh_handle_event+0x2a4/0x338
> [c000000ff2f47d10] c0000000000400b8 eeh_event_handler+0x1f8/0x200
> [c000000ff2f47dc0] c00000000013da48 kthread+0x1a8/0x1b0
> [c000000ff2f47e30] c00000000000b528 ret_from_kernel_thread+0x5c/0xb4
> 
> The remove handler frees AFU memory while the EEH recovery is in progress,
> leading to a race condition. This can result in a crash if the recovery
> thread tries to access this memory.
> 
> To resolve this issue, the cxlflash remove handler will evaluate the
> device state and yield to any active reset or probing threads.
> 
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Looks good!

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
