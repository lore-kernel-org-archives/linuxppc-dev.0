Message-ID: <3E82CE15.7080703@bluewin.ch>
Date: Thu, 27 Mar 2003 11:10:29 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8250 pci registers
References: <3E82C15F.7020201@dgt-lab.com.pl>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 03/27/2003 10:16 AM Wojciech Kromer wrote:
> anyone has expirience with 8250 PCI interface
> i'm trying to read something from pci i/o space, but mpc8250 always
> generates 'memory_read' operation on pci bus (i expect io_read to read
> registers on my piix device)
>
> here are my pci registers settings:
>
> GPCR=00000000
> PCIGCR=01000000 PCIMSK0=c0000000        PCIBR0=80000001
> PCIMSK1=c0000000        PCIBR1=80000001 ACR=03
> ALRH=30126745
> PICMR0=00800fa0 PITAR0=00000000 PIBAR0=00000b00
> PICMR1=f0ff0fc0 PITAR1=00000000 PIBAR1=00000800
> POCMR0=f0ff0fc0 POTAR0=00000000 POBAR0=00000b00
> POCMR1=f0ff0fa0 POTAR1=00000000 POBAR1=00000800
>
> anyone knows what's wrong?

Check include/asm-ppc/io.h. Normally the macro _IO_BASE points to the
mapped PCI I/O space. It can then be accessed with inb/outb call for
compatiility with the x86.

Hope it helps,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
