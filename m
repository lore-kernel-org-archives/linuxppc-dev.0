Date: Tue, 27 Nov 01 10:46:17 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111271846.AA24695@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Maybe it's just me, but wouldn't you need to know the size to how much
> to shove into memory?

My booter doesn't shove the kernel into memory, if that's what you meant. It
expects the kernel to be there already prior to it being run. I.e., the user
first loads the kernel by whatever means s/he wants (that's why I call it
occult, I don't assume any particular mechanism, the user could use JTAG or
whatever to do it) and *then* runs my booter.

> Because it's only a slightly less magical location than the current one
> (in the wrapper, I don't know where yours puts it).

No, with my solution you don't need to know the kernel size, you just simply
point it at where you've put the bi_recs.

The point is, you broke what worked. I was able to run public Linux on my K2
prior to your change of 2001-11-19, I am not able to any more. You cannot break
code that people use. You must fix it. I have already offered one easy fix.

> Well, that's the fun part.  No one really like the current magic
> location, but no one's come up with a better one.

But why have any magic location at all? I have no problem with your zImage goo
putting bi_recs where it does (hell, I'll never use it anyway, so I don't care
what it does in general), just please don't make the kernel look in any fixed
location and let the booter tell it where it put them.

My booter, for example, doesn't use any magic locations. My booter is a plain
standalone C program built with the GNU toolchain, and I store the bi_recs in
my program's memory. You don't need to worry about what physical address it is,
as I set R3 to point to them when I start vmlinux.

You are welcome to look at my code:

cvs -d :pserver:anoncvs@ivan.Harhan.ORG:/fs3/IFCTF-cvs co ppc-linux-boot

> After reading the
> pmac/chrp stuff which shoves the initrd at the end of RAM (we _could_
> overwrite our initrds that we place right after the kernel, if we have a
> big kernel and low link addresss).  Not that i've tried it yet, it just
> poped out at me.

OK, so now you want to make the kernel look for stuff only at the end of RAM
and nowhere else, right? Then how is it going to know where the end of RAM is
if the memory size is one of the things communicated via bi_recs in the first
place? Isn't it easier to pass a pointer? Then you can make your wrapper/
whatever put them whereever, including the end of RAM if you want, and them
pass a pointer to the kernel.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
