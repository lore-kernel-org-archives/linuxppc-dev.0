Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTqFp5VytzDqSD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 21:49:34 +1100 (AEDT)
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 22 Mar 2016 10:49:28 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6C35B1B0806B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 10:49:57 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2MAnPSw61210628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 10:49:25 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2MAnOmf019277
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 04:49:25 -0600
Message-ID: <56F12344.60507@linux.vnet.ibm.com>
Date: Tue, 22 Mar 2016 11:49:40 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org, stewart@linux.vnet.ibm.com,
 mikey@neuling.org, imunsie@au1.ibm.com,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: Re: [PATCH] Added a 5ms wait after a msi-irq is masked
References: <1458643554-22766-1-git-send-email-felix@linux.vnet.ibm.com>
In-Reply-To: <1458643554-22766-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry, I've sent this to the wrong list.

Philippe

Philippe Bergheaud wrote:
> From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> 
> Adds a 5ms wait to phb3_msi_set_xive after the interrupt is masked so
> that the kernel delays cleanup until an irq if its in-flight is
> handled. The value 5ms is the worst case time needed by an irq to be
> presented to the host after its generated.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
> This patch requires the following patches:
> https://patchwork.ozlabs.org/patch/581764/
> https://patchwork.ozlabs.org/patch/581765/
> 
>  hw/phb3.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/phb3.c b/hw/phb3.c
> index fbdcb9e..e5d49b2 100644
> --- a/hw/phb3.c
> +++ b/hw/phb3.c
> @@ -1751,6 +1751,8 @@ static int64_t phb3_msi_set_xive(void *data,
>  			PHB_IVC_UPDATE_ENABLE_Q |
>  			PHB_IVC_UPDATE_ENABLE_GEN;
>  		out_be64(p->regs + PHB_IVC_UPDATE, ivc);
> +		/* wait for 5ms before signalling the interrupt is masked */
> +		time_wait_ms(5);
>  	}
>  
>  	return OPAL_SUCCESS;
