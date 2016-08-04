Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s51R74kGkzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 06:16:03 +1000 (AEST)
Date: Thu, 4 Aug 2016 13:16:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Alexandre
 Bounine <alexandre.bounine@idt.com>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] powerpc/fsl_rio: fix a missing error code
Message-Id: <20160804131600.bd2f72d2a0a6d8deec0af79b@linux-foundation.org>
In-Reply-To: <20160804053525.GM775@mwanda>
References: <20160804053525.GM775@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 4 Aug 2016 08:35:25 +0300 Dan Carpenter <dan.carpenter@oracle.com> wrote:

> We should set the error code here.  Otherwise static checkers complain.
> 

hm.

> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -491,6 +491,7 @@ int fsl_rio_setup(struct platform_device *dev)
>  	rmu_node = of_parse_phandle(dev->dev.of_node, "fsl,srio-rmu-handle", 0);
>  	if (!rmu_node) {
>  		dev_err(&dev->dev, "No valid fsl,srio-rmu-handle property\n");
> +		rc = -ENOENT;
>  		goto err_rmu;
>  	}
>  	rc = of_address_to_resource(rmu_node, 0, &rmu_regs);

afaict the function will return 0 in this case, which is a flat out
bug.  But why do static checkers complain?  The code will return a
suitably initialized value?

IOW, please always quote the checker/compiler output when fixing a bug!
