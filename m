In-Reply-To: <19990723144647.023789>
Date: Fri, 23 Jul 1999 14:53:09 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: vger 2.2.10 compile failures
Message-Id: <19990723145309.026628@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 23, 1999, Benjamin Herrenschmidt <bh40@calva.net> wrote:

>I'm getting link errors when compiling today's vger 2.2.10 with xmon support
>enabled:
>
>arch/ppc/xmon/x.o: In function `backtrace':
>arch/ppc/xmon/x.o(.text+0x129e): undefined reference to `ret_from_int'
>arch/ppc/xmon/x.o(.text+0x12a2): undefined reference to `ret_from_syscall_1'
>arch/ppc/xmon/x.o(.text+0x12a6): undefined reference to `ret_from_int'
>arch/ppc/xmon/x.o(.text+0x12aa): undefined reference to `ret_from_syscall_1'
>arch/ppc/xmon/x.o(.text+0x12ae): undefined reference to `ret_from_syscall_2'
>arch/ppc/xmon/x.o(.text+0x12b6): undefined reference to `ret_from_syscall_2'
>
>Apparently, the name of those symbols changed, I'll try to fix xmon here, but
>maybe someone already did it (Paul ?)

BTW. Here's the patch (it compiles, I beleive it works too but I didn't
test xmon yet):

diff -uNr linux.orig/arch/ppc/xmon/xmon.c linux/arch/ppc/xmon/xmon.c
--- linux.orig/arch/ppc/xmon/xmon.c     Thu Jul 22 22:12:16 1999
+++ linux/arch/ppc/xmon/xmon.c  Fri Jul 23 14:49:39 1999
@@ -472,7 +472,7 @@
        unsigned sp;
        unsigned stack[2];
        struct pt_regs regs;
-       extern char ret_from_int, ret_from_syscall_1, ret_from_syscall_2;
+       extern char int_return, syscall_ret_1, syscall_ret_2;
        extern char lost_irq_ret, do_bottom_half_ret, do_signal_ret;
 
        if (excp != NULL)
@@ -485,9 +485,9 @@
                if (mread(sp, stack, sizeof(stack)) != sizeof(stack))
                        break;
                printf("%x ", stack[1]);
-               if (stack[1] == (unsigned) &ret_from_int
-                   || stack[1] == (unsigned) &ret_from_syscall_1
-                   || stack[1] == (unsigned) &ret_from_syscall_2
+               if (stack[1] == (unsigned) &int_return
+                   || stack[1] == (unsigned) &syscall_ret_1
+                   || stack[1] == (unsigned) &syscall_ret_2
                    || stack[1] == (unsigned) &lost_irq_ret
                    || stack[1] == (unsigned) &do_bottom_half_ret
                    || stack[1] == (unsigned) &do_signal_ret) {


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
