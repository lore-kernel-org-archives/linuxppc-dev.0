Message-ID: <20040524014947.68864.qmail@web15213.mail.bjs.yahoo.com>
Date: Mon, 24 May 2004 09:49:47 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Module Compiling Problem
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040523183459.GA2335@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Mr. Sam,

Nice to meet you!

Sam Ravnborg <sam@ravnborg.org> you wrote:
> Looks wrong.
> When compiling an external module use:
> for 2.4:
> make -C $ERNELSRC SUBDIRS=$PWD modules

Uh,$ERNELSRC or $KERNELSRC?

I use 2.4.18 for the moment.But after following your
instruction,module compiling didn't get through.Pls
see my making process and Makefile below.Did I do
anything wrong or miss what?

-------------------------------------------------
[root@sgj ic]# make -C $KERNELSRC SUBDIRS=$PWD modules
make: ***
SUBDIRS=/workspace/myfilesystem/target/workdir/ic: No
such file or directory.  Stop.

[root@sgj ic]# make -C $ERNELSRC SUBDIRS=$PWD modules
make: ***
SUBDIRS=/workspace/myfilesystem/target/workdir/ic: No
such file or directory.  Stop.

[Makefile]
CC = ppc_8xx-gcc

# TOPDIR  := $(shell /bin/pwd)

FILENAME = myic

MYPATH  = /workspace/keep/dmt201/kernel

CPPFLAGS := -D__KERNEL__ -D_REENTRANT
-I$(MYPATH)/include

CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer \
-fno-strict-aliasing -fno-common -g
-I$(MYPATH)/arch/ppc -fsigned-char -msoft-float -pipe
\
-ffixed-r2 -Wno-uninitialized -mmultiple -mstring

all : $(FILENAME).o

clean :
        rm $(FILENAME).o
$(FILENAME).o : $(FILENAME).c
        $(CC) $(CFLAGS) -DMODULE
-DKBUILD_BASENAME=$(FILENAME) -c $(FILENAME).c

Thanks a million for your notes.

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
