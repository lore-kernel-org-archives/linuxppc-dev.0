Return-Path: <prvs=06256b6fe5=mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BB2k6RgTzF2Js
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:03:10 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2SF1OcL053020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 11:03:07 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h0c96uhjh-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 11:03:07 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 28 Mar 2018 09:03:06 -0600
Date: Wed, 28 Mar 2018 10:03:02 -0500
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 41/41] cxlflash: Handle spurious interrupts
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1522082142-58975-1-git-send-email-ukrishn@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522082142-58975-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <20180328150302.GC61145@p8tul1-build.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 26, 2018 at 11:35:42AM -0500, Uma Krishnan wrote:
> The following Oops can occur when there is heavy I/O traffic and the host
> is reset by a tool such as sg_reset.
> 
> [c000200fff3fbc90] c00800001690117c process_cmd_doneq+0x104/0x500
>                                        [cxlflash] (unreliable)
> [c000200fff3fbd80] c008000016901648 cxlflash_rrq_irq+0xd0/0x150 [cxlflash]
> [c000200fff3fbde0] c000000000193130 __handle_irq_event_percpu+0xa0/0x310
> [c000200fff3fbea0] c0000000001933d8 handle_irq_event_percpu+0x38/0x90
> [c000200fff3fbee0] c000000000193494 handle_irq_event+0x64/0xb0
> [c000200fff3fbf10] c000000000198ea0 handle_fasteoi_irq+0xc0/0x230
> [c000200fff3fbf40] c00000000019182c generic_handle_irq+0x4c/0x70
> [c000200fff3fbf60] c00000000001794c __do_irq+0x7c/0x1c0
> [c000200fff3fbf90] c00000000002a390 call_do_irq+0x14/0x24
> [c000200e5828fab0] c000000000017b2c do_IRQ+0x9c/0x130
> [c000200e5828fb00] c000000000009b04 h_virt_irq_common+0x114/0x120
> 
> When a context is reset, the pending commands are flushed and the AFU
> is notified. Before the AFU handles this request there could be command
> completion interrupts queued to PHB which are yet to be delivered to the
> context. In this scenario, a context could receive an interrupt for a
> command that has been flushed, leading to a possible crash when the memory
> for the flushed command is accessed.
> 
> To resolve this problem, a boolean will indicate if the hardware queue is
> ready to process interrupts or not. This can be evaluated in the interrupt
> handler before proessing an interrupt.
> 
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
