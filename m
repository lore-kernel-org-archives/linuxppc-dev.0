Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 09:31:27 +1100
Message-Id: <1162247487.25682.211.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-30 at 16:25 -0600, Kumar Gala wrote:
> On Oct 29, 2006, at 5:10 PM, Nicolas DET wrote:
> 
> > This patch add MPC52xx Interrupt controller for ARCH=powerpc.
> >
> > It includes the main code in arch/powerpc/sysdev/ ad well as an  
> > header file in
> > include/asm-powerpc.
> >
> > Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
> 
> Can you see if you can figure out how to inline patches with your  
> mailer, its really difficult to comment on issues w/an attachment.
> 
> +/* MBAR position */
> +#define MPC52xx_MBAR		0xf0000000	/* Phys address */
> +#define MPC52xx_MBAR_VIRT	0xf0000000	/* Virt address */
> +#define MPC52xx_MBAR_SIZE	0x00010000
> +
> +#define MPC52xx_PA(x)		((phys_addr_t)(MPC52xx_MBAR + (x)))
> +#define MPC52xx_VA(x)		((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
> 
> This should be handled dynamically (pulled from the device tree), I  
> doubt MBAR will be at the same location for all boards.

The physical address should indeed come from the DT. The virtual address
should be assigned dynamically by ioremap anyway. What are thse _PA/_VA
used for ?

> * can you split out the interrupt controller header info into a  
> mpc52xx_pic.h [mpc52xx_intr, MPC52xx_IRQ_...]

Good idea.

Ben
