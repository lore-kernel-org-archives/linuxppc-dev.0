Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id 54619DDFA1
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 08:12:48 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4052016wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 15:12:47 -0700 (PDT)
Date: Fri, 11 Jul 2008 16:12:44 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Lamontagne <sylvain.lamontagne@novariant.com>
Subject: Re: Installation on a MPC5200 based custom board
Message-ID: <20080711221244.GE18239@secretlab.ca>
References: <1215814074.9106.76.camel@NV10035>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1215814074.9106.76.camel@NV10035>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Michel Lemieux <Michel.Lemieux@novariant.com>, linuxppc-dev@ozlabs.org,
	Craig Cornwall <craig.cornwall@novariant.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 11, 2008 at 06:07:54PM -0400, Sylvain Lamontagne wrote:
> Greetings
> 
> We are currently trying to put a Kernel 2.6.26 on a custom board based
> on the MPC5200 processor and the designed of the board was based on the
> lite5200b evaluation board.
> 
> We would like to have some advice regarding the installation process for
> this kernel. The hardware currently work (still buggy, but work) with a
> kernel 2.6.23 compiled with ARCH ppc running on a U-Boot 1.1.6. For what
> I understand now, the ARCH ppc if kind of deprecated and we have to
> switch to ARCH powerpc. I'm new to the concept of device tree, do I have
> to modify it myself or the file wild be generated automatically ?

You need to modify it yourself.  I suspect that most of it will be
identical to the lite5200b, but you'll need to make adjustments for
things like PSC usage and PCI interrupt mappings.

> Should it be better for us to upgrade our version of U-Boot to 1.3.* to
> get the support of device tree? Currently we tried with the wrapper
> trick of using cuImage.lite5200b and the v1.1.6 but it doesn't seem to
> work.

It's a good idea, but you don't need to.  The cuImage target should work
well after you've created a custom .dts file for your board.

> Also, we would like to know if we have to recompile everything on the
> board (U-Boot/Kernel/Busybox) since we switched ARCH from ppc to
> powerpc?

No, you do not.

> We are also wondering what is the cross-compilation tools that you are
> using? Or do you have any good advice on a choice? Currently we are
> building with gcc-4.1.0-glibc-2.3.6 for ppc on an x86 host running
> Ubuntu 8.04 or we also have a Fedora Core 7 laptop but, I have see a
> kernel compilation warning regarding gcc 4.1 saying that it's known to
> brake the kernel.

Personally, I use ELDK from Denx.

> Should we upgrade everything (U-Boot/Kernel/Busybox) and recreate a new
> Ramdisk ?

No, you don't have to.

> Anybody know a good development tools to use with a CodeWarrior USB TAP
> from freescale ? The CodeWarrior IDE doesn't seems to work properly for
> us.

I haven't used codewarrior for Linux development.  The Abatron BDI-3000
works really well for me.

Cheers,
g.
