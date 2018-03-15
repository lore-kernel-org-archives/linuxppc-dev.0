Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402PDM6MCMzF1K6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 09:59:31 +1100 (AEDT)
Message-ID: <1521154748.16434.173.camel@kernel.crashing.org>
Subject: Re: [RFC] powerpc/xive: Remove irq from queue when it is shutdown
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, clg@kaod.org
Cc: andrew.donnellan@au1.ibm.com, vaibhav@linux.vnet.ibm.com
Date: Fri, 16 Mar 2018 09:59:08 +1100
In-Reply-To: <20180314165808.26628-1-fbarrat@linux.vnet.ibm.com>
References: <20180314165808.26628-1-fbarrat@linux.vnet.ibm.com>
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

On Wed, 2018-03-14 at 17:58 +0100, Frederic Barrat wrote:
> +                       if (irq == hw_irq) {
> +                               cur &= 1 << 31;
> +                               cur |= XIVE_BAD_IRQ;
> +                               *(q->qpage + idx) = cpu_to_be32(cur);
> +                       }
> +
> +                       idx = (idx + 1) & q->msk;
> +                       if (idx == 0)
> +                               toggle ^= 1;
> +               } while (irq && (count < q->msk));

Safer to make the replacement an atomic with cmpxhg just in case you
found an old one trailing the queue that's just getting updated by HW.

Cheers,
Ben.
