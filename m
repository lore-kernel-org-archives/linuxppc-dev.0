Date: Thu, 3 Aug 2000 13:28:24 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Keith Owens <kaos@ocs.com.au>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Where does ppc define __start___ksymtab?
In-Reply-To: <Pine.LNX.4.10.10008022216520.833-100000@cassiopeia.home>
Message-ID: <Pine.HPX.4.10.10008031326020.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2 Aug 2000, Geert Uytterhoeven wrote:

>
> On Tue, 1 Aug 2000, Keith Owens wrote:
> > Please cc: kaos@ocs.com.au on replies, I am not on this list.
> >
> > I have been trying to find where ppc defines __start___ksymtab and
> > __stop___ksymtab symbols.  These delimit the __ksymtab entries for
> > module symbols.  On every other architecture that supports modules,
> > arch/xxx/vmlinux.lds contains lines like this
> >
> >   __start___ksymtab = .;	/* Kernel symbol table */
> >   __ksymtab : { *(__ksymtab) }
> >   __stop___ksymtab = .;
> >
> > I can find no equivalent lines for ppc in a stock 2.4.0-test5 source
> > tree yet ppc obviously defines them somewhere.  But where?
>
> I'm no gcc linkscript expert, but doesn't the absence of __ksymtab stuff in
> vmlinux.lds simply mean that gcc can put stuff for section __ksymtab wherever
> it wants in the final object file?

Not exactly, it will use the read/write/exec attributes to match the area
and it will actually place kstrtab and ksymtab just after .rodata in the
case of the ppc kernel. So it's not completely random, but sometimes hard
to predict (if it does not find anything that matches, it will place it at
the end).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
