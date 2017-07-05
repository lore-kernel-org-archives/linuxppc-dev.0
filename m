Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2X4q0gFJzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 17:07:38 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v6573u6t023028
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 03:07:36 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bg6j7hd0f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 03:07:36 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 03:07:34 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>, skiboot@lists.ozlabs.org
Cc: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/powernv: report error messages from opal
In-Reply-To: <1482299579-21599-1-git-send-email-oohall@gmail.com>
References: <1482298544-8418-1-git-send-email-oohall@gmail.com>
 <1482299579-21599-1-git-send-email-oohall@gmail.com>
Date: Wed, 05 Jul 2017 17:07:24 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87van7pdjn.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:
> Recent versions of skiboot will raise an OPAL event (read: interrupt)
> when firmware writes an error message to its internal console. In
> conjunction they provide an OPAL call that the kernel can use to extract
> these messages from the OPAL log to allow them to be written into the
> kernel's log buffer where someone will (hopefully) look at them.
>
> For the companion skiboot patches see:
>
> 	https://lists.ozlabs.org/pipermail/skiboot/2016-December/005861.html
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/include/asm/opal-api.h            |  5 +++-
>  arch/powerpc/include/asm/opal.h                |  1 +
>  arch/powerpc/platforms/powernv/opal-msglog.c   | 41 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
>  4 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 0e2e57bcab50..cb9c0e6afb33 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -167,7 +167,8 @@
>  #define OPAL_INT_EOI				124
>  #define OPAL_INT_SET_MFRR			125
>  #define OPAL_PCI_TCE_KILL			126
> -#define OPAL_LAST				126
> +#define OPAL_SCRAPE_LOG				128

(another thought, along with the skiboot thoughts), I don't like the
SCRAPE_LOG name so much, as it's more of a "hey linux, here's some log
messages from firmware, possibly before you were
involved"... OPAL_FETCH_LOG ?

-- 
Stewart Smith
OPAL Architect, IBM.
