Subject: Question about PPC __put_user_asm/__get_user_asm
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 4 Apr 2000 16:40:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000404064015.6EEF2505F0@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

I'm wondering if anyone can please point me to an explanation of the PCC
implementations of __put_user_asm/__get_user_asm in include/asm-ppc/uaccess.h.
In particular, I'm interested in the reason behind them changing .sections
behind the compiler's back, and whether some better approach could be taken to
achieve the same goal.

The reason I'm asking is because I'm trying to use gcc's -ffunction-sections
with ld's --gc-sections to eliminate dead code from my kernel link. This is
proving difficult because the aforementioned macros explicitly change back to
the .text section, which is incompatible with -ffunction-sections. I can hack
the macros to change back to section ".text.__FUNCTION__", but this suffers
from equivalent nastiness when -ffunction-sections isn't used.

Can anyone explain what the .fixup and __ex_table stuff in __put_user_asm/
__get_user_asm do?  I notice that other architectures don't require such
trickery.

thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
