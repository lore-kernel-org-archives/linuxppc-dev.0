Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 60F342C022C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 01:27:22 +1000 (EST)
Message-ID: <1366730708.12131.7.camel@pasglop>
Subject: Re: [PATCH 5/5] powerpc/powernv: TCE invalidation for PHB3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 01:25:08 +1000
In-Reply-To: <1366715034-24594-6-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366715034-24594-6-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-23 at 19:03 +0800, Gavin Shan wrote:
>          * of flags if that becomes the case
>          */
>         if (tbl->it_type & TCE_PCI_SWINV_CREATE)
> -               pnv_tce_invalidate(tbl, tces, tcep - 1);
> +               phb->dma_tce_invalidate(tbl, tces, tcep - 1);
>  
>         return 0;
>  }

TCE invalidate is very performance sensitive, we might be better off
doing the if (ioda_type == PNV_PHB_IODA1) ... else ... here (which
the CPU can generally predict) rather than a function pointer call
which can be more tricky.

Cheers,
Ben.
