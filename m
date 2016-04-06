Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgHtZ6zstzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 06:50:46 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 7 Apr 2016 05:40:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7AFDA3578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 05:39:56 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u36JdmpA48103656
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 05:39:56 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u36JdNas017893
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 05:39:23 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>,
 paulus <paulus@samba.org>, mikey <mikey@neuling.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 gwshan <gwshan@linux.vnet.ibm.com>, bhelgaas <bhelgaas@google.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, Michael C Hollinger <mchollin@us.ibm.com>
Subject: Re: [PATCH v4] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
In-reply-to: <1458337746-20337-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1458337746-20337-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Date: Wed, 06 Apr 2016 14:38:55 -0500
Message-Id: <1459971134-sup-6269@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Guilherme G. Piccoli's message of 2016-03-18 16:49:06 -0500:
> +static int get_phb_number(struct device_node *dn)

...

> +    /* try fixed PHB numbering first, by checking archs and reading
> +     * the respective device-tree property. */
> +    if (machine_is(pseries)) {
> +        regs = of_get_property(dn, "reg", NULL);
> +        if (regs)
> +            return (int)(be32_to_cpu(regs[1]) & 0xFFFF);
> +    } else if (machine_is(powernv)) {
> +        prop64 = of_get_property(dn, "ibm,opal-phbid", NULL);
> +        if (prop64)
> +            return (int)(be64_to_cpup(prop64) & 0xFFFF);
> +    }

I think these cases should still set the bit in phb_bitmap, otherwise a
virtual PHB (e.g. as used in cxl/cxlflash) will be assigned PHB 0, and
since that is already taken it will fail - we're already seeing a
failure in Ubuntu Xenial since Canonical picked this patch up already
(though have not confirmed that this is definitely the cause yet).

There might also be some interesting races to think about here if a
virtual PHB grabs a PHB number before the real one gets a chance.

> +
> +    /* if not pSeries nor PowerNV, fallback to dynamic PHB numbering */
> +    phb_id = find_first_zero_bit(phb_bitmap, MAX_PHBS);
> +    BUG_ON(phb_id >= MAX_PHBS); /* reached maximum number of PHBs */
> +    set_bit(phb_id, phb_bitmap);

-Ian
