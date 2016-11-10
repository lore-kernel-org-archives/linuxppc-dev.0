Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFGPm1vynzDvmJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 08:28:44 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAALOgU0095064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 16:28:40 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26n031adyh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 16:28:40 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 11 Nov 2016 07:28:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CCAEC2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 08:28:34 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAALSYwP36700270
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 08:28:34 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAALSYt9003380
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 08:28:34 +1100
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 devicetree@vger.kernel.org
Cc: linux-pci@vger.kernel.org, robh+dt@kernel.org,
 linuxppc-dev@lists.ozlabs.org, frowand.list@gmail.com
Date: Fri, 11 Nov 2016 08:28:32 +1100
In-Reply-To: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1478813312.2592.0.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-09 at 12:05 -0200, Guilherme G. Piccoli wrote:
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 393fea8..1ad6882 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -275,7 +275,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>         of_node_put(ipar);
>         of_node_put(newpar);
>  
> -       return -EINVAL;
> +       /* Positive non-zero return means no Level-triggered Interrupts
> +        * capability was found.
> +        */
> +       return ENOENT;
>  }
>  EXPORT_SYMBOL_GPL(of_irq_parse_raw);

I'm not fan. I'd rather it's -ENOENT and the callers can check for that
specific code rather than playing with the sign.

Cheers,
Ben.
