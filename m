Return-Path: <urwithsudheer@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id C358667C08
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Nov 2006 03:20:25 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1338373ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 08:20:23 -0800 (PST)
Message-ID: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>
Date: Tue, 28 Nov 2006 21:50:21 +0530
From: "Anumolu Sudheer" <urwithsudheer@gmail.com>
To: kernelnewbies@nl.linux.org
Subject: regarding kgdb in ppc
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15965_8947180.1164730821634"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_15965_8947180.1164730821634
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All
I am in process of learning kgdb and facing some problem with gdbserver. I
am not able to "configure and make"   the gdbserver .  Sorry fot the long
mail.

Did anyone tried to compile the KGDB with this powerpc-eabi ?? Please
help me in solving this.

Setup datails are below..
Host:  x86,  RHEL-2.6.9-34.EL
Target Linux- 2.6.16.2
Target Processor: AMCC440SPe
The kgdb version : linux-2.6.15.5-kgdb-2.4
GDB  version gdb-6.4-kgdb-2.4.tar.bz2
CrossCompiler - powerpc-eabi

I applied the patch to the kernel and cross compiled it.(modified to solve
the compilation errors  as is not supported readymade).

I used the steps given in "http://www.kegel.com/linux/gdbserver.txt " to
build the gdb.

I compiled the gdb for host with  following commands

#ls
gdb-6.4  gdb-6.4-kgdb-2.4.tar.bz2

#mkdir ppc440
#cd ppc440
#/bin/sh ../gdb-6.4/configure --target=powerpc-eabi
--with-solib-absolute-prefix=/opt/ppc440
#make
#cd ..

For gdbserver, if i give the "--target=powerpc-eabi" to "configure"
script,  it says the target
is not supported by gdbserver and if i give "--target=powerpc-linux",
it doesnt show any error
but its output doesn't look fine .  But when i do make. i get many
errors saying many files
are not found.  (Adding few required header files didnt help.)

I cross compiled the gdbserver with following commands:

[root@localhost gdb]# mkdir cross-ppc440
[root@localhost gdb]# ls
cross-ppc440  gdb-6.4  gdb-6.4-kgdb-2.4.tar.bz2  ppc440
[root@localhost

 gdb]# cd cross-ppc440/
[root@localhost cross-ppc440]#
[root@localhost cross-ppc440]# export CC=/usr/local/powerpc-eabi/bin/
[root@localhost cross-ppc440]# export CFLAGS="-mcpu=405 -D__PPC405__ -msim"


[root@localhost cross-ppc440]# export ac_cv_func_mmap_fixed_mapped=yes

[root@localhost cross-ppc440]# /bin/sh
../gdb-6.4/gdb/gdbserver/configure --target=powerpc-eabi --host=i386

configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for i386-gcc... /usr/local/powerpc-eabi/bin /powerpc-eabi-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc accepts -g...
yes
checking for /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc option to accept
ANSI C... none needed
checking build system type... i686-pc-linux-gnulibc1
checking host system type... i386-pc-none
checking target system type... powerpc-unknown-eabi
checking for a BSD-compatible install... /usr/bin/install -c
checking how to run the C preprocessor...
/usr/local/powerpc-eabi/bin/powerpc-eabi-gcc -E
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... no
checking for strings.h... no
checking for inttypes.h... no
checking for stdint.h... no
checking for unistd.h... yes
checking sgtty.h usability... no
checking sgtty.h presence... no
checking for sgtty.h... no
checking termio.h usability... no
checking termio.h presence... no
checking for termio.h... no
checking termios.h usability... no
checking termios.h presence... no
checking for termios.h... no
checking sys/reg.h usability... no
checking sys/reg.h presence... no
checking for sys/reg.h... no
checking for string.h... (cached) yes
checking proc_service.h usability... no
checking proc_service.h presence... no
checking for proc_service.h... no
checking sys/procfs.h usability... no
checking sys/procfs.h presence... no
checking for sys/procfs.h... no
checking thread_db.h usability... no
checking thread_db.h presence... no
checking for thread_db.h... no
checking linux/elf.h usability... no
checking linux/elf.h presence... no
checking for linux/elf.h... no
checking for stdlib.h... (cached) yes
checking for unistd.h... (cached) yes
checking whether strerror is declared... yes
checking for socklen_t... no
Error: target not supported by gdbserver.
[root@localhost cross-ppc440]#
[root@localhost cross-ppc440]# /bin/sh ../gdb-6.4/gdb/gdbserver/configure
--target=powerpc-linux --host=i386
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for i386-gcc... /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc accepts -g...
yes
checking for /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc option to accept
ANSI C... none needed
checking build system type... i686-pc-linux-gnulibc1
checking host system type... i386-pc-none
checking target system type... powerpc-unknown-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking how to run the C preprocessor...
/usr/local/powerpc-eabi/bin/powerpc-eabi-gcc -E
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... no
checking for strings.h... no
checking for inttypes.h... no
checking for stdint.h... no
checking for unistd.h... yes
checking sgtty.h usability... no
checking sgtty.h presence... no
checking for sgtty.h... no
checking termio.h usability... no
checking termio.h presence... no
checking for termio.h... no
checking termios.h usability... no
checking termios.h presence... no
checking for termios.h... no
checking sys/reg.h usability... no
checking sys/reg.h presence... no
checking for sys/reg.h... no
checking for string.h... (cached) yes
checking proc_service.h usability... no
checking proc_service.h presence... no
checking for proc_service.h... no
checking sys/procfs.h usability... no
checking sys/procfs.h presence... no
checking for sys/procfs.h... no
checking thread_db.h usability... no
checking thread_db.h presence... no
checking for thread_db.h... no
checking linux/elf.h usability... no
checking linux/elf.h presence... no
checking for linux/elf.h... no
checking for stdlib.h... (cached) yes
checking for unistd.h... (cached) yes
checking whether strerror is declared... yes
checking for socklen_t... no
checking for PTRACE_GETREGS... no
checking for PTRACE_GETFPXREGS... no
checking for libthread_db... no
configure: WARNING: Could not find libthread_db.
configure: WARNING: Disabling thread support in gdbserver.
configure: creating ./config.status
config.status: creating Makefile
config.status: creating config.h
config.status: executing default commands
[root@localhost cross-ppc440]# ls
config.h  config.log  config.status  Makefile
[root@localhost cross-ppc440]#
[root@localhost cross-ppc440]#

Please let me know if any details required.

Thanks in advance
Sudheer

------=_Part_15965_8947180.1164730821634
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All<br>


I am in process of learning kgdb and facing some problem with
gdbserver. I am not able to &quot;configure and make&quot; &nbsp; the gdbserver .&nbsp;  Sorry fot the long mail.<br>


<pre>Did anyone tried to compile the KGDB with this powerpc-eabi ?? Please help me in solving this.</pre>

Setup datails are below..<br>


Host:&nbsp; x86,&nbsp; RHEL-2.6.9-34.EL<br>


Target Linux- <a href="http://2.6.16.2/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">2.6.16.2</a><br>


Target Processor: AMCC440SPe<br>


The kgdb version : linux-2.6.15.5-kgdb-2.4 <br>

GDB&nbsp; version gdb-6.4-kgdb-2.4.tar.bz2<br>


CrossCompiler - powerpc-eabi<br>
<br>

<span style="font-family: monospace;"></span>I applied the patch to the
kernel and cross compiled it.(modified to solve the compilation
errors&nbsp; as is not supported readymade).<br>

<br>

I used the steps given in &quot;<a href="http://www.kegel.com/linux/gdbserver.txt" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.kegel.com/linux/gdbserver.txt</a> &quot; to build the gdb.
<br>
<br>
I compiled the gdb for host with&nbsp; following commands<br>


