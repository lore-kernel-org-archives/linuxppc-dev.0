Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 66C6C67FD7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 02:05:07 +1000 (EST)
Date: Tue, 9 Aug 2005 11:04:59 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Clemens Koller <clemens.koller@anagramm.de>
Message-Id: <20050809110459.038ffc78.kim.phillips@freescale.com>
In-Reply-To: <42F8D186.1030209@anagramm.de>
References: <20050809140428.13450.qmail@web41211.mail.yahoo.com>
	<200508091615.53736.g.jaeger@sysgo.com>
	<42F8D186.1030209@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, erickampman@yahoo.com
Subject: Re: MPC8555CDS & CCSRBAR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

or this...

static int sec_probe(struct device *device)
{
	struct platform_device *pdev = to_platform_device(device);
	struct resource *r;

	sec_irq = platform_get_irq(pdev, 0);
	rc = request_irq(sc->sc_irq, talitos_intr, 0, "talitos", sc);
	if (rc) {
		printk("failed to hook irq %d\n", sec_irq);
		sec_irq = -1;
		goto out;
	}

	/* we read its hardware registers as memory */
	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);

	sec_base_addr = (ocf_iomem_t) ioremap(r->start, (r->end - r->start));
	if (!sec_base_addr) {
		printk("failed to ioremap 0x%x-0x%x\n",
				(u32)r->start, (u32)r->end - (u32)r->start);
		goto out;
	}
...
}

Kim

On Tue, 09 Aug 2005 17:53:42 +0200
Clemens Koller <clemens.koller@anagramm.de> wrote:

> Hi!
> 
> You might want to try that:
> 
> #include <asm/mpc85xx.h>
> #include <immap_85xx.h>		/* see mail archives for complete mpc8540 version */
> ...
> 
> void foo(void)
> {
> 	volatile ccsr_t *immap;
> 	phys_addr_t ccsrbar;
> 
> 	ccsrbar=get_ccsrbar();
>         immap=ioremap(ccsrbar,sizeof(ccsr_t));	/* is ioremap_nochache() the same on mpc85xx? */
>         if (!immap) {
>                 printk(KERN_ALERT "Failed to ioremap CCSRBAR!\n");
>                 err = -EIO;
>                 goto out;
>         }
> 
> 	/* examples */
>         printk(KERN_INFO "CCSRBAR addr        %.8lx\n",ccsrbar);
> 	printk(KERN_INFO "IMMAP addr          %p\n",immap);
> 	printk(KERN_INFO "BR0        %.8x\n",immap->im_lbc.br0);
> 	printk(KERN_INFO "OR0        %.8x\n",immap->im_lbc.or0);
> 
> 	/* unmap the ccsr*/
> 	iounmap(immap);
> out:
> }
> 
> I hope that's all current code.
> Comments are welcome.
> 
> Greets,
> 
> Clemens Koller
> _______________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Str. 45/1
> 81379 Muenchen
> Germany
> 
> http://www.anagramm.de
> Phone: +49-89-741518-50
> Fax: +49-89-741518-19
> 
> 
> Gerhard Jaeger wrote:
> > On Tuesday 09 August 2005 16:04, Eric Kampman wrote:
> > 
> >>Trying to port an SEC driver to Linux/PPC8555. Reading
> >>the default CCSRBAR @ 0xFF700000 I read 0xFFFFFFFF
> >>which is wrong. Looking at Metrowerks init files and
> >>uboot code (1.1.2) I see it's likely been moved to
> >>0xE0000000, but I get a seg fault when I try to read
> >>there. 
> >>
> >>So, what am I doing wrong, and even better, how do I
> >>at runtime find out where CCSRBAR is? Thanks in
> >>advance, and please forgive the likely ignorance, 
> >>
> >>Eric
> >>
> > 
> > 
> > use the get_ccsrbar() function to get the address, then ioremap()
> > will be your friend ;)
> > 
> > HTH
> > Gerhard
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Kim
