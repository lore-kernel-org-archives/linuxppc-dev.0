Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKzSg1kl5zDw08
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 00:32:35 +1100 (AEDT)
Date: Fri, 18 Nov 2016 14:29:45 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
cc: monstr@monstr.eu, jason@lakedaemon.net, marc.zyngier@arm.com,
 linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [Patch v7 6/7] irqchip: xilinx: Try to fall back if xlnx,
 kind-of-intr not provided
In-Reply-To: <20161114121351.10924-7-Zubair.Kakakhel@imgtec.com>
Message-ID: <alpine.DEB.2.20.1611181426430.3615@nanos>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
 <20161114121351.10924-7-Zubair.Kakakhel@imgtec.com>
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

On Mon, 14 Nov 2016, Zubair Lutfullah Kakakhel wrote:

> The powerpc dts file does not have the xlnx,kind-of-intr property.
> Instead of erroring out, give a warning instead. And attempt to
> continue to probe the interrupt controller while assuming
> kind-of-intr is 0x0 as a fall back.

This is broken, really. On multiplatform kernels this will try to probe the
chip no matter what.
 
Powerpc already has:

static const struct of_device_id xilinx_intc_match[] __initconst = {
       { .compatible = "xlnx,opb-intc-1.00.c", },
       { .compatible = "xlnx,xps-intc-1.00.a", },
       {}
};

Unless I'm missing something important, then adding those compatible
strings to the driver will just keep stuff working as expected instead of
adding unsafe and broken heuristics.

Thanks,

	tglx
