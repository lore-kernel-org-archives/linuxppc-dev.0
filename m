Message-ID: <371F76F4.27B2850D@fi.infn.it>
Date: Thu, 22 Apr 1999 21:22:28 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MVME2306 : kernel 2.2.6 SUCCESS !
References: <Pine.HPP.3.96.990421181843.20020c-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
> 
> :-( You should include linux/string.h instead of string.h.
> 
>         Gabriel.
Hi, 
I made the correction you suggested, and that time make zImage compiled
well the routine, but then it stopped a bit further when doing vmlinuz
and zImage.
This was due to these two lines:

ld -o zImage $(OBJECTS) --just-symbols=$(TOPDIR)/vmlinux

objcopy $(TOPDIR)/vmlinux vmlinux -O binary -R .comment -S

in /home/ppc/linux/arch/ppc/prepboot/Makefile

That just don't work on my PC, because in this way the makefile is using
the intel tools, I modified in: 

$(CROSS_COMPILE)ld -o zImage $(OBJECTS) --just-symbols=$(TOPDIR)/vmlinux

$(CROSS_COMPILE)objcopy $(TOPDIR)/vmlinux vmlinux -O binary -R .comment
-S

and everything went fine. So now I can start to do check with your
images.

Many thanks for all the help

-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
