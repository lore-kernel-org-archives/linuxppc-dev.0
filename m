Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tMr3g3PLJzDqMx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 01:05:50 +1100 (AEDT)
Subject: Re: [Patch v7 6/7] irqchip: xilinx: Try to fall back if
 xlnx,kind-of-intr not provided
To: Thomas Gleixner <tglx@linutronix.de>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
 <20161114121351.10924-7-Zubair.Kakakhel@imgtec.com>
 <alpine.DEB.2.20.1611181426430.3615@nanos>
CC: <monstr@monstr.eu>, <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
 <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <7f07be12-fb2e-e8ad-e0e6-52c58542470a@imgtec.com>
Date: Mon, 21 Nov 2016 14:05:46 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611181426430.3615@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 11/18/2016 01:29 PM, Thomas Gleixner wrote:
> On Mon, 14 Nov 2016, Zubair Lutfullah Kakakhel wrote:
>
>> The powerpc dts file does not have the xlnx,kind-of-intr property.
>> Instead of erroring out, give a warning instead. And attempt to
>> continue to probe the interrupt controller while assuming
>> kind-of-intr is 0x0 as a fall back.
>
> This is broken, really. On multiplatform kernels this will try to probe the
> chip no matter what.

I'm not sure I understand why this driver will probe on multi-platform kernels
if the compatible string isn't in the DT?

>
> Powerpc already has:
>
> static const struct of_device_id xilinx_intc_match[] __initconst = {
>        { .compatible = "xlnx,opb-intc-1.00.c", },
>        { .compatible = "xlnx,xps-intc-1.00.a", },
>        {}
> };
>
> Unless I'm missing something important, then adding those compatible
> strings to the driver will just keep stuff working as expected instead of
> adding unsafe and broken heuristics.
>

The last two lines of the driver already specify the compatible strings.

"
IRQCHIP_DECLARE(xilinx_intc_xps, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
IRQCHIP_DECLARE(xilinx_intc_opb, "xlnx,opb-intc-1.00.c", xilinx_intc_of_init);
"

I'll elaborate on the commit message.

The DT node in arch/powerpc for this driver is

intc_0: interrupt-controller@81800000 {
			#interrupt-cells = <0x2>;
			compatible = "xlnx,xps-intc-1.00.a";
			interrupt-controller ;
			reg = < 0x81800000 0x10000 >;
			xlnx,num-intr-inputs = <0xc>;
		} ;

The DT node in arch/microblaze for this driver is

intc_0: interrupt-controller@81800000 {
			#interrupt-cells = <0x2>;
			compatible = "xlnx,xps-intc-1.00.a";
			interrupt-controller ;
			reg = < 0x81800000 0x10000 >;
			xlnx,kind-of-intr = <0x100>;	//<Missing from ppc>!
			xlnx,num-intr-inputs = <0x9>;
		} ;

The PPC driver assumes the kind-of-intr value be 0x0 and doesn't specify it in DT.
This patch makes that a fall back case. Instead of completely error-ing out.

Regards,
ZubairLK

> Thanks,
>
> 	tglx
>
>
