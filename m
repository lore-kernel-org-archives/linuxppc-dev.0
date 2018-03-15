Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402P8w12VwzF196
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 09:56:31 +1100 (AEDT)
Message-ID: <1521154566.16434.171.camel@kernel.crashing.org>
Subject: Re: [RFC] powerpc/xive: Remove irq from queue when it is shutdown
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Frederic Barrat
 <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: andrew.donnellan@au1.ibm.com, vaibhav@linux.vnet.ibm.com
Date: Fri, 16 Mar 2018 09:56:06 +1100
In-Reply-To: <ba73a10a-320c-914e-5d7e-1ff212fdd6c5@kaod.org>
References: <20180314165808.26628-1-fbarrat@linux.vnet.ibm.com>
 <ba73a10a-320c-914e-5d7e-1ff212fdd6c5@kaod.org>
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

On Wed, 2018-03-14 at 18:47 +0100, Cédric Le Goater wrote:
> We could also loop on the ESB 'P' bit to wait for the irqs to be handled,
> using :
> 
>         xive_esb_read(irq, XIVE_ESB_GET)
> 
> which has no side effect. It looks simpler to me. Is that possible ? 

But you can race with something sending another one... I prefer the
guarantee that after final masking, we check the queue contents on
shutdown.

That will be solid vs. other type of interrupts as well.

Cheers,
Ben.
