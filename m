From: Daniel Wu <Daniel.Wu@alcatel.com.au>
Subject: Re: Using zImage.initrd
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-Id: <00Jun9.185145est.115383@border.alcanet.com.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <00Jun9.083821est.115346@border.alcanet.com.au>
 <3940614D.5BB18EF9@embeddededge.com>
Date: Fri, 9 Jun 2000 18:51:43 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> The zImage bits should be loaded somewhere >= 0x200000.  If this
> doesn't work for you, post a message explaining why and lets find
> a solution.  These addresses are based upon lots of board samples,
> and if yours doesn't fit, let's try to find something that works for
> everything.
>

The zImage.initrd is loaded at 0x200000, this ensures that the zImage >=
0x200000 since the image contains the boot + zImage + initrd. The loader is
copied to 0x600000 and execute from there ( I've reserved 4M for the boot +
zImage + initrd). Will this be a problem?

>
>
> > Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> > NIP: C000D23C XER: 2000E32F LR: C00B8474 REGS: c00e6a90 TRAP: 0300
>
> This is really early in the initialization, and something is really
> messed up.  What processor are you running and what is the silicon
> revision?  Do you have caches enabled?  Where did you get the kernel
> sources?  What have you changed?
>

The CPU is 860T (XPC860TZP50B3). The caches are enabled as far as I can tell
from the code. I got the sources from the MontaVista site and applied the CPU6
patch you posted earlier. Apart from that, a couple of changes to
mbxboot/head.S to set the IMMR and the UPM.

>
> > C00FF71B C00B8474 C00B8648 C00FA2B4 C00F7774 C000221C
>
> What is the rest of this backtrace?
>

C00FF71B buf
C00B8474 extract_entropy
C00B8648 get random_bytes
C00FA2B4 init_elf_binfmt
C00F7774 start_kernel
C000221C start_here


Daniel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
