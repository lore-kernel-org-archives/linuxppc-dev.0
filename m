Return-Path: <amarquez@edgeaccess.net>
Received: from [209.168.173.179] (unknown [209.168.173.179])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "firewall.edgeaccess.net",
	Issuer "firewall.edgeaccess.net" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8B912B7D18
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 08:15:44 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by firewall.edgeaccess.net (Postfix) with ESMTP id 047C227404C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jan 2010 16:15:41 -0500 (EST)
Received: from mail.edgeaccess.net (unknown [192.168.10.99])
	by firewall.edgeaccess.net (Postfix) with ESMTP id 3DA5127405D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jan 2010 16:15:35 -0500 (EST)
Date: Mon, 18 Jan 2010 15:56:26 -0500
From: Andres F Marquez <amarquez@edgeaccess.net>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <1263848186.16967.6.camel@localhost.localdomain>
In-Reply-To: <1263614364.2806.20.camel@ccs-laptop>
References: <1263501641.12055.9.camel@localhost.localdomain>
References: <1263565840.13514.2.camel@localhost.localdomain>
References: <1263614364.2806.20.camel@ccs-laptop>
Subject: Re: Problem dtb file booting Kernel 2.6.32
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Hunter Cobbs <hunter.cobbs@gmail.com>
Reply-To: Andres Marquez <amarquez@edgeaccess.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

   I finally got the dtb working for the Kernel 2.6.32.2. I went to an
old folder backup that I had in which I found some files used by LTIB
for the Kernel configuration and restore them (including .config file).
Then, I removed the /localbus and /pci references from my dtb file
because I am not using them at this point. I did it using the fdt
utility under uboot.

Thank you everyone for your help.


-- 
Andres F Marquez
EdgeAccess
Development
amarquez@edgeaccess.net



On Fri, 2010-01-15 at 21:59 -0600, Hunter Cobbs wrote:
> Hi,
> 
> If you're going to attempt to use v1 dts, you might want to try to add
> 
> 
>  * option) any later version.
>  */
> 
> /dts-v1/;
> 
> / {
> 
> to your DTS file.  Also, you'll want to prefix all of your hex addresses
> with "0x"  so, 200000 = 0x200000
> 
> Hope that helps,
> Hunter
> 
> 
> On Fri, 2010-01-15 at 09:30 -0500, Andres F Marquez wrote:
> > Hello,
> > 
> > I was able to boot Kernel 2.6.26.8 (using our old dts file from 
> > Kernel 2.6.25). However, I need to upgrade to a newer Kernel because
> > I am having serious problems with the ethernet interface under heavy
> > load. I am not sure if it could be a scheduling problem or the network
> > driver. CPU usage is low but load average is high (more than 4).
> > 
> > The main difference that I could find is that for newer Kernels the 
> > /arch/ppc was removed. I also read online that dts version changed 
> > from 0 to 1 somewhere around Kernel 2.6.27 or so.
> > 
> > Following your instruction, I executed in the LTIB command shell:
> > 
> > LTIB> dtc -I dtb -O dts ../mpc8272ads.dtb
> > 
> > I executed that command passing as argument the old working dtb file.
> > I got a dts file which I placed in the new Kernel and compiled.
> > Unfortunately, I am still getting the same error.
> > 
> > Attached you can find both dts files.
> > 
> > Thank you.
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
