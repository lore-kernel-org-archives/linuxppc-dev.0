Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B201ADDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 04:25:12 +1000 (EST)
Date: Fri, 13 Jul 2007 13:24:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: questions about mpc82xx_ads and porting to other, similar,
	platform
Message-ID: <20070713182452.GA1480@ld0162-tx32.am.freescale.net>
References: <op.tveavpvdnhx3hy@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.tveavpvdnhx3hy@phoenix>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 13, 2007 at 11:51:15AM +0300, Alexandros Kostopoulos wrote:
> I am trying to port kernel 2.6.22.1 to my own platform, which incorporates  
> an mpc8275 chip. I'm using platform code for mpc82xx_ads as a template (is  
> this right in the first place?). I have a couple of questions:

I suggest waiting until I can get my 8xx/82xx patchset out (which should
happen early next week...  it would have been earlier if I hadn't gotten
distracted trying to get PCI to work right).  It addresses the things you
point out.

> 1. mpc82xx_ads.c uses init_scc_ioports function to initialize the scc
> uarts. However, this function is only used by the code in
> arch/powerpc/sysdev/fsl_soc.c, and spefically in fs_enet_of_init(),
> which is used to initialize the ethernet driver and not the cpm_uart
> driver. On the other hand, cpm_uart_of_init() function seems to be the
> one that initializes the uarts in cpm, and actually makes use of the
> device-id, model, rx-clock and tx-clock properties of the scc nodes in
> OF tree. So, AFAICT, init_scc_ioports should not be there, since it
> won't be actually called at all (although I have not actually tested
> this - I haven't yet managed to boot the kernel). Instead,
> cpm_uart_of_init should take care of everything, except for the pport
> initialization, which is done in u-boot anyway (at least in my case).
> Any thoughts on this?

All such port configuration callbacks are removed in my patchset; the
bootloader and/or platform code is responsible for setting it up.

> 2. I have also some questions regarding the device tree. Why are there two  
> nodes regarding the interrupt controller in there? 

There are two interrupt controllers on the mpc8272ads: one for PCI, and
another for everything else.

> and in the top level node, what does this property means: reg =
> <f8200000 f8200004>; 

It means the device tree is buggy.  It should say <f8200000 8>.

> Finally, in the memory node, the reg property defines a second mem
> region, (f4500000 f4500020). What is this? 

More device tree brokenness.  It's the board control and status register
block, which has nothing to do with memory.

> maybe a special memory mapped peripheral of this board? If I have a
> board with many mem configurations (e.g. it uses a DIMM SDRAM what can
> be changed), what value should I place in the mem node? I have to
> change dts every time I insert a new DIMM?

No, u-boot or the bootwrapper should fill in the memory size.

-Scott