<br>


#ls<br>


gdb-6.4&nbsp; gdb-6.4-kgdb-2.4.tar.bz2<br>


<pre>#mkdir ppc440<br>#cd ppc440<br>#/bin/sh ../gdb-6.4/configure --target=powerpc-eabi --with-solib-absolute-prefix=/opt/ppc440<br>#make<br>#cd ..<br><br>For gdbserver, if i give the &quot;--target=powerpc-eabi&quot; to &quot;configure&quot; script,  it says the target 
<br>is not supported by gdbserver and if i give &quot;--target=powerpc-linux&quot;, it doesnt show any error <br>but its output doesn't look fine .  But when i do make. i get many errors saying many files <br>are not found.  (Adding few required header files didnt help.)
<br><br>I cross compiled the gdbserver with following commands:<br><br>[root@localhost gdb]# mkdir cross-ppc440<br>[root@localhost gdb]# ls<br>cross-ppc440  gdb-6.4  gdb-6.4-kgdb-2.4.tar.bz2  ppc440<br>[root@localhost<br>
<br> gdb]# cd cross-ppc440/<br>[root@localhost cross-ppc440]#<br>[root@localhost cross-ppc440]# export CC=/usr/local/powerpc-eabi/bin/<br>[root@localhost cross-ppc440]# export CFLAGS=&quot;-mcpu=405 -D__PPC405__ -msim&quot;
<br><br><br>[root@localhost cross-ppc440]# export ac_cv_func_mmap_fixed_mapped=yes<br><br>[root@localhost cross-ppc440]# /bin/sh ../gdb-6.4/gdb/gdbserver/configure --target=powerpc-eabi --host=i386<br></pre>


configure: WARNING: If you wanted to set the --build type, don't use --host.<br>

&nbsp;&nbsp;&nbsp; If a cross compiler is detected then cross compile mode will be used.<br>

