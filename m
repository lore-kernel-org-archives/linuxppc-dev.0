Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <200610292310.k9TNAHXZ013852@post.webmailer.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
Date: Mon, 30 Oct 2006 16:25:32 -0600
To: Nicolas DET <nd@bplan-gmbh.de>
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 29, 2006, at 5:10 PM, Nicolas DET wrote:

> This patch add MPC52xx Interrupt controller for ARCH=powerpc.
>
> It includes the main code in arch/powerpc/sysdev/ ad well as an  
> header file in
> include/asm-powerpc.
>
> Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>

Can you see if you can figure out how to inline patches with your  
mailer, its really difficult to comment on issues w/an attachment.

+/* MBAR position */
+#define MPC52xx_MBAR		0xf0000000	/* Phys address */
+#define MPC52xx_MBAR_VIRT	0xf0000000	/* Virt address */
+#define MPC52xx_MBAR_SIZE	0x00010000
+
+#define MPC52xx_PA(x)		((phys_addr_t)(MPC52xx_MBAR + (x)))
+#define MPC52xx_VA(x)		((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))

This should be handled dynamically (pulled from the device tree), I  
doubt MBAR will be at the same location for all boards.

* can you split out the interrupt controller header info into a  
mpc52xx_pic.h [mpc52xx_intr, MPC52xx_IRQ_...]
* lets drop all the other struct defn in mpc52xx.h.  This is a hold  
over from arch/ppc and we really should only put defn that we  
actually need closer to the code that uses them (ie, drivers, etc.)

- kumar
