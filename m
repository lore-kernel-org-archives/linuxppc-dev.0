Date: Fri, 20 Apr 2001 12:03:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Oliver Brown <obrown@adventnetworks.com>
Cc: linuxppc-embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Module support for 8260 in 2.4(.1) kernel
Message-ID: <20010420120329.B13403@opus.bloom.county>
References: <CD5CA14300A9D54A8D13D58CD3C87B422DD731@advcorp-exc01.advent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CD5CA14300A9D54A8D13D58CD3C87B422DD731@advcorp-exc01.advent.com>; from obrown@adventnetworks.com on Fri, Apr 20, 2001 at 01:51:00PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 20, 2001 at 01:51:00PM -0500, Oliver Brown wrote:

> I am working on loadable driver modules for the 8260. I had to make the
> changes below to the ppc_ksyms.c file to export the symbols in needed.
>
> The problems I am having are
> 1. The udelay marco is not exportable. Is there a substitute? For now I
> am using __delay() which is not a constant delay.

Er, you should be able to at least kludge around this and use __udelay
which skips the macro (which just does sanity checks).

> 2. The m8260_cpm_hostalloc() and m8260_cpm_dpalloc do not have deallocs.
> I can load my module, but I can't unload it.
>
> I've added an init_module and cleanup_module to the fcc_enet.c from
> (bitkeeper 2.5 tree). Also, I had to replace all of the udelay()'s with
> __delay()'s. And I've diabled the MDIO PHY support.

Er, what tree is this vs exactly?  Also, can you send a unified diff
next time?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
