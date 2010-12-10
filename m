Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4122CB70A4
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Dec 2010 00:39:58 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oBADfHS0014375
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Dec 2010 08:41:17 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 458614DE803F
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Dec 2010 08:37:58 -0500 (EST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oBADdrRC192490
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Dec 2010 08:39:54 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oBADdrd6025003
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Dec 2010 06:39:53 -0700
Date: Fri, 10 Dec 2010 08:39:05 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: Re: [PATCH v5] ppc44x:PHY fixup for USB on canyonlands board
Message-ID: <20101210133905.GE1903@zod.rchland.ibm.com>
References: <201012090424.oB94O1DV006463@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201012090424.oB94O1DV006463@amcc.com>
Cc: linuxppc-dev@ozlabs.org, rsarmah@apm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 09, 2010 at 09:54:01AM +0530, Rupjyoti Sarmah wrote:

A few error path issues, plus one leak in the good case.  I'll wait to
see if there are any more comments for a couple of days.

>+static int __init ppc460ex_canyonlands_fixup(void)
>+{
>+	u8 __iomem *bcsr ;
>+	void __iomem *vaddr;
>+	struct device_node *np;
>+	int ret = 0;
>+
>+	np = of_find_compatible_node(NULL, NULL, "amcc,ppc460ex-bcsr");
>+	if (!np) {
>+		printk(KERN_ERR "failed did not find amcc, ppc460ex bcsr node\n");
>+		return -ENODEV;
>+	}
>+
>+	bcsr = of_iomap(np, 0);
>+	of_node_put(np);
>+
>+	if (!bcsr) {
>+		printk(KERN_CRIT "Could not remap bcsr\n");
>+		ret = -ENODEV;
>+	}
>+
>+	np = of_find_compatible_node(NULL, NULL, "ibm,ppc4xx-gpio");

This can fail if you boot a new kernel on a board with an old FDT that
lacks the gpio node.  Calling of_iomap with a NULL np seems like it
would work without crashing anything, so maybe that's not a huge issue.

>+	vaddr = of_iomap(np, 0);
>+	if (!vaddr) {
>+		printk(KERN_CRIT "Could not get gpio node address\n");
>+		ret = -ENODEV;
>+		goto err_bcsr;
>+	}

A reference count is leaked for the node in this error case because
of_node_put isn't called for the gpio node.  Also, iounmap is never
called on vaddr.

>+	/* Disable USB, through the BCSR7 bits */
>+	setbits8(&bcsr[7], BCSR_USB_EN);
>+
>+	/* Wait for a while after reset */
>+	msleep(100);
>+
>+	/* Enable USB here */
>+	clrbits8(&bcsr[7], BCSR_USB_EN);
>+
>+	/*
>+	 * Configure multiplexed gpio16 and gpio19 as alternate1 output
>+	 * source after USB reset. In this configuration gpio16 will be
>+	 * USB2HStop and gpio19 will be USB2DStop. For more details refer to
>+	 * table 34-7 of PPC460EX user manual.
>+	 */
>+	setbits32((vaddr + GPIO0_OSRH), 0x42000000);
>+	setbits32((vaddr + GPIO0_TSRH), 0x42000000);
>+	of_node_put(np);
>+err_bcsr:
>+	iounmap(bcsr);
>+	return ret;
>+}
>+machine_device_initcall(canyonlands, ppc460ex_canyonlands_fixup);

josh
