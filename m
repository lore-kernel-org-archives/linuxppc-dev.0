Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A50FEDDF32
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 02:58:34 +1100 (EST)
Date: Mon, 18 Feb 2008 09:58:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: Linker error: no init_fcc_ioports
Message-ID: <20080218155823.GA17534@ld0162-tx32.am.freescale.net>
References: <F795765B112E7344AF36AA911279641502D1AAC0@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F795765B112E7344AF36AA911279641502D1AAC0@xmb-sjc-212.amer.cisco.com>
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

On Fri, Feb 15, 2008 at 06:05:36PM -0800, Bizhan Gholikhamseh (bgholikh) wrote:
> Hi
> Our platform is based on mpc8541cds, I am using Linux 2.6.24 from
> powerpc git tree.
> I tried to compile the kernel to include the fcc Ethernet controller and
> I got the following
> linker  errors:
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
>  
> arch/powerpc/sysdev/built-in.o: In function `fs_enet_of_init':
> arch/powerpc/sysdev/fsl_soc.c:853: undefined reference to
> `init_fcc_ioports'
> arch/powerpc/sysdev/fsl_soc.c:853: undefined reference to
> `init_fcc_ioports'

You need to select PPC_CPM_NEW_BINDING from your board's kconfig entry
(and make sure you comply with the new CPM bindings, and that all pins
are set up by firmware or platform code).

-Scott
