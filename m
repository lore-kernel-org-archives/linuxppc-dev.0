Message-ID: <38E8F720.40E7C0DB@embeddededge.com>
Date: Mon, 03 Apr 2000 15:55:12 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Ruedi.Hofer@ascom.ch, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA support for 860
References: <0FSF00NFMHXF1M@pmdf-it.hasler.ascom.ch> <kfypus7w23t.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> -#define _IO_BASE        0
> +#define _IO_BASE       0xf4000000
> +#define _IO_BASE_SIZE  0x10000
>  #define _ISA_MEM_BASE   0


You have to be very careful with this.  These definitions won't work
on any 8xx with a PCI bridge.  I get too many patches from people that
hack these around to suit their configuration and it breaks everything
else.

The correct (as best I have found :-) approach is to continue to make
IO_BASE represent the PCI/ISA space for which it is intended.  Then
separately map the PCMCIA and adjust the addresses for those drivers
based upon the IO_BASE (so in/out, and so on work).  You can also map
the PCMCIA into the PCI/ISA space as it has address decode priority
over the memory controller.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
