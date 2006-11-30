Return-Path: <urwithsudheer@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 81C7467BAC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Nov 2006 15:33:13 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1794217ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Nov 2006 20:33:11 -0800 (PST)
Message-ID: <12c9fc1a0611292033p1c0ae010iadcf6afdd4a549ce@mail.gmail.com>
Date: Thu, 30 Nov 2006 10:03:11 +0530
From: "Anumolu Sudheer" <urwithsudheer@gmail.com>
To: kernelnewbies@nl.linux.org
Subject: Re: regarding kgdb in ppc
In-Reply-To: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7092_4038966.1164861191174"
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>
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

------=_Part_7092_4038966.1164861191174
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,
As i was not able to do  kgdb with  ppc as target, i decided to try first
with two x86 PCs. On the target system  after uncompressing the kernel i
could not see any statement like  "Waiting for connection from remote gdb".
I think this is to be done by gdbserver on the target.
I compiled the gdbserver but don't know how to use it here along with the
target kernel. Can anyone give some tips how to do it or if am missing
something .
I followed the docs - kgdb_docu_full-2.4.pdf and kgdbquickstart-2.4.pdf
Host:  x86,  RHEL-2.6.9-34.EL
Target Linux- 2.6.15.5 <http://2.6.16.2/>
The kgdb version : linux-2.6.15.5-kgdb-2.4

Please let me know if any other details required.


Thanks
Sudheer

On 11/28/06, Anumolu Sudheer <urwithsudheer@gmail.com> wrote:
>
> Hello All
> I am in process of learning kgdb and facing some problem with gdbserver. I
> am not able to "configure and make"   the gdbserver .  Sorry fot the long
> mail.
>
> Did anyone tried to compile the KGDB with this powerpc-eabi ?? Please help me in solving this.
>
> Setup datails are below..
> Host:  x86,  RHEL-2.6.9-34.EL
> Target Linux- 2.6.16.2
> Target Processor: AMCC440SPe
> The kgdb version : linux-2.6.15.5-kgdb-2.4
> GDB  version gdb-6.4-kgdb-2.4.tar.bz2
> CrossCompiler - powerpc-eabi
>
> I applied the patch to the kernel and cross compiled it.(modified to solve
> the compilation errors  as is not supported readymade).
>
> I used the steps given in "http://www.kegel.com/linux/gdbserver.txt " to
> build the gdb.
>
> I compiled the gdb for host with  following commands
>
> #ls
> gdb-6.4  gdb-6.4-kgdb-2.4.tar.bz2
>
> #mkdir ppc440
> #cd ppc440
> #/bin/sh ../gdb-6.4/configure --target=powerpc-eabi --with-solib-absolute-prefix=/opt/ppc440
> #make
> #cd ..
>
> For gdbserver, if i give the "--target=powerpc-eabi" to "configure" script,  it says the target
>
> is not supported by gdbserver and if i give "--target=powerpc-linux", it doesnt show any error
> but its output doesn't look fine .  But when i do make. i get many errors saying many files
> are not found.  (Adding few required header files didnt help.)
>
>
> I cross compiled the gdbserver with following commands:
>
> [root@localhost gdb]# mkdir cross-ppc440
> [root@localhost gdb]# ls
> cross-ppc440  gdb-6.4  gdb-6.4-kgdb-2.4.tar.bz2  ppc440
> [root@localhost
>
>
>  gdb]# cd cross-ppc440/
> [root@localhost cross-ppc440]#
> [root@localhost cross-ppc440]# export CC=/usr/local/powerpc-eabi/bin/
> [root@localhost cross-ppc440]# export CFLAGS="-mcpu=405 -D__PPC405__ -msim"
>
>
>
> [root@localhost cross-ppc440]# export ac_cv_func_mmap_fixed_mapped=yes
>
> [root@localhost cross-ppc440]# /bin/sh ../gdb-6.4/gdb/gdbserver/configure --target=powerpc-eabi --host=i386
>
> configure: WARNING: If you wanted to set the --build type, don't use
> --host.
>     If a cross compiler is detected then cross compile mode will be used.
> checking for i386-gcc... /usr/local/powerpc-eabi/bin /powerpc-eabi-gcc
> checking for C compiler default output file name... a.out
> checking whether the C compiler works... yes
> checking whether we are cross compiling... yes
> checking for suffix of executables...
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc accepts
> -g... yes
> checking for /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc option to accept
> ANSI C... none needed
> checking build system type... i686-pc-linux-gnulibc1
> checking host system type... i386-pc-none
> checking target system type... powerpc-unknown-eabi
> checking for a BSD-compatible install... /usr/bin/install -c
> checking how to run the C preprocessor...
> /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc -E
> checking for egrep... grep -E
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... no
> checking for strings.h... no
> checking for inttypes.h... no
> checking for stdint.h... no
> checking for unistd.h... yes
> checking sgtty.h usability... no
> checking sgtty.h presence... no
> checking for sgtty.h... no
> checking termio.h usability... no
> checking termio.h presence... no
> checking for termio.h... no
> checking termios.h usability... no
> checking termios.h presence... no
> checking for termios.h... no
> checking sys/reg.h usability... no
> checking sys/reg.h presence... no
> checking for sys/reg.h... no
> checking for string.h... (cached) yes
> checking proc_service.h usability... no
> checking proc_service.h presence... no
> checking for proc_service.h... no
> checking sys/procfs.h usability... no
> checking sys/procfs.h presence... no
> checking for sys/procfs.h... no
> checking thread_db.h usability... no
> checking thread_db.h presence... no
> checking for thread_db.h... no
> checking linux/elf.h usability... no
> checking linux/elf.h presence... no
> checking for linux/elf.h... no
> checking for stdlib.h... (cached) yes
> checking for unistd.h... (cached) yes
> checking whether strerror is declared... yes
> checking for socklen_t... no
> Error: target not supported by gdbserver.
> [root@localhost cross-ppc440]#
> [root@localhost cross-ppc440]# /bin/sh ../gdb-6.4/gdb/gdbserver/configure
> --target=powerpc-linux --host=i386
> configure: WARNING: If you wanted to set the --build type, don't use
> --host.
>     If a cross compiler is detected then cross compile mode will be used.
> checking for i386-gcc... /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc
> checking for C compiler default output file name... a.out
> checking whether the C compiler works... yes
> checking whether we are cross compiling... yes
> checking for suffix of executables...
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc accepts
> -g... yes
> checking for /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc option to accept
> ANSI C... none needed
> checking build system type... i686-pc-linux-gnulibc1
> checking host system type... i386-pc-none
> checking target system type... powerpc-unknown-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking how to run the C preprocessor...
> /usr/local/powerpc-eabi/bin/powerpc-eabi-gcc -E
> checking for egrep... grep -E
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... no
> checking for strings.h... no
> checking for inttypes.h... no
> checking for stdint.h... no
> checking for unistd.h... yes
> checking sgtty.h usability... no
> checking sgtty.h presence... no
> checking for sgtty.h... no
> checking termio.h usability... no
> checking termio.h presence... no
> checking for termio.h... no
> checking termios.h usability... no
> checking termios.h presence... no
> checking for termios.h... no
> checking sys/reg.h usability... no
> checking sys/reg.h presence... no
> checking for sys/reg.h... no
> checking for string.h... (cached) yes
> checking proc_service.h usability... no
> checking proc_service.h presence... no
> checking for proc_service.h... no
> checking sys/procfs.h usability... no
> checking sys/procfs.h presence... no
> checking for sys/procfs.h... no
> checking thread_db.h usability... no
> checking thread_db.h presence... no
> checking for thread_db.h... no
> checking linux/elf.h usability... no
> checking linux/elf.h presence... no
> checking for linux/elf.h... no
> checking for stdlib.h... (cached) yes
> checking for unistd.h... (cached) yes
> checking whether strerror is declared... yes
> checking for socklen_t... no
> checking for PTRACE_GETREGS... no
> checking for PTRACE_GETFPXREGS... no
> checking for libthread_db... no
> configure: WARNING: Could not find libthread_db.
> configure: WARNING: Disabling thread support in gdbserver.
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: creating config.h
> config.status: executing default commands
> [root@localhost cross-ppc440]# ls
> config.h  config.log  config.status  Makefile
> [root@localhost cross-ppc440]#
> [root@localhost cross-ppc440]#
>
> Please let me know if any details required.
>
> Thanks in advance
> Sudheer
>

