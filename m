Date: Wed, 7 Nov 01 11:41:01 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111071941.AA05998@ivan.Harhan.ORG>
To: dag@newtech.fi
Subject: Re: Port for VG4 from SBS
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dag Nygren <dag@newtech.fi> wrote:

> here is a working port for the VG4 PPC-board from SBS.

and in another post on linuxppc-dev:

> I will attach my port for the SBS VG4 board, it uses the new open_pic() =
>
> interface
> and it would be nice if you checked it out.
> If someone (?) could add it to the BK tree I would also appreciate it.

Hello there. I'm SBS' Linux engineer, and I've looked at your port. I can't
test it right now, and I have to admit that I'm not very familiar with the VG4
as that board was made by an SBS division other than the one where I work. The
division where I work is the Communications group, and that's where most PPC
designs are. VG4 was made by a different group (in a different location) who
apparently took one of our designs and modified it to fit their needs.

I do not have write authority to the public tree, though I do maintain an SBS
internal tree. (The intent of the internal tree is to maintain code that the
official maintainers have refused to check into the public tree, not to
maintain any proprietary code. Everything in my internal tree that isn't in the
public tree has been submitted as patches for the public tree but rejected by
maintainers, and is available to the public in the mailing list archives.)

I would certainly like to collect all Linux ports that exist for SBS boards and
support them. I am reserved, however, about integrating your port because of
the OpenPIC issue. Since I haven't had a chance yet to learn OpenPIC (none of
the boards I've worked on so far had it) and know practically nothing about it
or its implementations, I cannot form an informed opinion about how to best
handle it in Linux/PPC, and I am reserved about integrating code into my
internal tree that isn't in the public tree and that concerns something I know
nothing about.

Since you obviously know more about OpenPIC and its implementations than I do,
I recommend that you try to work the issue out with the Linux/PPC maintainers
to everyone's satisfaction. This would hopefully get your port into the public
tree. That would bring it into SBS' tree automatically, and then we would
probably be able to support it. If that doesn't work and you want me to work on
it, I can do that, but only if I'm allocated time and resources for it. If you
want to make that happen your best course of action would probably be to pursue
it as an SBS customer (I assume you are one as you have our hardware) asking
for Linux support. In that case you would probably want to ask SBS' (this
group's) software engineer manager Art Webb <awebb@sbs.com>.

On other points, I would suggest cleaning up your code formatting and comments
to make it look like the rest of the Linux/PPC code. This will probably
increase your port's chances of getting into the public tree. Commented-out
debug hooks should probably be removed. I don't think you should resurrect
include/asm-ppc/m1543c.h given that at one point it was there and included by
k2.h but then was removed. I don't see your port using those definitions
anywhere, so I would suggest dropping that part of your patch and removing the
inclusion of m1543c.h from vg4.h. Your sym53c8xx driver changes should be kept
separate from the board port, and yet your patch had some sym53c8xx bits in it.

--
Michael Sokolov				5791 VAN ALLEN WAY
Software Engineer			CARLSBAD CA 92008-7321 USA
SBS Technologies, Inc.			Phone: +1-760-438-6900 x2347
Communications Products			    or  1-888-SBS-COMM x2347
					Fax:   +1-760-438-6904
					E-mail: msokolov@sbs.com
					     or msokolov@ivan.Harhan.ORG

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
