Message-ID: <20040524151734.77584.qmail@web15204.mail.bjs.yahoo.com>
Date: Mon, 24 May 2004 23:17:34 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Module Compiling Problem
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040524050640.GA2245@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sam Ravnborg <sam@ravnborg.org>  you wrote:

> When compiling modules you better use the kbuild infrastructure,
> and then also a kbuild makefile. The way to use the kbuild
> infrastructure is to build your modules with the above command,
> where $KERNELSRC is the directory where you have the kernelsrc.So
> you should use something like: make -C /home/sam/src/kernel/v2.4.18/
> SUBDIRS=$PWD modules assuming the src of the kernel is located in
> /home/sam/src/kernel/v2.4.18/

Thanks for your detailed explaination.I should be
blamed to take $KERNELSRC as a command parameter.:-)

> Try with a Makefile like this:
> [Makefile]
> obj-m := myic.o
>
> That should do it.

Yeah,it did work right.When using it with "make -C
/workspace/keep/dmt201/kernel/ SUBDIRS=$PWD modules"
command,it found myic.c real problem as following:

myic.c:65:1: warning: "MODVERSIONS" redefined
<command line>:1:1: warning: this is the location of
the previous definition
make[1]: Leaving directory
`/workspace/myfilesystem/target/workdir/ic'
make: Leaving directory
`/workspace/keep/dmt201/kernel'

After removing "#define MODVERSIONS" in myic.c,module
compiling work well without any warning.

> [Later you can add the clean stuff]

OK,I added the clean staff in my Makefile like
clean :
        rm myic.o
But I got the mess message as well.

[root@sam ic]# make clean
make: /scripts/pathdown.sh: Command not found
/usr/share/locale/en_US.iso885915/LC_MESSAGES/make.morm
myic.o

It did remove myic.o.Could there any better way to
clean myic.o?

I appreciated your instruction very much.The making
module method is better than my former one.:-)

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
