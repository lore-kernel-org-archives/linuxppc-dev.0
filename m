Message-Id: <200006121039.MAA03014@piglet.grunz.lu>
Date: Mon, 12 Jun 2000 12:39:16 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Out of memory?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi list,

I've run into memory problems. I'm experimenting with Gimp, and working
with relatively large images (3000 x 3000 pixels). I'm also working with
large fonts (>100 pixels).

Problem is that the kernel VM layer starts to kill my processes when
they get really big re. memory footprint. Here are the massages from the
kernel:

Jun 12 10:53:13 piglet kernel: VM: killing process gimp
Jun 12 10:55:03 piglet kernel: VM: killing process X
Jun 12 10:59:46 piglet kernel: VM: killing process X
Jun 12 12:04:27 piglet kernel: VM: killing process xfs

and so on... acording to the comment in arch/ppc/mm/fault.c, this
happens when for some reason the kernel cannot satisfy a paging request.

xfs gets killed when rendering a really big font, X when sending it over
to gimp, and gimp when working with large images....

What reason is there to kill a process for memory reasons? Does a single
process need to fit _entirely_ into RAM, or can part of a process be
swapped out? In all of the above cases, I've always had over 100 megs of
swap free. Or is there a fixed limit on how big a process can get?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
