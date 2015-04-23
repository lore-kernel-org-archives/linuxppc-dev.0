Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA01A1A0C32
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 21:24:10 +1000 (AEST)
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BB4EC14011D
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2015 21:24:09 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 23 Apr 2015 07:24:07 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 8D20E6E8040
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2015 07:15:53 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3NBO4IT59048084
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2015 11:24:04 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3NBO39U017906
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2015 07:24:04 -0400
Message-ID: <5538D651.60702@linux.vnet.ibm.com>
Date: Thu, 23 Apr 2015 16:54:01 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/powernv: Add definition of OPAL_MSG_OCC
 message type
References: <1429722265-2953-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1429722265-2953-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shilpa,

On 04/22/2015 10:34 PM, Shilpasri G Bhat wrote:
> Add OPAL_MSG_OCC message definition to opal_message_type to notify OCC

s/notify OCC events/receive OCC events ?

> events like reset, load and throttled. Host performance can be
> affected when OCC is reset or OCC throttles the max Pstate.
> We can register to opal_message_notifier to receive OPAL_MSG_OCC type
> of message.

You may want to mention that we register to receive this message so as
to report to userspace about the same. The purpose of this patchset is
reporting so as to keep the user informed about the reason for a
performance drop in workloads.

> 
> The reset and load OCC events are notified to kernel when FSP sends
> OCC_RESET and OCC_LOAD commands.  Both reset and load messages are
> sent to kernel on successful completion of reset and load operation
> respectively.
> 
> The throttle OCC event indicates that the Pmax of the chip is reduced.
> The chip_id and throttle reason for reducing Pmax is also queued along
> with the message.
> 
> Additional opal message type OPAL_MSG_PRD is added to maintain
> compatibility between opal and kernel definition of opal_message_type.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/opal-api.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 0321a90..50053b7 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -352,6 +352,14 @@ enum opal_msg_type {
>  	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
>  	OPAL_MSG_HMI_EVT,
>  	OPAL_MSG_DPO,
> +	OPAL_MSG_PRD,
> +	OPAL_MSG_OCC,                   /*
> +					 * params[0] = 0 reset,
> +					 *             1 load,
> +					 *             2 throttle
> +					 * params[1] = chip_id
> +					 * params[2] = throttle_status
> +					 */
>  	OPAL_MSG_TYPE_MAX,
>  };

Besides the above nit, the patch looks good.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>  
> 
