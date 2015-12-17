Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02F871A00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 09:30:16 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 15:30:14 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DE2D419D804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 15:18:15 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHMUBEN14942284
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 15:30:11 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHMUAEt005799
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 15:30:11 -0700
Subject: Re: [PATCH 5/6] cxlflash: Resolve oops in wait_port_offline
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
References: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1449788074-23208-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-ID: <5673377F.5060304@linux.vnet.ibm.com>
Date: Thu, 17 Dec 2015 16:30:23 -0600
MIME-Version: 1.0
In-Reply-To: <1449788074-23208-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/10/2015 4:54 PM, Uma Krishnan wrote:
> From: Manoj Kumar <manoj@linux.vnet.ibm.com>
>
> If an async error interrupt is generated, and the error requires the FC
> link to be reset, it cannot be performed in the interrupt context. So
> a work element is scheduled to complete the link reset in a process
> context. If either an EEH event or an escalation occurs in between
> when the interrupt is generated and the scheduled work is started, the
> MMIO space may no longer be available. This will cause an oops in the
> worker thread.
>
> [  606.806583] NIP kthread_data+0x28/0x40
> [  606.806633] LR wq_worker_sleeping+0x30/0x100
> [  606.806694] Call Trace:
> [  606.806721] 0x50 (unreliable)
> [  606.806796] wq_worker_sleeping+0x30/0x100
> [  606.806884] __schedule+0x69c/0x8a0
> [  606.806959] schedule+0x44/0xc0
> [  606.807034] do_exit+0x770/0xb90
> [  606.807109] die+0x300/0x460
> [  606.807185] bad_page_fault+0xd8/0x150
> [  606.807259] handle_page_fault+0x2c/0x30
> [  606.807338] wait_port_offline.constprop.12+0x60/0x130 [cxlflash]
>
> To prevent the problem space area from being unmapped, when there is
> pending work, a mapcount (using the kref mechanism) is held.  The mapcount
> is released only when the work is completed.  The last reference release
> is tied to the unmapping service.
>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> ---

Reviewed-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
