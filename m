Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0144.outbound.protection.outlook.com [207.46.100.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A142F1A0C81
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 04:58:44 +1100 (AEDT)
Message-ID: <1421258312.4961.133.camel@freescale.com>
Subject: Re: [PATCH] powerpc/mpic: Add DT option to skip readback after EOI
From: Scott Wood <scottwood@freescale.com>
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Date: Wed, 14 Jan 2015 11:58:32 -0600
In-Reply-To: <1421236622-29366-1-git-send-email-bogdan.purcareata@freescale.com>
References: <1421236622-29366-1-git-send-email-bogdan.purcareata@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-14 at 11:57 +0000, Bogdan Purcareata wrote:
> The readback is necessary in order to handle PCI posted
> writes,

That is unclear.

>  or when the MPIC is handling interrupts in a loop
> (ppc_md.get_irq).

I'm questioning this one as well -- if reading WHOAMI is sufficient to
sync with the EOI, why wouldn't reading INTACK work as well?

>  Newer MPIC versions don't require this readback. Leave the option
> configurable using a device tree entry.
> 
> This saves a MMIO trap per interrupt.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>

You should note changes (e.g. with a [] note between signoffs) if it
differs from the original...

-Scott
