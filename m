Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 960D11A0015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 19:07:19 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 551DB14077C
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:07:19 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 21 May 2015 19:07:17 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ACA2E2CE8040
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:07:14 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L976UW10354830
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:07:14 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L96fuF024509
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:06:42 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 brking <brking@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 06/19] cxl: Add shutdown hook
In-reply-to: <1432034556-32400-7-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
 <1432034556-32400-7-git-send-email-mikey@neuling.org>
Date: Thu, 21 May 2015 19:06:17 +1000
Message-Id: <1432198934-sup-3581@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks like a good change to make sure the PSL & AFU is not still active
across a reboot :)

Wondering if this should be Cc: Stable - has there been any demonstrable
stability increase after a reboot with this?

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Excerpts from Michael Neuling's message of 2015-05-19 21:22:23 +1000:
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  drivers/misc/cxl/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index b80f867..a9c90d2 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1135,4 +1135,5 @@ struct pci_driver cxl_pci_driver = {
>      .id_table = cxl_pci_tbl,
>      .probe = cxl_probe,
>      .remove = cxl_remove,
> +    .shutdown = cxl_remove,
>  };
