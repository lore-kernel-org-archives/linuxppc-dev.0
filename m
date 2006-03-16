Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.4.116])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6ED08679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 10:19:20 +1100 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k2GNJBjI026857
	for <linuxppc-embedded@ozlabs.org>; Fri, 17 Mar 2006 00:19:12 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4419F26B.8020701@246tNt.com>
Date: Fri, 17 Mar 2006 00:19:07 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Henry Quinn <hquinn@sse.co.za>
Subject: Re: kernel support for the MPC5200b
References: <20060316061222.A93517A44CC@mail.sse.co.za>
In-Reply-To: <20060316061222.A93517A44CC@mail.sse.co.za>
Content-Type: text/plain; charset=windows-1252
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

Henry Quinn wrote:
>
> Hello all
>
> I want to run the Linux kernel on a device based on the Freescale
> MPC5200b, based on the MPC603e series G2_LE core.
>
> What I don’t understand is whether support for this processor is built
> into the kernel or not, can one take a stock kernel from
>
> www.kernel.org <http://www.kernel.org/> and compile it to run on this
> processor or are there a series of patches that one needs to apply
> before the
>
> kernel will run on this processor?
>

The 5200b isn't that different from the 5200 ... most of the important
differences should be taken care of in the boot loader (some supplementary
CPU init iirc) and U-Boot takes care of that.

The major difference that needs to be taken care of in the kernel is the
PCI ID of the host bridge ... But that's trivial to take care of ...

But the dev board lite5200 and lite5200b have some differences in the
mapping of the PCI irq to the IRQ[0-3] pins and so requires some change in
the platform dependent code, but if your device is another board then
you need
to do your own platform support file any way ...


Sources for the the kernels are :
- denx.de that provides 2.4 and 2.6
- the GIT tree at http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.git

If you decide to try the last one, please don't clone directly from
there, but :

git clone
git://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
cd linux-2.6
git pull http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.git#ide
git pull http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.git#bestcomm

that should give you a tree with ide & fec support that has supports for the
lite5200b and that works ... (make sure you have a console=ttyPSC0 in your
kernel command line, that's required for the 246tnt's git tree and the
kernel.org
one. For the denx ones, i think it's console=ttyS0 that's required ...)


Sylvain
