Subject: Kernel 2.4.20: kgdb problem
To: linuxppc-dev@lists.linuxppc.org
From: "Frederic Maccotta" <frederic.maccotta@fr.ibm.com>
Date: Thu, 14 Aug 2003 09:34:30 +0200
Message-ID: <OF80DE9996.69682759-ONC1256D82.0028EF6B@megacenter.de.ibm.com>
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I experienced many problems trying to use ans set kgdb/gdb with a ppc
kernel 2.4.20. (Note: No problem with kgdb & kernel version 2.4.17)

I used gcc 3.2.1 to compile the kernel and gdb 5.2.1 as remote debugger.

I enabled kgdb feature and added "-g -ggdb -O" compile options running
make nenuconfig

 Problem: I first tried to compile kernel with "-fno-omit-frame-pointer"
but the compiled kernel was hanging somewhere in network init. I did not
have this problem with 2.4.17 version.

 Question-1: Is the frames pointer in a ppc kernel really mandatory to
allow debugging (as for i386 platform) ?

Problem: I did not succeed to disable optimization (-O0). In this case
the linker complains about unreferrenced inline functions.

Question-2: Does it exist a way to compile a ppc kernel without
optimization ?

Once the kernel is compiled with kgdb, I am able to establish a
connection with gdb, but the behavior of debugging operations (step one
instruction, continue up to <addr> ...) is really erratic.

I set to 1 the kdebug static var in pcc-stuc.c to enable tracing of data
exchanged between kgdb and gdb. I saw that after a step instruction the
kernel could completely loose its debug capabilities (no more signal are
driven to ppc_stub.c/handle_exception()).

It seems that the Debug infrastructure has been modified in 2.4.20
kernel. The dbcr0 debug register is now maintenained in "thread_struct"
structure instead of in "pt_regs" struct. Question-3: Is this change
sufficient to explain the problems I experienced (context switching
problem ?). If yes does it exist a patch to fix it ?

Thanks by advance

MACCOTTA Frédéric
Dept 0899    -    Location  :  B3-1E-214
IBM FRANCE    -    06610 LA GAUDE
Phone  :  04.92.11.47.22
E-Mail  :  frederic.maccotta@fr.ibm.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
