Message-Id: <v03110700b4298a016f5d@[209.183.131.16]>
In-Reply-To: <99101300580600.00880@ns1102.munich.netsurf.de>
References: <3803A7BC.4175E431@arcormail.de>
 <3803A7BC.4175E431@arcormail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 12 Oct 1999 21:04:32 -0400
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Michael Fenske <michael.fenske@arcormail.de>,
        linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Problem with glibc-2.1.3-0a.src.rpm ?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I got the same error when I rebuilt Franz's glibc 2.1.2-7b src rpm.

Here is what I did in an attempt to fix it, and sure enough something here
worked (but I am not sure how or why? yet!).

1. goto /usr/lib/gcc-lib and search downwards and remove all of the old
egcs subdirectories hanging around (just leave the latest gcc ones from
Franz's gcc-2.95.1

2. add a symbolic link
   ln -s 2.95.1 gcc-2.95.1

>From that point on, everything started working again.  The damn configure
script was returning 2.95.1 but not gcc or egcs so it didn't find a match.

I hope this works for you.

Kevin


At 12:53 AM +0200 10/13/99, Franz Sirl wrote:
>Am Die, 12 Okt 1999 schrieb Michael Fenske:
>>Hi,
>>
>>can anyone explain me the following output ?
>>
>>+ ../configure --prefix=/usr --enable-add-ons=yes --without-cvs
>>ppc-redhat-linux
>>creating cache ./config.cache
>>checking host system type... powerpc-redhat-linux-gnu
>>checking sysdep dirs... sysdeps/powerpc/elf crypt/sysdeps/unix
>>linuxthreads/sysdeps/unix/sysv/linux linuxthreads/sysdeps/pthread
>>linuxthreads/sysdeps/unix/sysv
>>linuxthreads/sysdeps/unix linuxthreads/sysdeps/powerpc
>>sysdeps/unix/sysv/linux/powerpc sysdeps/unix/sysv/linux sysdeps/gnu
>>sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/inet
>>sysdeps/unix/sysv sysdeps/unix sysdeps/posix sysdeps/powerpc
>>sysdeps/wordsize-32 sysdeps/ieee754 sysdeps/libm-ieee754
>>sysdeps/generic/elf sysdeps/generic
>>checking for a BSD compatible install... /usr/bin/install -c
>>checking whether ln -s works... yes
>>checking build system type... powerpc-redhat-linux-gnu
>>checking for gcc... egcs
>>checking version of egcs... v. ?.??, bad
>>checking for make... make
>>checking version of make... 3.77, ok
>>checking for msgfmt... msgfmt
>>checking version of msgfmt... 0.10.35, ok
>>checking for makeinfo... makeinfo
>>checking version of makeinfo... 3.12, ok
>>configure: error:
>>*** Some critical program is missing or too old.
>>*** Check the INSTALL file for required versions.
>>Bad exit status from /var/tmp/rpm-tmp.55764 (%build)
>>
>>I get this if I do a 'rpm --rebuild glibc-2.1.3-0a.src.rpm'
>>
>>What I don't understand is that the configure-script insists that I have
>>egcs installed, but I definitely have gcc-2.95.1 installed.
>
>Did you install all parts of gcc-2.95.1? cpp is easily forgotten. What output
>do you get from 'egcs -v' and 'gcc -v'?
>
>Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
