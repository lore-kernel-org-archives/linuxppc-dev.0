In-Reply-To: <Pine.HPP.3.96.990215164341.5352k-100000@gra-ux1.iram.es>
Date: Mon, 15 Feb 1999 17:48:41 +0100
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
CC: paulus@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Problem with iMacs and kernel entry
Message-Id: <19990215174841.011716@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 15, 1999, Gabriel Paubert <paubert@iram.es> wrote:

>Well, in prepboot the MMU is enabled for a lot of reasons. This requires
>the installation of 603 TLB miss handlers (which are well tested since I
>only have 603), then I play with a lot of I/O (including complete
>reconfiguration of PCI I/O and memory spaces to work around braindead PreP
>firmware: I don't want to sacrifice 256 Mb to PCI I/O) and disable the MMU
>before passing control to the kernel.  So it's doable. There are also some
>documents about how to perform a smooth transition of MMU management
>between OF and client program.  I wanted to implement this but am lacking
>time right now.

I'm interested in pointer to those documents, do you have URLs handy ?

I finally have the boostrap working on my G3. It's about 400 bytes of PPC
asm, that's all ;-) Basically, what it does is:

 - Switch Interrupts off, MMU off, invalidate BATs, flush TLB
 - Copy itself elsewhere in case it overlaps the kernel destination
 - Execute a "script" of copy operations to perform, the script is appended to
   the boostrap itself by BootX. This scripts will copy kernel pages from
whatever
   location they occupy in memory (kernel is not made contiguous under
MacOS anymore).
   At the end of this process, we have the kernel copied at 0 physical
and contiguous
   (by "kernel", I mean here the pack
kernel+ramdisk+args+colormap+device-tree.
 - The kernel is entered with a stack pointer pointing to the
(top-512bytes) of
   a 64Kb area located just after the kernel "block".

The best way to fix the iMac problem is, I beleive, to move the code for
switching the USB controller off to BootX (it's in a BootX-specific
section of code anyway) and remove the one in the kernel. This will cause
compatibility trouble between new BootX and old kernels on the iMac, but
iMac users, I beleive, still update their kernels quite often, so it's
not a very big problem. Note that we can probably remove the
page-touching code from prom.c too.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
