Message-Id: <5.1.0.14.0.20020502151645.00b51840@pop.gmx.de>
Date: Thu, 02 May 2002 15:17:39 +0800
To: <hychon@corebell.co.kr>
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: looking for source files for MPC8xx --- help me~~~
Cc: <linuxppc-embedded@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:22 AM 4/30/2002 +0900, you wrote:
>2. and I found some source for bash-xxx.tar.gz ..etc  from gnu.org
>when I complile the sources using powerpc-linux compiler  ( gcc-2.95 ,
>glibc-2.2.3 )
>it's giving error  that
>
>checking  whetehr setvbuf argument are reserved... configure: error cannot
>run test program while cross compiling
>
>
>I was compiled following option
>#./configure --host=poweprc-linux --build=i386-linux

The configure script tries to find out a configuration option by creating a
small c file, compiling it and executing afterwards. Because you
cross-compile, executing doesn't work.
So you have to check the configure script, what is tested and find the
correct result of the test, e.g. by looking into the man page of setvbuf.
Finally, you have to overwrite the variable for the configure script, so
that it doesn't need to execute the test anymore. It looks like this then:

ac_xxx=yes ac_yyy=no ./configure --host=poweprc-linux --build=i386-linux

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
