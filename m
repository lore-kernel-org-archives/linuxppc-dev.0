Message-ID: <3ECC532F.1080008@embeddededge.com>
Date: Thu, 22 May 2003 00:33:51 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jim Rowe <rowejames@acmsystems.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8250 + PCMCIA + airo_cs card + IO Port mapping problem?
References: <1053557921.16972.149.camel@kneedragger>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Rowe wrote:

>>From what I can see - and please correct me if I'm wrong, the way that
> Linux translates the Port IO to the memory mapped IO is through the outb
> and outw macros, which add an offset of _IO_BASE. How do I determine the
> correct value of _IO_BASE?

The value of _IO_BASE depends upon how you configure and map the host PCI
bridge on the 8250.

> ... I looked in m8260_setup.c and found

The 8260 doesn't have a PCI bridge, so these mappings aren't appropriate
for your board.  The 0xf0000000 is needed to get to the IMMR space, but
those accesses don't (shouldn't) be using in/out macros.  The 0xe0000000
space is generally used for flash prom, external devices, local sdram
and so on.

There are a variety of configuration options for the PCI bridge and all of
the other I/O in your system and the mapping using either BATs or page
tables.  It depends upon the address ranges of all of the I/O in your
system and their physical space allocation.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
