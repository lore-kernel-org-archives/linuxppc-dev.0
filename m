Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: porter@cox.net
Cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
From: "Allen Curtis" <acurtis@directvinternet.com>
Subject: Re: PCI enlightenment follow-up
Date: Wed, 07 Aug 2002 16:10:03 -0700 (PDT)
Message-Id: <20020807161004.6999.h021.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> &gt; Yes, but I am beginning to suspect that this is where the problem is. If
the
> &gt; I/O addresses should not be translated because the in/out() functions
> &gt; automagically add the offset, then perhaps the I/O regions should not be
> &gt; fixed?
>
> Yep, that's a problem.  Your comment states that
> isa_io_base == io_base_virt.  Yet I see isa_io_base=0x00000000
> and io_base_virt=0x40000000.  You should have isa_io_base=0x40000000.
> You don't want those I/O BARs fixed up as you've suggested above.

I will give this a try but there are several things that bother me:
1. In the 2.4.2 version of this code that works, lspci shows that the I/O region
has been fixed-up.

2. It appears that the ncr_regtest() passes and I am getting reasonable values
from the DSP (script instruction pointer) when using I/O instructions.

3. isa_io_base is set to io_base_virt in pcibios_fixup_bus(). This gives the
fixup routines time to do their thing before the in/out functions reference these
values. (statement in the dump indicates this) I believe I have tested this with
the variable initialization in both places. I am not sure that I have tested it
with version 2 of the sym53c8xx driver, since version 1 is suspenct.

BTW: Could you elaborate on your statement about the 0x40000000 BAT being in the
middle of user task space. I thought all memory was at 0xc0000000. This is how it
is configured under 2.4.2 and it works fine. Is there an updated memory map to
consult?

TIA

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