------=_Part_7092_4038966.1164861191174
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,<br>
As i was not able to do&nbsp; kgdb with&nbsp; ppc as target, i decided
to try first with two x86 PCs. On the target system&nbsp; after
uncompressing the kernel i could not see any statement like&nbsp;
&quot;Waiting for connection from remote gdb&quot;. I think this is to be done by
gdbserver on the target.<br>
I compiled the gdbserver but don't know how to use it here along with
the target kernel. Can anyone give some tips how to do it or if am
missing something .<br>
I followed the docs - kgdb_docu_full-2.4.pdf and kgdbquickstart-2.4.pdf<br>



Host:&nbsp; x86,&nbsp; RHEL-2.6.9-34.EL<br>



Target Linux- <a href="http://2.6.16.2/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">2.6.15.5</a><br>
The kgdb version : linux-2.6.15.5-kgdb-2.4<br>
<br>
Please let me know if any other details required.<br>
<br>
<br>
Thanks<br>
Sudheer <br><br><div><span class="gmail_quote">On 11/28/06, <b class="gmail_sendername">Anumolu Sudheer</b> &lt;<a href="mailto:urwithsudheer@gmail.com">urwithsudheer@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
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
<br><br>is not supported by gdbserver and if i give &quot;--target=powerpc-linux&quot;, it doesnt show any error <br>but its output doesn't look fine .  But when i do make. i get many errors saying many files <br>are not found.  (Adding few required header files didnt help.)
<br><br><br>I cross compiled the gdbserver with following commands:<br><br>[root@localhost gdb]# mkdir cross-ppc440<br>[root@localhost gdb]# ls<br>cross-ppc440  gdb-6.4  gdb-6.4-kgdb-2.4.tar.bz2  ppc440<br>[root@localhost
<br><br><br> gdb]# cd cross-ppc440/<br>[root@localhost cross-ppc440]#<br>[root@localhost cross-ppc440]# export CC=/usr/local/powerpc-eabi/bin/<br>[root@localhost cross-ppc440]# export CFLAGS=&quot;-mcpu=405 -D__PPC405__ -msim&quot;
<br><br><br><br>[root@localhost cross-ppc440]# export ac_cv_func_mmap_fixed_mapped=yes<br><br>[root@localhost cross-ppc440]# /bin/sh ../gdb-6.4/gdb/gdbserver/configure --target=powerpc-eabi --host=i386<br></pre>


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

</blockquote></div><br>

------=_Part_7092_4038966.1164861191174--
