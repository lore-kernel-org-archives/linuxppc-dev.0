Return-Path: <jwboyer@jdub.homelinux.org>
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20051108153036.F27232@cox.net>
References: <20051107124917.C1671@cox.net>
	<20051107190128.68d41294.akpm@osdl.org> <20051108093759.A26086@cox.net>
	<200511081838.11236.sr@denx.de>  <20051108153036.F27232@cox.net>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 16:32:54 -0600
Message-Id: <1131489174.26096.0.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	linuxppc64-dev@ozlabs.org
Subject: Re: 440EP FPU support missing
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-11-08 at 15:30 -0700, Matt Porter wrote:
> On Tue, Nov 08, 2005 at 06:38:11PM +0100, Stefan Roese wrote:
> > In the current linux version, Bamboo (440EP) won't compile anymore, because of 
> > missing fpu support:
> > 
> > make uImage
> > ...
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > arch/ppc/kernel/head_44x.o(.text+0x868): In function `_start':
> > : undefined reference to `KernelFP'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > Somehow arch/ppc/kernel/fpu.S has disappeared. :-( I assume, this happened in 
> > the ppc/ppc64 -> powerpc merge. Any thoughts, why this file disappeared and 
> > how to solve this problem (just restore the original file)?
> 
> arch/powerpc/kernel/fpu.S is being used now which doesn't have KernelFP.
> I don't know why the 44x fpu support wasn't using
> kernel_fp_unavailable_exception() before but I must have missed that
> reviewing it.
> 
> Try this patch.

Doesn't this render the 440EP's FPU useless?

josh
