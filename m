Message-ID: <20001020013135.I21761@lx.c-side.com>
Date: Fri, 20 Oct 2000 01:31:35 -0700
From: Neil Russell <caret@c-side.com>
To: Adrian Cox <apc@agelectronics.co.uk>,
        LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc_ide_md.insw
References: <39EEECA5.459D0C93@agelectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39EEECA5.459D0C93@agelectronics.co.uk>; from Adrian Cox on Thu, Oct 19, 2000 at 01:44:21PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


They are used by macros in include/asm-ppc/ide.h called "insw" and "outsw".
I know they are called because I have traced them.  You can just fix the
versions in the arch/ppc/kernel directory to do what you want.

Normally, there is logic to convert 16-bit accesses from a CPU into a pair
of 8-bit accesses for IDE (a hangover from the ISA bus).  Our hardware does
this but I'm not entirely convinced that this is necessary.  Anyhow, if you
are using one of the PPCs in the 8xx family, or the 8260 you can define a
chip select line for IDE that has an 8-bit bus width, obviating any need
to change software.


Neil


On Thu, Oct 19, 2000 at 01:44:21PM +0100, Adrian Cox wrote:
> Do ppc_ide_md.insw and .outsw actually do anything in recent 2.2
> kernels? My grepping has left me unclear.
>
> I need to implement a driver for a compact flash interface which can't
> take 16-bit cycles. Do I need to invent my own mechanism to replace the
> insw and outsw operations in drivers/block/ide.c?
>
> - Adrian Cox, AG Electronics
>

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
