Date: Mon, 24 May 2004 07:06:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: Sam Ravnborg <sam@ravnborg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Module Compiling Problem
Message-ID: <20040524050640.GA2245@mars.ravnborg.org>
References: <20040523183459.GA2335@mars.ravnborg.org> <20040524014947.68864.qmail@web15213.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040524014947.68864.qmail@web15213.mail.bjs.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 24, 2004 at 09:49:47AM +0800, Song Sam wrote:
> > When compiling an external module use:
> > for 2.4:
> > make -C $ERNELSRC SUBDIRS=$PWD modules
>
> Uh,$ERNELSRC or $KERNELSRC?

When compiling modules you better use the kbuild infrastructure, and
then also a kbuild makefile.
The way to use the kbuild infrastructure is to build your
modules with the above command, where $KERNELSRC is
the directory where you have the kernelsrc.
So you should use something like:
make -C /home/sam/src/kernel/v2.4.18/ SUBDIRS=$PWD modules
assuming the src of the kernel is located in
/home/sam/src/kernel/v2.4.18/

> [Makefile]
> CC = ppc_8xx-gcc
>
> # TOPDIR  := $(shell /bin/pwd)
>
> FILENAME = myic
>
> MYPATH  = /workspace/keep/dmt201/kernel
>
> CPPFLAGS := -D__KERNEL__ -D_REENTRANT
> -I$(MYPATH)/include
>
> CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer \
> -fno-strict-aliasing -fno-common -g
> -I$(MYPATH)/arch/ppc -fsigned-char -msoft-float -pipe
> \
> -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
>
> all : $(FILENAME).o
>
> clean :
>         rm $(FILENAME).o
> $(FILENAME).o : $(FILENAME).c
>         $(CC) $(CFLAGS) -DMODULE
> -DKBUILD_BASENAME=$(FILENAME) -c $(FILENAME).c
>
> Thanks a million for your notes.

Try with a Makefile like this:
[Makefile]
obj-m := myic.o

That should do it.
[Later you can add the clean stuff]

	Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
