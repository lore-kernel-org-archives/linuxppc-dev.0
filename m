Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id E83BE67FD6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 01:53:39 +1000 (EST)
Message-ID: <42F8D186.1030209@anagramm.de>
Date: Tue, 09 Aug 2005 17:53:42 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Gerhard Jaeger <g.jaeger@sysgo.com>
References: <20050809140428.13450.qmail@web41211.mail.yahoo.com>
	<200508091615.53736.g.jaeger@sysgo.com>
In-Reply-To: <200508091615.53736.g.jaeger@sysgo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Eric Kampman <erickampman@yahoo.com>, linuxppc-embedded@ozlabs.org
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

Hi!

You might want to try that:

#include <asm/mpc85xx.h>
#include <immap_85xx.h>		/* see mail archives for complete mpc8540 version */
...

void foo(void)
{
	volatile ccsr_t *immap;
	phys_addr_t ccsrbar;

	ccsrbar=get_ccsrbar();
        immap=ioremap(ccsrbar,sizeof(ccsr_t));	/* is ioremap_nochache() the same on mpc85xx? */
        if (!immap) {
                printk(KERN_ALERT "Failed to ioremap CCSRBAR!\n");
                err = -EIO;
                goto out;
        }

	/* examples */
        printk(KERN_INFO "CCSRBAR addr        %.8lx\n",ccsrbar);
	printk(KERN_INFO "IMMAP addr          %p\n",immap);
	printk(KERN_INFO "BR0        %.8x\n",immap->im_lbc.br0);
	printk(KERN_INFO "OR0        %.8x\n",immap->im_lbc.or0);

	/* unmap the ccsr*/
	iounmap(immap);
out:
}

I hope that's all current code.
Comments are welcome.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19


Gerhard Jaeger wrote:
> On Tuesday 09 August 2005 16:04, Eric Kampman wrote:
> 
>>Trying to port an SEC driver to Linux/PPC8555. Reading
>>the default CCSRBAR @ 0xFF700000 I read 0xFFFFFFFF
>>which is wrong. Looking at Metrowerks init files and
>>uboot code (1.1.2) I see it's likely been moved to
>>0xE0000000, but I get a seg fault when I try to read
>>there. 
>>
>>So, what am I doing wrong, and even better, how do I
>>at runtime find out where CCSRBAR is? Thanks in
>>advance, and please forgive the likely ignorance, 
>>
>>Eric
>>
> 
> 
> use the get_ccsrbar() function to get the address, then ioremap()
> will be your friend ;)
> 
> HTH
> Gerhard
