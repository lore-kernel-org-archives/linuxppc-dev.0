Subject: Re: Error encountered when make of gcc-3.3.2
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Thamarai Selvan <Thamarai.Selvan@lntinfotech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <OF4C3019EA.ACB29788-ON65256E31.0024D5FB@lntinfotech.com>
References: <OF4C3019EA.ACB29788-ON65256E31.0024D5FB@lntinfotech.com>
Content-Type: multipart/mixed; boundary="=-7oTZi3IjWhqzxbV3c7mr"
Message-Id: <1075971443.8546.5.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Thu, 05 Feb 2004 09:57:23 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-7oTZi3IjWhqzxbV3c7mr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thamarai,

you need some patches to cross build gcc 3.x, but better
use crosstool, it includes the patches needed, both
for the compiler and glibc, and a script to build and
install everything.

http://www.kegel.com/crosstool/

Jaap-Jan

On Thu, 2004-02-05 at 07:46, Thamarai Selvan wrote:
> hi all,
>
> i am currently building my toolchain for powerpc i encountered the
> following error during "MAKE"
> could anyone help me out in this regard
>
> Thanks in advance
>
>  ERROR
> ------------
> if [ -f stmp-dirs ]; then true; else touch stmp-dirs; fi
> /root/Thamarai/gcc-3.3.2/gcc/xgcc -B/root/Thamarai/gcc-3.3.2/gcc/
> -B/usr/local/powerpc-linux/bin/ -B
> /usr/local/powerpc-linux/lib/ -isystem /usr/local/powerpc-linux/include -O2
> -DIN_GCC -DCROSS_COMPIL
> E   -W -Wall -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes
> -isystem ./include  -fPIC -g
> -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc -I. -I. -I. -I./.
> -I./config -I./../include  -f
> PIC -mstrict-align -DL_muldi3 -c ./libgcc2.c -o libgcc/./_muldi3.o
> In file included from tconfig.h:22,
>                  from libgcc2.c:36:
> config/rs6000/linux.h:89:20: signal.h: No such file or directory
> In file included from tconfig.h:22,
>                  from libgcc2.c:36:
> config/rs6000/linux.h:98: error: parse error before "stack_t"
> config/rs6000/linux.h:98: warning: no semicolon at end of struct or union
> config/rs6000/linux.h:100: error: parse error before "uc_sigmask"
> config/rs6000/linux.h:100: warning: type defaults to `int' in declaration
> of `uc_sigmask'
> config/rs6000/linux.h:100: warning: data definition has no type or storage
> class
> config/rs6000/linux.h:99: error: storage size of `uc_mcontext' isn't known
> make[2]: *** [libgcc/./_muldi3.o] Error 1
> make[2]: Leaving directory `/root/Thamarai/gcc-3.3.2/gcc'
> make[1]: *** [stmp-multilib] Error 2
> make[1]: Leaving directory `/root/Thamarai/gcc-3.3.2/gcc'
> make: *** [all-gcc] Error 2
>
>  With Regards,
>  Thamarai Selvan.G
>  (:  91-22-27612571, 27621100 X 4115
> ________________________________________________________
>
>  "Life - endless river of dreams, smiles in the portray of an artist"
> - Thams
>
>

--=-7oTZi3IjWhqzxbV3c7mr
Content-Disposition: attachment; filename=gcc-3.3.1-crossppc.diff
Content-Type: text/plain; name=gcc-3.3.1-crossppc.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- gcc-3.3.1/gcc/config/rs6000/linux.h.orig	2003-08-26 10:14:17.000000000 -0500
+++ gcc-3.3.1/gcc/config/rs6000/linux.h	2003-08-26 10:22:25.000000000 -0500
@@ -83,82 +83,7 @@
    state data appropriately.  See unwind-dw2.c for the structs.  */

 #ifdef IN_LIBGCC2
-#include <signal.h>
-
-/* During the 2.5 kernel series the kernel ucontext was changed, but
-   the new layout is compatible with the old one, so we just define
-   and use the old one here for simplicity and compatibility.  */
-
-struct kernel_old_ucontext {
-  unsigned long     uc_flags;
-  struct ucontext  *uc_link;
-  stack_t           uc_stack;
-  struct sigcontext_struct uc_mcontext;
-  sigset_t          uc_sigmask;
-};

 enum { SIGNAL_FRAMESIZE = 64 };
 #endif

-#define MD_FALLBACK_FRAME_STATE_FOR(CONTEXT, FS, SUCCESS)		\
-  do {									\
-    unsigned char *pc_ = (CONTEXT)->ra;					\
-    struct sigcontext *sc_;						\
-    long new_cfa_;							\
-    int i_;								\
-									\
-    /* li r0, 0x7777; sc  (sigreturn old)  */				\
-    /* li r0, 0x0077; sc  (sigreturn new)  */				\
-    /* li r0, 0x6666; sc  (rt_sigreturn old)  */			\
-    /* li r0, 0x00AC; sc  (rt_sigreturn new)  */			\
-    if (*(unsigned int *) (pc_+4) != 0x44000002)			\
-      break;								\
-    if (*(unsigned int *) (pc_+0) == 0x38007777				\
-	|| *(unsigned int *) (pc_+0) == 0x38000077)			\
-      {									\
-	struct sigframe {						\
-	  char gap[SIGNAL_FRAMESIZE];					\
-	  struct sigcontext sigctx;					\
-	} *rt_ = (CONTEXT)->cfa;					\
-	sc_ = &rt_->sigctx;						\
-      }									\
-    else if (*(unsigned int *) (pc_+0) == 0x38006666			\
-	     || *(unsigned int *) (pc_+0) == 0x380000AC)		\
-      {									\
-	struct rt_sigframe {						\
-	  char gap[SIGNAL_FRAMESIZE];					\
-	  unsigned long _unused[2];					\
-	  struct siginfo *pinfo;					\
-	  void *puc;							\
-	  struct siginfo info;						\
-	  struct kernel_old_ucontext uc;				\
-	} *rt_ = (CONTEXT)->cfa;					\
-	sc_ = &rt_->uc.uc_mcontext;					\
-      }									\
-    else								\
-      break;								\
-    									\
-    new_cfa_ = sc_->regs->gpr[STACK_POINTER_REGNUM];			\
-    (FS)->cfa_how = CFA_REG_OFFSET;					\
-    (FS)->cfa_reg = STACK_POINTER_REGNUM;				\
-    (FS)->cfa_offset = new_cfa_ - (long) (CONTEXT)->cfa;		\
-    									\
-    for (i_ = 0; i_ < 32; i_++)						\
-      if (i_ != STACK_POINTER_REGNUM)					\
-	{	    							\
-	  (FS)->regs.reg[i_].how = REG_SAVED_OFFSET;			\
-	  (FS)->regs.reg[i_].loc.offset 				\
-	    = (long)&(sc_->regs->gpr[i_]) - new_cfa_;			\
-	}								\
-									\
-    (FS)->regs.reg[LINK_REGISTER_REGNUM].how = REG_SAVED_OFFSET;	\
-    (FS)->regs.reg[LINK_REGISTER_REGNUM].loc.offset 			\
-      = (long)&(sc_->regs->link) - new_cfa_;				\
-									\
-    (FS)->regs.reg[CR0_REGNO].how = REG_SAVED_OFFSET;			\
-    (FS)->regs.reg[CR0_REGNO].loc.offset 				\
-      = (long)&(sc_->regs->nip) - new_cfa_;				\
-    (FS)->retaddr_column = CR0_REGNO;					\
-    goto SUCCESS;							\
-  } while (0)
-

--=-7oTZi3IjWhqzxbV3c7mr--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
