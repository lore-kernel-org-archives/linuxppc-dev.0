Date: Fri, 16 Feb 2001 04:40:02 -0700
From: Matt Porter <mporter@mvista.com>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME5100: kernel hangs in dcache_init
Message-ID: <20010216044002.B8737@cx258813-a.chnd1.az.home.com>
References: <NDBBIFIMCKPOADMAJOKMOENPCOAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBIFIMCKPOADMAJOKMOENPCOAA.s.coluccini@caen.it>; from s.coluccini@caen.it on Fri, Feb 16, 2001 at 12:45:49PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 16, 2001 at 12:45:49PM +0100, Stefano Coluccini wrote:
>
> Hi everyone,
>
>   I'm trying to run Debian linux 2.2.18 on a MVME5100 board. I've done some
> change:
>  - changed addresses of UART registers in arch/ppc/boot/ns16550.h
>  - changed BAT settings in arch/ppc/mm/init.c to map IO region 0xf0000000 to
> 0xffffffff
> and some other things.
> Now the kernel hangs in the dcache_init routine in init/main.c and it seems
> to me that the problem is related to memory management, but I'm not sure.
> If I comment out the the routine calls from dcache_init to check_bugs(), the
> kernel go on a little showing me some infos about PCI devices.
>
> Anyone of you can help me ?

Did you make sure it's getting the correct memory size?  Assuming you're
trying to port into the existing prep_* framework, it does use residual
data to determine memory size.  That used to be reasonable but the
newer MCG boards are not providing any useful information in
residual data, I'd imagine this is also the case with the 5100.  That's
why the new MCG ports in the development tree no longer rely on residual
data.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
