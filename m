Message-Id: <4.3.2.7.2.20000803145431.0367e100@mail.munich.netsurf.de>
Date: Thu, 03 Aug 2000 15:08:35 +0200
To: Gabriel Paubert <paubert@iram.es>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Where does ppc define __start___ksymtab? 
Cc: Keith Owens <kaos@ocs.com.au>, paulus@linuxcare.com.au,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPX.4.10.10008031350200.9070-100000@gra-ux1.iram.es>
References: <31474.965303015@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 14:01 03.08.00, Gabriel Paubert wrote:

>On Thu, 3 Aug 2000, Keith Owens wrote:
>
> > On Thu, 3 Aug 2000 11:58:36 +0200 (METDST),
> > Gabriel Paubert <paubert@iram.es> wrote:
> > >What I hate in all this is that the combination of 2 bugs (no
> > >ksymtab/kstrtab in vmlinux.lds and no definition of the start and stop
> > >symbols) ends up in something working through behind the scenes black
> > >magic. Perhaps names should be chosen such that they will never clash with
> > >the ones the linker feels free to generate ?
> >
> > Given that the vmlinux.lds scripts go into minute detail about
> > placement of sections in the kernel, why are we even letting the linker
> > store orphan sections?  I think that all vmlinux.lds ought to end with
> > this.
> >
> >   /DISCARD/ : { *(*) }       /* Discard all other sections */
>
>No problem.
>
> > If we want anything in the kernel then we put it there, and say where
> > we want it.  Anything not explicitly listed is discarded.  I just did
> > this with ix86 and vmlinux shrank by 9K, mainly in .bss.  It would not
> > boot afterwards so obviously some part of that 9K is required but right
> > now it works by some "magic" storing the unknown sections.  I'm going
> > to track down which sections are not being explicitly placed.
>
>I have trouble parsing this, since the bss by definition does not occupy
>any space in vmlinux.
>
>objdump --head lists all the sections and it's quite easy to see which
>ones have unexpected names (the orphans by definition).  Also ppc
>vmlinux.lds includes a lot of section which are probably never needed:
>AFAICT the plt/got have no meaning in a statically linked image and the
>ctors is C++ only. It needs a serious cleanup IMHO...

With newer binutils the tool I prefer for this is readelf -a.

Also note that binutils up to about 2.9.5.0.30 has a bug in the section
handling (which is still there in the official 2.10, but fixed in hjl's
releases). So for serious testing I would recommend to use
binutils-2.10.0.9 or 2.10.0.18 or later (?).
And if you plan to program the kernel into a flash, you'll need my
gcc-2.95.3-2c or later gcc, otherwise some data initialized by constructors
may wrongly end up in .rodata. Yes, gcc can produce constructors even in
plain C if you use some extensions (eg. some methods to init a struct),
which happen to be used in the kernel. So please keep the .ctors sections :-).

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
