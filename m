Return-Path: <prvs=06256b6fe5=mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B9mL711PzF2Cp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:50:42 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2SElAZY020756
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 10:50:39 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h0cgaa2kx-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 10:50:38 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 28 Mar 2018 08:50:36 -0600
Date: Wed, 28 Mar 2018 09:50:32 -0500
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 40/41] cxlflash: Remove commmands from pending list on
 timeout
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1522082134-58938-1-git-send-email-ukrishn@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522082134-58938-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <20180328145032.GB61145@p8tul1-build.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 26, 2018 at 11:35:34AM -0500, Uma Krishnan wrote:
> The following Oops can occur if an internal command sent to the AFU does
> not complete within the timeout:
> 
> [c000000ff101b810] c008000016020d94 term_mc+0xfc/0x1b0 [cxlflash]
> [c000000ff101b8a0] c008000016020fb0 term_afu+0x168/0x280 [cxlflash]
> [c000000ff101b930] c0080000160232ec cxlflash_pci_error_detected+0x184/0x230
>                                        [cxlflash]
> [c000000ff101b9e0] c00800000d95d468 cxl_vphb_error_detected+0x90/0x150[cxl]
> [c000000ff101ba20] c00800000d95f27c cxl_pci_error_detected+0xa4/0x240 [cxl]
> [c000000ff101bac0] c00000000003eaf8 eeh_report_error+0xd8/0x1b0
> [c000000ff101bb20] c00000000003d0b8 eeh_pe_dev_traverse+0x98/0x170
> [c000000ff101bbb0] c00000000003f438 eeh_handle_normal_event+0x198/0x580
> [c000000ff101bc60] c00000000003fba4 eeh_handle_event+0x2a4/0x338
> [c000000ff101bd10] c0000000000400b8 eeh_event_handler+0x1f8/0x200
> [c000000ff101bdc0] c00000000013da48 kthread+0x1a8/0x1b0
> [c000000ff101be30] c00000000000b528 ret_from_kernel_thread+0x5c/0xb4
> 
> When an internal command times out, the command buffer is freed while it
> is still in the pending commands list of the context. This corrupts the
> list and when the context is cleaned up, a crash is encountered.
> 
> To resolve this issue, when an AFU command or TMF command times out, the
> command should be deleted from the hardware queue pending command list
> before freeing the buffer.
> 
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
