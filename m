Date: Tue, 4 Apr 2000 10:29:15 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Graham Stoney <greyham@research.canon.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Question about PPC __put_user_asm/__get_user_asm
Message-ID: <20000404102915.A29825@drow.res.cmu.edu>
References: <20000404064015.6EEF2505F0@brixi.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000404064015.6EEF2505F0@brixi.research.canon.com.au>; from greyham@research.canon.com.au on Tue, Apr 04, 2000 at 04:40:14PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 04, 2000 at 04:40:14PM +1000, Graham Stoney wrote:
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

I can't tell you what those particular elements do, but I can tell you
that -ffunction-sections will most likely NOT produce a bootable
kernel.  It makes assumptions about the types of sections present - see
for instance the __initfunc() macro and its custom section.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
