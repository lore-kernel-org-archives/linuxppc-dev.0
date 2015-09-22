Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0101.outbound.protection.outlook.com [207.46.100.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CB501A0B0D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:23:56 +1000 (AEST)
Date: Mon, 21 Sep 2015 21:23:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 10/31] powerpc/mm: Don't use pmd_val, pud_val and pgd_val
 as lvalue
Message-ID: <20150922022341.GB12728@home.buserror.net>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1442817658-2588-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2015 at 12:10:37PM +0530, Aneesh Kumar K.V wrote:
>  /* PUD level exusts only on 4k pages */
>  #ifndef CONFIG_PPC_64K_PAGES
>  typedef struct { unsigned long pud; } pud_t;
> -#define pud_val(x)	((x).pud)
>  #define __pud(x)	((pud_t) { (x) })
> +static inline unsigned long pud_val(pud_t pud)
> +{
> +	return x.pud;
> +}
>  #endif /* !CONFIG_PPC_64K_PAGES */

Where does "x" come from in this inline function?

This breaks the build with CONFIG_MM_STRICT_TYPECHECKS.

-Scott
