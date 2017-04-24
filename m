Return-Path: <srs0=pwla=4a=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBGdJ6SCjzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 16:28:52 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wBGdJ5ql0z8t5F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 16:28:52 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wBGdH44Fkz9sD5
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2017 16:28:51 +1000 (AEST)
Message-ID: <1493015287.25766.213.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 05/11] VAS: Define helpers for access MMIO regions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 24 Apr 2017 16:28:07 +1000
In-Reply-To: <1490937224-29149-6-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490937224-29149-6-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-30 at 22:13 -0700, Sukadev Bhattiprolu wrote:
> +static void *map_mmio_region(char *name, uint64_t start, int len)
> +{
> +       void *map;
> +
> +       if (!request_mem_region(start, len, name)) {
> +               pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
> +                               __func__, start, len);
> +               return NULL;
> +       }
> +
> +       map = __ioremap(start, len, pgprot_val(pgprot_cached(__pgprot(0))));
> +       if (!map) {
> +               pr_devel("%s(): ioremap(0x%llx, %d) failed\n", __func__, start,
> +                               len);
> +               return NULL;
> +       }
> +
> +       return map;
> +}

That's very wrong. I assume this never worked right ?

MMIO regions must be mapped non-cachable. Only the paste region
requires being mapped cachable. Ask Aneesh for a cleaner way of
doing it too while at it.

> +/*
> + * Unmap the MMIO regions for a window.
> + */
> +static void unmap_wc_paste_kaddr(struct vas_window *window)
> +{
> +       int len;

Don't use "wc"... that usually means "write combine".

Cheers,
Ben.
