Message-Id: <200008190826.KAA17158@denx.local.net>
To: clark@esteem.com
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBoot memory mapping problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Aug 2000 17:45:01 PDT."
             <1.5.4.32.20000819004501.006984e4@pop.esteem.com>
Date: Sat, 19 Aug 2000 10:26:22 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <1.5.4.32.20000819004501.006984e4@pop.esteem.com> you wrote:
>
>         I have hacked & slashed the PPCBoot code to work with our custom
> board (all except the flash portion). I have mapped the memory as show below.

Looks OK.

> kernel. Following the instructions in the readme file, I grabbed
> arch/ppc/coffboot/vmlinux.gz and converted as shown. It is given a load
> address of 0x00000000 and an entry point 0x0000000C. I put the converted

Be careful here! This depends on the kernel version! Entry point  0xC
is/was  used in "older" kernel versions like 2.2.13. This has changed
in 2.3.x kernels, which started executing code form 0, so if you  are
running a 2.3 / 2.4 kernel make sure to set the entry point to 0x0.

>         Our board boots up checks the kernels CRC then uncompresses it. It
> then jumps to 0x0000000C. A little bit later it then jumps to some address

This is OK - as soon as the kernel switches on the MMU  it  will  use
virtual addresses.

> 0xC000???? and faults.

This may be casued by a bad entry point (see above), or you might  be
fooled  if  you're  running  with  an ICE that does not work with MMU
(make sure to set the DER to a sensible value, or use a better ICE).

>         Is this what it is supposed to do? Am I supossed to have the RAM

The use of 0xC00xxxxx addresses is supposed to happen, the faults are
not supposed to happen - if they really are. I guess it's  just  your
ICE...

> mapped at 0xC0000000? If it loads at address 0 how do I remap it to
> 0xC0000000 once the kernel starts? Is there any way to force the kernel to
> run in lower memory?

You don't remap the  RAM;  the  kernel  will  take  care  of  address
translation of virtual to physical addresses.


Note 1: I'm not sure if too  many  people  on  the  linuxppc-embedded
        mailing   list   are   interested   in  PPCBoot  issues;  the
        ppcboot-users mailing list is  probably  a  more  appropriate
        place for such discussion.

Note 2: Although not yet officially announced, ppcboot-0.4.3  is  out
        (both   on   the   CVS   server   and   on   our  FTP  server
        (ftp://ftp.demx.de/pub/ppcboot/ppcboot-0.4.3.tar.gz); on  the
        CVS  server  there are even some more recent modifications in
        preparation of suport for some IBM 4xx based board.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have a theory that it's impossible to prove anything, but  I  can't
prove it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
