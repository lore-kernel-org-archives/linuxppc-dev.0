Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRw6c2X3mzDqd0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 21:23:04 +1000 (AEST)
Message-ID: <1494933772.21847.48.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/mm: Rename find_linux_pte_or_hugepte
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 16 May 2017 21:22:52 +1000
In-Reply-To: <1494926782-25700-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494926782-25700-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Tue, 2017-05-16 at 14:56 +0530, Aneesh Kumar K.V wrote:
> +static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea,
> +                                   bool *is_thp, unsigned *hshift)
> +{
> +       VM_WARN((!arch_irqs_disabled() && !__hard_irqs_disabled()) ,
> +               "%s called with irq enabled\n", __func__);
> +       return __find_linux_pte(pgdir, ea, is_thp, hshift);
> +}
> +

When is arch_irqs_disabled() not sufficient ?

Cheers,
Ben.
