Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 86CB7DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 10:08:18 +1100 (EST)
To: niklaus.giger@member.fsf.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem compiling sequoia using DENX kernel. Xenomai-patch
	required?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 02 Dec 2007 21:41:35 +0100."
	<200712022141.36467.niklaus.giger@member.fsf.org>
Date: Tue, 04 Dec 2007 00:08:16 +0100
Sender: wd@denx.de
Message-Id: <20071203230816.1C502242E9@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200712022141.36467.niklaus.giger@member.fsf.org> you wrote:
> 
> I tried with (tags DENX-v2.6.23.9, DENX-v.2.6.23, master) to build a kernel 
> for the sequoia board.
> I am using ELDK 4.1. I did a 
> git checkout -b copy-master master
> make ARCH=powerpc CROSS_COMPILE=ppc_4xx- CFLAGS=-g sequoia_defconfig 
> make ARCH=powerpc CROSS_COMPILE=ppc_4xx- CFLAGS=-g zImage 

The ARCH=powerpc is the "interesting" part here.

> First I stumbled about problem compiling arch/powerpc/platforms/44x/ppc4xx*.c
> file with errors like
> arch/powerpc/platforms/44x/ppc4xx-pci.c: In function 'ppc4xx_setup_pci':
> arch/powerpc/platforms/44x/ppc4xx-pci.c:62: sorry, unimplemented: inlining 
> failed in call to 'pci_cfg_out': function body not available
> arch/powerpc/platforms/44x/ppc4xx-pci.c:98: sorry, unimplemented: called from 
> here

There are many moving targets in the ARCH=powerpc hemisphere for 4xx
systems...

> I thought that denx compiled images for the sequoia using 2.6.23. 

Yes, we do. But stable support is only available  with  the  arch/ppc
tree yet.

> Do they only work after having applied the Xenomai patch? Because if I apply 

No.

> the Xenomai patch, the kernel compiles cleanly. In this case  I think it 

That's just lucky coincidence...

> would be nice to get somewhere a hint (or did I missed it somewhere) that 
> this is a requirement. I lost quite a few hours as I wanted to first compile 
> a "normal" kernel and afterwars apply the xenomai patch.

I'm afraid "normal" here still means arch/ppc  -  hopefully  for  not
long any more. Note: a matching Xenomai patch for arch/ppc will be in
Xenomai 2.4 when it comes out in a few days.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Good manners are the settled  medium  of  social,  as  specie  is  of
commercial, life; returns are equally expected for both.
           - Lord Chesterfield _Letters to his Son_, 25 December 1753
