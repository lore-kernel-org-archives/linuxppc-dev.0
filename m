Message-ID: <399A6578.906706B5@apus.co.at>
Date: Wed, 16 Aug 2000 11:57:12 +0200
From: Rene Pachernegg <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: syscall adressing problem
References: <200008101623.SAA11915@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> In message <3992D331.21C3BD9C@apus.co.at> you wrote:
> >
> > Further searching leaded to the following:
> >     Sometimes fopen or open syscall work well
> >     Whenever they dont work they are call from the libc.so and the
> > filename paramter adresses are 0x0fxxxxxx.
>
> I've seen very similar problems,  but  on  MPC8xx  system  with  more
> current  kernels.  The  reason  was a change in arch/ppc/lib/string.S
> which completely f*cked up the caches (ok - the  MPC8xx  have  smalle
> cache line sizes).
>

Thanks for the quick answer.

My cache line size is the standard 32 byte. As I found in older messages
from the mailing list, these string.S problems concern only unusual cache
line sizes.
Anyway I got the 2.2.6 and the 2.2.13 kernel sources and gave it a try
--> no success.
Then I tried to replace the copy_from_user in sys_open with my own
read_through (flushes cache first, then reads memory) function.  --> no
success.
Actually the strings to be passed to the syscall are readable from
everywhere in user space, but in kernel space it reads just trash at the
same adress.
There are (just my opinion) only two possibilities:
    an adress translation problem in the kernel for adresses < 0x10000000

   something is overwriting the memory space of the string - parameters
for sys_open

regards
    Rene


>
> Try (1) disabling caches; and (2) arch/ppc/lib/string.S from an older
> (2.2.13) kernel version.
>
> It's just a guess, but maybe worth a try.
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> In an infinite universe all things are possible, including the possi-
> bility that the universe does not exist.
>                         - Terry Pratchett, _The Dark Side of the Sun_


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
