Date: Thu, 20 Jun 2002 15:09:05 +0900
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: tlbia and PPC603
References: <20020619201733E.ekato@ees.hokudai.ac.jp> <20020619031038.28719@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020619031038.28719@smtp.wanadoo.fr>
Message-Id: <20020620150906H.ekato@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thank you very much Ben,

On Wed, Jun 19, 2002 at 05:10:37AM +0200,
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Ok, after more investigations it appears that:
>
>  - There is no tlbia on 603. Actually, tlbia is #defined in the
> kernel to be a loop of tlbie's
>
>  - According to the PEM, tlbie requires a context synchronizing
> instruction _before_, and a context sync. or a plain "sync"
> instruction _after_. We did have the later but lacked the former
> in our _tlbia function (though we did have it in our _tlbie
> implementation).
>
> So the proper fix, according to the spec, would be to just replace
> the sync we currently do before with an isync. I've updated my rsync
> with such a fix, can you confirm it works ?

Before your advice, I did add isync just after both of two sync.
Without isync, almost always kernel crashes at the point of mounting
root file system or doing ifconfig at booting time.  But even with
this modification, the random crash still sometimes occurs, but the
probability seems to be decreased.  I tested this kernel with doing
boot, login, and connect by ssh from other machine 10 times, it
dropped to xmon 8 times, and worked fine 2 times.  Even dropped to
xmon, the system boot fine and works after typing 'x' at the >mon.

Oops messages are like this.

Oops: kernel access of bad area, sig: 11
NIP: C01B0CC0 XER: 00000000 LR: C001D0AC SP: C85D9EC0 REGS: c85d9e10 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 30017980, DSISR: 20000000
TASK = c85d8000[188] 'sysctl' Last syscall: 4
last math c85d8000 last altivec 00000000
GPR00: C01B0CBC C85D9EC0 C85D8000 C0239B6C 00000001 C8C979C0 30016000 C85D9EE8
GPR08: 00000000 00000000 C003B18C C85A3E00 4800288C 10019A5C 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 085D9F40 00000000 C0005ED4
GPR24: C0005C40 7FFFFBCC 00000000 30016000 00000002 C8C979C0 00000001 C0239B6C
Call backtrace:
C00287FC C001D078 C001D134 C003B254 C0005C9C 10000000 0FF1F6EC
0FF205C8 0FF1F044 0FF13C90 10000FC4 10000D48 10000978 0FEC8B90
00000000
Oops: Exception in kernel mode, sig: 4
NIP: C01B0CC4 XER: 00000000 LR: C001D0AC SP: C7FA9EC0 REGS: c7fa9e10 TRAP: 0700    Not tainted
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c7fa8000[509] 'S90firewall' Last syscall: 4
last math 00000000 last altivec 00000000
GPR00: C01B0CBC C7FA9EC0 C7FA8000 C0239B6C 00000001 C80495C0 100B1190 C7FA9EE8
GPR08: 00000000 00000000 C003B18C C85A3E00 48022880 100AD23C 00000000 00000000
GPR16: 100B5BF0 00000000 00000000 1005372C 00009032 07FA9F40 00000000 C0005ED4
GPR24: C0005C40 100A0000 00000001 100AF810 00000002 C80495C0 00000000 C0239B6C
Call backtrace:
0000000A C001D078 C001D134 C003B254 C0005C9C FFFFFFFF 0FED86EC
0FED8B74 0FEDAB70 0FED545C 100539BC 10022CD4 1002345C 10022994
1001F114 100206A4 1001F448 1001E998 10020628 1001F448 1001E998
10020628 1001F448 1001E998 10020628 1001F448 1001E998 10020628
1001F448 1001E998 10021984 1001F308 1001E998


I also tested your latest rsync tree.  With the same test, the kernel
also dropped to xmon 8 times, and worked stable 2 times.


Even the situation have improved with isync, I'm becoming not sure
about _tlbia is the problem.  Does anyone know other things causing
problem on PPC603 Macintosh??

I tested this on UMAX C500 (144M RAM, 240MHz 603ev, DEC21140 ether card).

Thank you,
--
Etsushi Kato
ekato@ees.hokudai.ac.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
