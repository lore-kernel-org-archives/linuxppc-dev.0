Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMtPF5FXPzDvfs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 02:51:13 +1100 (AEDT)
Date: Mon, 21 Nov 2016 16:48:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
cc: monstr@monstr.eu, jason@lakedaemon.net, marc.zyngier@arm.com,
 linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [Patch v7 6/7] irqchip: xilinx: Try to fall back if xlnx,
 kind-of-intr not provided
In-Reply-To: <7f07be12-fb2e-e8ad-e0e6-52c58542470a@imgtec.com>
Message-ID: <alpine.DEB.2.20.1611211647260.15760@nanos>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
 <20161114121351.10924-7-Zubair.Kakakhel@imgtec.com>
 <alpine.DEB.2.20.1611181426430.3615@nanos>
 <7f07be12-fb2e-e8ad-e0e6-52c58542470a@imgtec.com>
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

On Mon, 21 Nov 2016, Zubair Lutfullah Kakakhel wrote:
> On 11/18/2016 01:29 PM, Thomas Gleixner wrote:
> I'll elaborate on the commit message.
> 
> The DT node in arch/powerpc for this driver is
> 
> intc_0: interrupt-controller@81800000 {
> 			#interrupt-cells = <0x2>;
> 			compatible = "xlnx,xps-intc-1.00.a";
> 			interrupt-controller ;
> 			reg = < 0x81800000 0x10000 >;
> 			xlnx,num-intr-inputs = <0xc>;
> 		} ;
> 
> The DT node in arch/microblaze for this driver is
> 
> intc_0: interrupt-controller@81800000 {
> 			#interrupt-cells = <0x2>;
> 			compatible = "xlnx,xps-intc-1.00.a";
> 			interrupt-controller ;
> 			reg = < 0x81800000 0x10000 >;
> 			xlnx,kind-of-intr = <0x100>;	//<Missing from ppc>!
> 			xlnx,num-intr-inputs = <0x9>;
> 		} ;
> 
> The PPC driver assumes the kind-of-intr value be 0x0 and doesn't specify it in
> DT.
> This patch makes that a fall back case. Instead of completely error-ing out.

Ok. makes sense. I misread the changelog/patch.

Thanks,

	tglx
