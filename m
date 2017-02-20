Return-Path: <tglx@linutronix.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRyMp0XjBzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 09:04:22 +1100 (AEDT)
Date: Mon, 20 Feb 2017 14:04:12 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
cc: Michael Ellerman <mpe@ellerman.id.au>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [next-20170217] WARN @/arch/powerpc/include/asm/xics.h:124
 .icp_hv_eoi+0x40/0x140
In-Reply-To: <1487624024.23576.181.camel@au1.ibm.com>
Message-ID: <alpine.DEB.2.20.1702201402270.4208@nanos>
References: <E96217CD-2ADD-430D-86BD-27FF87752D7F@linux.vnet.ibm.com>
 <87zihhh9mp.fsf@concordia.ellerman.id.au>
 <15420F42-D2C6-4E29-8874-C47F4D61B098@linux.vnet.ibm.com>
 <87mvdhgmhj.fsf@concordia.ellerman.id.au>
 <1487624024.23576.181.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Feb 2017, Benjamin Herrenschmidt wrote:

> On Mon, 2017-02-20 at 21:55 +1100, Michael Ellerman wrote:
> > But when we're called for CONFIG_DEBUG_SHIRQ get_irq() is not called,
> > precisely because we're faking an interrupt.
> > 
> > I'm not sure if there's a good way to fix it :/
> 
> In the irq_replay path we have code to adjust the CPPR stack. We could
> do something similar.
> 
> HOWEVER. Looking at current upstream code I don't understand the error,
> the DEBUG_SHIRQ code is calling the driver's handler not the flow
> handler so it shouldn't be called handle_fasteoi_irq or am I missing
> something ?

I tried to invoke the normal handler path which also invokes the flow
handler, but that breaks on x86 as well for different reasons. I zapped
that commit and still need to find a way to do that debug thing proper. So
it's appearence in -next was only temporary.

Thanks,

	tglx
