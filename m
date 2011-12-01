Return-Path: <michaele@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B72DFB6F67
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 17:59:56 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Thu, 1 Dec 2011 07:53:41 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB16xn4E4898868
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2011 17:59:49 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB16xn67015066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2011 17:59:49 +1100
Message-ID: <1322722788.5215.3.camel@concordia>
Subject: Re: [PATCH 10/10] powerpc/mpic: Add in-core support for cascaded MPICs
From: Michael Ellerman <michaele@au1.ibm.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Date: Thu, 01 Dec 2011 17:59:48 +1100
In-Reply-To: <1322593117-29938-11-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <1322593117-29938-11-git-send-email-Kyle.D.Moffett@boeing.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Reply-To: michaele@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-29 at 13:58 -0500, Kyle Moffett wrote:
> diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
> index cd00ca8..a0f5d28 100644
> --- a/arch/powerpc/platforms/cell/setup.c
> +++ b/arch/powerpc/platforms/cell/setup.c
> @@ -215,15 +202,6 @@ static void __init mpic_init_IRQ(void)
>  		if (mpic == NULL)
>  			continue;
>  		mpic_init(mpic);
> -
> -		virq = irq_of_parse_and_map(dn, 0);
> -		if (virq == NO_IRQ)
> -			continue;
> -
> -		printk(KERN_INFO "%s : hooking up to IRQ %d\n",
> -		       dn->full_name, virq);
> -		irq_set_handler_data(virq, mpic);
> -		irq_set_chained_handler(virq, cell_mpic_cascade);
>  	}
>  }

This leaves virq unused, which breaks the build.

cheers

-- 
