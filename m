Date: Thu, 3 Aug 2000 11:58:36 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Keith Owens <kaos@ocs.com.au>
cc: paulus@linuxcare.com.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: Where does ppc define __start___ksymtab? 
In-Reply-To: <29943.965289793@ocs3.ocs-net>
Message-ID: <Pine.HPX.4.10.10008031038520.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Keith Owens wrote:

>
> On Thu, 3 Aug 2000 16:13:46 +1000 (EST),
> Paul Mackerras <paulus@linuxcare.com.au> wrote:
> >> I have been trying to find where ppc defines __start___ksymtab and
> >> __stop___ksymtab symbols.  These delimit the __ksymtab entries for
> >> module symbols.  On every other architecture that supports modules,
> >> arch/xxx/vmlinux.lds contains lines like this
> >>
> >>   __start___ksymtab = .;	/* Kernel symbol table */
> >>   __ksymtab : { *(__ksymtab) }
> >>   __stop___ksymtab = .;
> >>
> >> I can find no equivalent lines for ppc in a stock 2.4.0-test5 source
> >> tree yet ppc obviously defines them somewhere.  But where?
> >
> >I think they must be defined automagically by the linker.  They aren't
> >defined explicitly anywhere but we still end up with a __ksymtab
> >section with the __start___ksymtab and __stop___ksymtab symbols
> >defined at the beginning and end of it.
> >
> >We can add those lines if you like, that's no problem.
>
> Please add them.  It makes the ppc vmlinux.lds more consistent with the
> other archs that support modules.
>

Indeed they are automagically defined by the linker, which adds these
symbols to "orphan" section, i.e., the ones which are not explicitly
loaded (or discarded) in the linker script. The code that does all this
magic is somehat hidden in binutils/ld/emultempl/elf32.em.

What I hate in all this is that the combination of 2 bugs (no
ksymtab/kstrtab in vmlinux.lds and no definition of the start and stop
symbols) ends up in something working through behind the scenes black
magic. Perhaps names should be chosen such that they will never clash with
the ones the linker feels free to generate ?

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
