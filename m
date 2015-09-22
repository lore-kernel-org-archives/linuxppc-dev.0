Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 457EA1A01C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:22:38 +1000 (AEST)
Date: Mon, 21 Sep 2015 21:22:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 09/31] powerpc/mm: Don't use pte_val as lvalue
Message-ID: <20150922022223.GA12728@home.buserror.net>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1442817658-2588-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2015 at 12:10:36PM +0530, Aneesh Kumar K.V wrote:
> +static inline pte_t pte_mkwrite(pte_t pte)
> +{
> +	pte_basic_t ptev;
> +
> +	ptev = pte_val(pte) & ~_PAGE_RO;
> +	ptev |= _PAGE_RW;
> +	return __pte(pte);
> +}

s/__pte(pte)/__pte(ptev)/

...to fix an endless handle_mm_fault() loop.

CONFIG_STRICT_MM_TYPECHECKS would have caught this.

-Scott