checking for i386-gcc... /usr/local/powerpc-eabi/bin
<div>/powerpc-eabi-gcc<br>
checking for C compiler default output file name... a.out<br>
checking whether the C compiler works... yes<br>
checking whether we are cross compiling... yes<br>
checking for suffix of executables...<br>
checking for suffix of object files... o<br>
checking whether we are using the GNU C compiler... yes<br>
checking whether /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc accepts -g... yes<br>
checking for /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc option to accept ANSI C... none needed<br>
checking build system type... i686-pc-linux-gnulibc1<br>
checking host system type... i386-pc-none<br>
checking target system type... powerpc-unknown-eabi<br>
checking for a BSD-compatible install... /usr/bin/install -c<br>
checking how to run the C preprocessor... /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc -E<br>
checking for egrep... grep -E<br>
checking for ANSI C header files... yes<br>
checking for sys/types.h... yes<br>
checking for sys/stat.h... yes<br>
checking for stdlib.h... yes<br>
checking for string.h... yes<br>
checking for memory.h... no<br>
checking for strings.h... no<br>
checking for inttypes.h... no<br>
checking for stdint.h... no<br>
checking for unistd.h... yes<br>
checking sgtty.h usability... no<br>
checking sgtty.h presence... no<br>
checking for sgtty.h... no<br>
checking termio.h usability... no<br>
checking termio.h presence... no<br>
checking for termio.h... no<br>
checking termios.h usability... no<br>
checking termios.h presence... no<br>
checking for termios.h... no<br>
checking sys/reg.h usability... no<br>
checking sys/reg.h presence... no<br>
checking for sys/reg.h... no<br>
checking for string.h... (cached) yes<br>
checking proc_service.h usability... no<br>
checking proc_service.h presence... no<br>
checking for proc_service.h... no<br>
checking sys/procfs.h usability... no<br>
checking sys/procfs.h presence... no<br>
checking for sys/procfs.h... no<br>
checking thread_db.h usability... no<br>
checking thread_db.h presence... no<br>
checking for thread_db.h... no<br>
checking linux/elf.h usability... no<br>
checking linux/elf.h presence... no<br>
checking for linux/elf.h... no<br>
checking for stdlib.h... (cached) yes<br>
checking for unistd.h... (cached) yes<br>
checking whether strerror is declared... yes<br>
checking for socklen_t... no<br>
Error: target not supported by gdbserver.<br>
[root@localhost cross-ppc440]#<br>[root@localhost cross-ppc440]# /bin/sh
../gdb-6.4/gdb/gdbserver/configure --target=powerpc-linux --host=i386<br>
configure: WARNING: If you wanted to set the --build type, don't use --host.<br>
&nbsp;&nbsp;&nbsp; If a cross compiler is detected then cross compile mode will be used.<br>
checking for i386-gcc... /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc<br>
checking for C compiler default output file name... a.out<br>
checking whether the C compiler works... yes<br>
checking whether we are cross compiling... yes<br>
checking for suffix of executables...<br>
checking for suffix of object files... o<br>
checking whether we are using the GNU C compiler... yes<br>
checking whether /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc accepts -g... yes<br>
checking for /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc option to accept ANSI C... none needed<br>
checking build system type... i686-pc-linux-gnulibc1<br>
checking host system type... i386-pc-none<br>
checking target system type... powerpc-unknown-linux-gnu<br>
checking for a BSD-compatible install... /usr/bin/install -c<br>
checking how to run the C preprocessor... /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc -E<br>
checking for egrep... grep -E<br>
checking for ANSI C header files... yes<br>
checking for sys/types.h... yes<br>
checking for sys/stat.h... yes<br>
checking for stdlib.h... yes<br>
checking for string.h... yes<br>
checking for memory.h... no<br>
checking for strings.h... no<br>
checking for inttypes.h... no<br>
checking for stdint.h... no<br>
checking for unistd.h... yes<br>
checking sgtty.h usability... no<br>
checking sgtty.h presence... no<br>
checking for sgtty.h... no<br>
checking termio.h usability... no<br>
checking termio.h presence... no<br>
checking for termio.h... no<br>
checking termios.h usability... no<br>
checking termios.h presence... no<br>
checking for termios.h... no<br>
checking sys/reg.h usability... no<br>
checking sys/reg.h presence... no<br>
checking for sys/reg.h... no<br>
checking for string.h... (cached) yes<br>
checking proc_service.h usability... no<br>
checking proc_service.h presence... no<br>
checking for proc_service.h... no<br>
checking sys/procfs.h usability... no<br>
checking sys/procfs.h presence... no<br>
checking for sys/procfs.h... no<br>
checking thread_db.h usability... no<br>
checking thread_db.h presence... no<br>
checking for thread_db.h... no<br>
checking linux/elf.h usability... no<br>
checking linux/elf.h presence... no<br>
checking for linux/elf.h... no<br>
checking for stdlib.h... (cached) yes<br>
checking for unistd.h... (cached) yes<br>
checking whether strerror is declared... yes<br>
checking for socklen_t... no<br>
checking for PTRACE_GETREGS... no<br>
checking for PTRACE_GETFPXREGS... no<br>
checking for libthread_db... no<br>
configure: WARNING: Could not find libthread_db.<br>
configure: WARNING: Disabling thread support in gdbserver.<br>
configure: creating ./config.status<br>
config.status: creating Makefile<br>
config.status: creating config.h<br>
config.status: executing default commands<br>
[root@localhost cross-ppc440]# ls<br>
config.h&nbsp; config.log&nbsp; config.status&nbsp; Makefile<br>
[root@localhost cross-ppc440]#<br>
[root@localhost cross-ppc440]#<br>
<br>
Please let me know if any details required.<br>
<br>
Thanks in advance<br>
Sudheer</div>

------=_Part_15965_8947180.1164730821634--
