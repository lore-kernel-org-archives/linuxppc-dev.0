Date: Thu, 3 Aug 2000 14:01:44 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Keith Owens <kaos@ocs.com.au>
cc: paulus@linuxcare.com.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: Where does ppc define __start___ksymtab? 
In-Reply-To: <31474.965303015@ocs3.ocs-net>
Message-ID: <Pine.HPX.4.10.10008031350200.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Keith Owens wrote:

> On Thu, 3 Aug 2000 11:58:36 +0200 (METDST),
> Gabriel Paubert <paubert@iram.es> wrote:
> >What I hate in all this is that the combination of 2 bugs (no
> >ksymtab/kstrtab in vmlinux.lds and no definition of the start and stop
> >symbols) ends up in something working through behind the scenes black
> >magic. Perhaps names should be chosen such that they will never clash with
> >the ones the linker feels free to generate ?
>
> Given that the vmlinux.lds scripts go into minute detail about
> placement of sections in the kernel, why are we even letting the linker
> store orphan sections?  I think that all vmlinux.lds ought to end with
> this.
>
>   /DISCARD/ : { *(*) }       /* Discard all other sections */

No problem.

> If we want anything in the kernel then we put it there, and say where
> we want it.  Anything not explicitly listed is discarded.  I just did
> this with ix86 and vmlinux shrank by 9K, mainly in .bss.  It would not
> boot afterwards so obviously some part of that 9K is required but right
> now it works by some "magic" storing the unknown sections.  I'm going
> to track down which sections are not being explicitly placed.

I have trouble parsing this, since the bss by definition does not occupy
any space in vmlinux.

objdump --head lists all the sections and it's quite easy to see which
ones have unexpected names (the orphans by definition).  Also ppc
vmlinux.lds includes a lot of section which are probably never needed:
AFAICT the plt/got have no meaning in a statically linked image and the
ctors is C++ only. It needs a serious cleanup IMHO...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
