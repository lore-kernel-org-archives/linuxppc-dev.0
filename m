Date: Wed, 13 Dec 2000 13:41:15 -0700
From: Matt Porter <mporter@mvista.com>
To: Torsten Rissel <torsten.rissel@t-online.de>
Cc: "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME 5100
Message-ID: <20001213134115.A3059@cx258813-a.chnd1.az.home.com>
References: <01C06555.A2E02D00@NB2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01C06555.A2E02D00@NB2>; from torsten.rissel@t-online.de on Wed, Dec 13, 2000 at 10:39:59PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 13, 2000 at 10:39:59PM +0100, Torsten Rissel wrote:
>
> Hi Everybody !
>
> I am trying to run Linux on an MVME5100 board. I am using PReP-style booting and
> got the boot process and some of the kernel initialization running. But I am missing any
> knowledge of other PowerPC boards or machines, so that it is relativly hard to find out
> what exactly to change. So I have a question: The MVME5100 is missing all ISA stuff.
> Is the IRQ mapping (first 16 for the 8259 and the other 16 for the MPIC) still valid ?

Might as well just use 16-31 and stick with the MPIC convention.  If
somebody else is using the 5100 with the IPMC761 then they will have
ISA and will thank you many times for not changing things.

> Also I run in a problem: the indirect mechanism for generating PCI config cycles is set
> up correctly, but the board seems to hang when reading from the CONFIG_DATA address !!!???

Make sure you have those Hawk registers covered with a BAT or PTEs.
Notice the areas covered by BATs in the MACH_prep BAT setup case in
arch/ppc/mm/init.c.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
