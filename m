Return-Path: <hunter.cobbs@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 413DDB7C8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jan 2010 14:59:30 +1100 (EST)
Received: by yxe9 with SMTP id 9so191468yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jan 2010 19:59:28 -0800 (PST)
Subject: Re: Problem dtb file booting Kernel 2.6.32
From: Hunter Cobbs <hunter.cobbs@gmail.com>
To: Andres Marquez <amarquez@edgeaccess.net>
In-Reply-To: <1263565840.13514.2.camel@localhost.localdomain>
References: <1263501641.12055.9.camel@localhost.localdomain>
	<1263565840.13514.2.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jan 2010 21:59:24 -0600
Message-ID: <1263614364.2806.20.camel@ccs-laptop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

If you're going to attempt to use v1 dts, you might want to try to add


 * option) any later version.
 */

/dts-v1/;

/ {

to your DTS file.  Also, you'll want to prefix all of your hex addresses
with "0x"  so, 200000 = 0x200000

Hope that helps,
Hunter


On Fri, 2010-01-15 at 09:30 -0500, Andres F Marquez wrote:
> Hello,
> 
> I was able to boot Kernel 2.6.26.8 (using our old dts file from 
> Kernel 2.6.25). However, I need to upgrade to a newer Kernel because
> I am having serious problems with the ethernet interface under heavy
> load. I am not sure if it could be a scheduling problem or the network
> driver. CPU usage is low but load average is high (more than 4).
> 
> The main difference that I could find is that for newer Kernels the 
> /arch/ppc was removed. I also read online that dts version changed 
> from 0 to 1 somewhere around Kernel 2.6.27 or so.
> 
> Following your instruction, I executed in the LTIB command shell:
> 
> LTIB> dtc -I dtb -O dts ../mpc8272ads.dtb
> 
> I executed that command passing as argument the old working dtb file.
> I got a dts file which I placed in the new Kernel and compiled.
> Unfortunately, I am still getting the same error.
> 
> Attached you can find both dts files.
> 
> Thank you.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
