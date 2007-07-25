Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 49CF0DDD05
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 17:45:10 +1000 (EST)
Date: Wed, 25 Jul 2007 09:27:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: modpost warning question
Message-ID: <20070725072712.GB24093@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0707250210520.14366@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0707250210520.14366@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 25, 2007 at 02:14:12AM -0500, Kumar Gala wrote:
> I'm seeing the following warning:
> 
> WARNING: vmlinux.o(.init.text+0x1acdc): Section mismatch: reference to
> .exit.text:gfar_mdio_exit (between 'gfar_init' and 'gfar_mdio_init')
> 
> I don't understand why its not ok to access .exit.text from .init.text

Several architectures discards .exit.text in the final linker
script (arch/$(ARCH)/kernel/vmlinux.lds.S

So any references to .exit.text will when a module is build-in result
in a linker error because ld will flag it as an error when we reference
a symbol in a discarded section.

For the popular architectures (i386,x86_64) we discard .exit.text at
runtime so here we do not see the error from ld (sadly).

	Sam
