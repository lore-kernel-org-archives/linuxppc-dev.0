Date: Tue, 4 Apr 2000 13:35:34 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Graham Stoney <greyham@research.canon.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Question about PPC __put_user_asm/__get_user_asm
In-Reply-To: <20000404064015.6EEF2505F0@brixi.research.canon.com.au>
Message-ID: <Pine.HPX.4.10.10004041321080.21080-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 Apr 2000, Graham Stoney wrote:

>
> Hi there,
>
> I'm wondering if anyone can please point me to an explanation of the PCC
> implementations of __put_user_asm/__get_user_asm in include/asm-ppc/uaccess.h.
> In particular, I'm interested in the reason behind them changing .sections
> behind the compiler's back, and whether some better approach could be taken to
> achieve the same goal.
>
> The reason I'm asking is because I'm trying to use gcc's -ffunction-sections
> with ld's --gc-sections to eliminate dead code from my kernel link. This is
> proving difficult because the aforementioned macros explicitly change back to
> the .text section, which is incompatible with -ffunction-sections. I can hack
> the macros to change back to section ".text.__FUNCTION__", but this suffers
> from equivalent nastiness when -ffunction-sections isn't used.
>
> Can anyone explain what the .fixup and __ex_table stuff in __put_user_asm/
> __get_user_asm do?  I notice that other architectures don't require such
> trickery.

At least i386 does the same trick as Documentation/exception.txt explains.
But using .text explicitly is bad style in any case, you might want to
replace it by .previous like in this hand-built unified diff for the
__put_user_asm case:


		".section .fixup,\"ax\"\n"			\
		"3:     li %0,%3\n"				\
		"       b 2b\n"					\
+ 		".previous\n"					\
		".section __ex_table,\"a\"\n"			\
		"       .align 2\n"				\
		"       .long 1b,3b\n"				\
-		".text"						\
+ 		".previous"					\
                : "=r"(err)                                     \
                : "r"(x), "b"(addr), "i"(-EFAULT), "0"(err))

Caution: I don't claim it will solve all your problems: actually it will
still leave some remnants in the __ex_table and .fixup sectioons which
will be cause linker errors. But at least the code of the functions will
stay in the appropriate section. I've no idea on how to generate per
function __ex_table and fixup sections (actually I think it's the wrong
approach for 6xx/7xx/7xxx PPC for other reasons).

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
