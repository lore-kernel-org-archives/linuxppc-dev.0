Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57ACD1A0225
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 13:17:58 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Fri, 15 Aug 2014 08:47:55 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 46ECA1258018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 08:48:04 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7F3IGb859637768
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 08:48:17 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7F3HraS002895
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 08:47:54 +0530
Message-ID: <53ED7BD9.4060906@linux.vnet.ibm.com>
Date: Fri, 15 Aug 2014 11:17:45 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Avoid to set EEH_PE_ISOLATED for passed
 PE
References: <1407928458-8125-1-git-send-email-qiudayu@linux.vnet.ibm.com>
In-Reply-To: <1407928458-8125-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, all

After discussing with Gavin offline, it's inappropriate to drop ISOLATED 
state. Please ignore this patch.

Otherwise, somebody will merge that to mainline, which would be a problem.

Thanks,
Mike
On 08/13/2014 07:14 PM, Mike Qiu wrote:
> When PE passed to guest, and guest EEH occured with this PE,
> EEH_PE_ISOLATED maybe set in host.
>
> It is a big issue when the PE  is reused by host, host EEH
> will not work on this PE because it was set to EEH_PE_ISOLATED
> unexpectly.
>
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
> index c945bed..e88eaf6 100644
> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
> @@ -371,7 +371,8 @@ static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
>   	    !(result & EEH_STATE_UNAVAILABLE) &&
>   	    !(result & EEH_STATE_MMIO_ACTIVE) &&
>   	    !(result & EEH_STATE_DMA_ACTIVE)  &&
> -	    !(pe->state & EEH_PE_ISOLATED)) {
> +	    !(pe->state & EEH_PE_ISOLATED)    &&
> +	    !eeh_pe_passed(pe)) {
>   		if (phb->freeze_pe)
>   			phb->freeze_pe(phb, pe->addr);
>
