Message-ID: <B0001822783@icamail.ica.net>
Subject: [LinuxPPC] invoking GCC
Date: Sun, 28 Mar 99 01:49:01 -0400
From: Trevor Woerner <twoerner@ica.net>
To: "Developer LinuxPPC" <linuxppc-dev@lists.linuxppc.org>,
        "Users LinuxPPC" <linuxppc-user@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Friends,

now that i have a working cross compiler i would like to ask
(again) about an easy way to run it.

>now i'm trying to compile:
>
>----- firsttest.c -------------------------------------------
>main()
>{
>    int a=5,b=10;
>    int c;
>
>    c = a + b;
>
>    return 0;
>}
>
>compile line:
>user# powerpc-linux-gcc -o first firsttest.c
>user# first
>bash: ./first: cannot execute binary file
>
>SUCCESS!! copy over to LinuxPPC and it runs!
>
>
>----- secondtest.c ------------------------------------------
>#include <stdio.h>
>
>main()
>{
>    printf( "hello world!\n" );
>    return 0;
>}
>
>compile line:
>user# powerpc-linux-gcc -I /usr/local/ppc/powerpc-linux/include/ -L 
>/usr/local/ppc/powerpc-linux/lib/ -o second secondtest.c
>user# first
>bash: ./first: cannot execute binary file
>
>copy over to LinuxPPC... and it runs!!
>hello world!

i've tried:

>user# gcc -b powerpc-linux -o thirdb thirdtest.c

which gives the error:

>as: unrecognized option `-ppc'

i assume this is because the wrong "as" is being invoked?
how would i get it to invoke the powerpc-linux-as (which
IS in the PATH btw)

>
>user#  powerpc-linux-gcc -I /usr/local/ppc/powerpc-linux/include/ -L 
>/usr/local/ppc/powerpc-linux/lib/ -o third2 thirdtest.c

that one's okay, but

>user#  powerpc-linux-gcc -I /usr/local/ppc/powerpc-linux/include/ -L 
>/usr/local/ppc/powerpc-linux/lib/ -static -o third2 thirdtest.c

gives:

>/usr/local/ppc/powerpc-linux/lib/crt1.o(.text+0x54): undefined reference 
>to `__libc_init_first'
>collect2: ld returned 1 exit status

which looks like one of those glib5/glib6 type problems. which would
suggest it's picking up the wrong libraries. how do i set this?

in any case the executable isn't dynamic (according to ldd).

in the final analysis it does work and i can product ppc executables
so i want to stress that i'm not complaining. but after all the trouble
i've been through, to not get it 100% working, right when i'm on the 
5-yard-line...

thanks and best regards,
   trevor woerner

------------------------------------------------------------

...Senior, for his first selection, will play "A Cup Of
   Coffee, A Sandwich, And You" from the opera: Aida

                             --- Groucho Marx
                                 The Cocoanuts, 1929


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
