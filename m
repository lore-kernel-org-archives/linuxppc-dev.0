From: tom_gall@vnet.ibm.com
Message-ID: <39807576.3F77B13A@vnet.ibm.com>
Date: Thu, 27 Jul 2000 17:46:30 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: Martin Costabel <costabel@wanadoo.fr>
CC: linuxppc-dev@lists.linuxppc.org, dwayne@us.ibm.com
Subject: Re: modprobe and exec format error
References: <397F60D4.E5A417E6@vnet.ibm.com> <397F6686.20E2D953@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Martin,

Martin Costabel wrote:
>
> tom_gall@vnet.ibm.com wrote:
> >
> > Hi All,
> >
> >   Here's a strange one...
> >
> >   I'm bringing up a 2.4.0-testX kernel (Paul's latest PMac tree) and the kernel
> > does come up quite a ways (tho how far is a bit hard to tell as things scroll by
> > and scroll lock doesn't work)
>
> If you compile MagicSysRq support in, you can stop scrolling by
> "SysRq-0" (that is F13 + zero).
>
> > I get the following repeated item on my screen ... so imagine this line times N
> >
> > /sbin/modprobe -s -k binfmt_4c46 errno=8
> >
> > Well errno 8 is Exec format error as I recall...    time to upgrade modutils?
> >
> > Anyone with any suggestions or have seen this one before?
>
> Yeah, seen this before:
> http://lists.linuxppc.org/listarcs/linuxppc-dev/200007/msg00327.html
> and my solution:
> http://lists.linuxppc.org/listarcs/linuxppc-dev/200007/msg00345.html

Thanks much for the pointers.

I am experiencing this with Cort's current development kernel tree. Based on the
previous posting you had in theory all I needed to do was just grab a fresh
kernel which I did this morning. The same problem surfaced. So something is
definately wrong with the Cort's 2.4.0-test5 tree.

I took a gander at elf.h. The only change I see is



2.3.99-pre9

#define elf_check_arch(x) ((x) == EM_PPC)

2.4.0-test5-Cort

#define elf_check_arch(x) ((x)->e_machine == EM_PPC)

This appearantly is used 3 times fs/binfmt_elf.c

2.3.99-pre9

if (!elf_check_arch(interp_elf_ex->e_machine))

2.4.0-test5-Cort

if (!elf_check_arch(&elf_ex))

So while the code changed it would appear to be consistant at least....

Guess I'll have to keep digging!

> I'm curious what your reason was for getting this.

Me too!

Regards,

Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
