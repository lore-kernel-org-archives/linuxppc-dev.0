Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 41F012C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 07:33:13 +1100 (EST)
Message-ID: <1360701185.2035.10.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc: Make context bits depend on virtual addr
 size.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 13 Feb 2013 07:33:05 +1100
In-Reply-To: <1360693905-23503-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1360693905-23503-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360693905-23503-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-02-13 at 00:01 +0530, Aneesh Kumar K.V wrote:
> + * Be careful with this value. This determines the VSID_MODULUS_*  and that
> + * need to be co-prime with VSID_MULTIPLIER*
> + */
> +#if defined(CONFIG_POWER6_CPU) || defined(CONFIG_POWER7_CPU)
> +/*
> + * Even if cpu support 68 bits, we limit this to 66 because
> + * we support only 2^19 context.
> + */
> +#define MAX_VIRTUAL_ADDR_BITS 66
> +#else
> +/* power4,power 5 and cell is 65 */
> +#define MAX_VIRTUAL_ADDR_BITS 65
> +#endif
> +

A compile option ? Really ? Ugh...

Ben.
