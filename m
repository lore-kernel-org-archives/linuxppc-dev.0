Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 713F2DDE2F
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 17:48:32 +1000 (EST)
In-Reply-To: <20070725072712.GB24093@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0707250210520.14366@blarg.am.freescale.net>
	<20070725072712.GB24093@uranus.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1409C32B-61A8-49D1-BF64-1CFAA5F8B93B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: modpost warning question
Date: Wed, 25 Jul 2007 02:49:14 -0500
To: Sam Ravnborg <sam@ravnborg.org>
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


On Jul 25, 2007, at 2:27 AM, Sam Ravnborg wrote:

> On Wed, Jul 25, 2007 at 02:14:12AM -0500, Kumar Gala wrote:
>> I'm seeing the following warning:
>>
>> WARNING: vmlinux.o(.init.text+0x1acdc): Section mismatch:  
>> reference to
>> .exit.text:gfar_mdio_exit (between 'gfar_init' and 'gfar_mdio_init')
>>
>> I don't understand why its not ok to access .exit.text  
>> from .init.text
>
> Several architectures discards .exit.text in the final linker
> script (arch/$(ARCH)/kernel/vmlinux.lds.S
>
> So any references to .exit.text will when a module is build-in result
> in a linker error because ld will flag it as an error when we  
> reference
> a symbol in a discarded section.
>
> For the popular architectures (i386,x86_64) we discard .exit.text at
> runtime so here we do not see the error from ld (sadly).

Fair point, wondering what we do with .exit on PPC, another thing for  
the list :)

- k
