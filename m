Message-ID: <3BE1E882.6EAE635D@linux-m68k.org>
Date: Fri, 02 Nov 2001 01:27:46 +0100
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: APUS irq patch
References: <Pine.LNX.4.33.0111020007080.8971-100000@serv> <20011101165333.A26680@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Tom Rini wrote:

> > This patch converts the irq assembly in head.S into C, the only problem is
> > that I needed to change a prototype in <linux/irq.h>, as some additional
> > info has to be saved/restored during an irq.
>
> Ack.  Won't this break other things?  I'm assuming other arches use
> -end() too..

Quite a lot actually and I don't think it's solvable before 2.5.
It's a bit unfortunate that a architecture specific structure is in a
general header. post_irq doesn't exist anymore (which had the pt_regs
pointer), the only other solution would be to rename hw_interrupt_type
and use a private version.

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
