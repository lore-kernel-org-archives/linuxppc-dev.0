Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B88E41A0DB0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 16:54:59 +1100 (AEDT)
In-Reply-To: <1420695752-924-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: Don't alloc IRQ map if necessary
Message-Id: <20150122055459.A5B3C140281@ozlabs.org>
Date: Thu, 22 Jan 2015 16:54:59 +1100 (AEDT)
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-01 at 05:42:32 UTC, Gavin Shan wrote:
> On PowerNV platform, the OPAL interrupts are exported by firmware
> through device-node property (/ibm,opal::opal-interrupts). Under
> some extreme circumstances (e.g. simulator), we don't have this
> property found from the device tree. For that case, we shouldn't
> allocate the interrupt map. Otherwise, slab complains allocating
> zero sized memory chunk.
 
That sounds fine. But the implementation is a bit messy.

Can you do a precursor patch which moves the logic into opal_irq_init(), that
way when you find no interrupts you can just return.

cheers
