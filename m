Date: Tue, 13 Jul 2004 17:29:50 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040713152950.GB7858@suse.de>
References: <20040709013429.GN23135@smtp.west.cox.net> <20040712090618.GB32413@suse.de> <20040712151119.GL28002@smtp.west.cox.net> <20040712180321.GB16877@smtp.west.cox.net> <20040713134945.GA5104@suse.de> <20040713140127.GJ16877@smtp.west.cox.net> <20040713140220.GA20213@suse.de> <20040713142015.GK16877@smtp.west.cox.net> <20040713151854.GA7858@suse.de> <20040713152633.GL16877@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040713152633.GL16877@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Tue, Jul 13, Tom Rini wrote:

> On Tue, Jul 13, 2004 at 05:18:54PM +0200, Olaf Hering wrote:
> >  On Tue, Jul 13, Tom Rini wrote:
> >
> > > OK.  Perhaps gcc should be refusing to build with older binutils
> > > perhaps?  It sounds like gcc-3.4 + binutils-2.14 or older won't work
> > > unless we ensure that any -mppc/altivec/etc type flags that gcc itself
> > > would pass, excluding -many, are re-passed by the kernel itself.
> >
> > Its just the 2.14 + gcc 3.4 combo that does not work.
> > binutils 2.12, 2.13  and 2.15 works ok with gcc 3.4.
>
> Does gcc not pass down -many with 2.12/2.13, or does -many actually work
> there?

 /home/olaf/toolchain/inst/binutils-2.14-gcc-3.4.1/lib/gcc/powerpc-unknown-linux-gnu/3.4.1/../../../../powerpc-unknown-linux-gnu/bin/as -mppc -many -V -Qy -maltivec -o arch/ppc/kernel/.tmp_time.o time.s
 /home/olaf/toolchain/inst/binutils-2.12.1-gcc-3.4.1/lib/gcc/powerpc-unknown-linux-gnu/3.4.1/../../../../powerpc-unknown-linux-gnu/bin/as -mppc -many -V -Qy -maltivec -o arch/ppc/kernel/.tmp_time.o time.s
 /home/olaf/toolchain/inst/binutils-2.15-gcc-3.4.1/lib/gcc/powerpc-unknown-linux-gnu/3.4.1/../../../../powerpc-unknown-linux-gnu/bin/as -mppc -many -V -Qy -maltivec -o arch/ppc/kernel/.tmp_time.o time.s

looks like gas 2.14 has different -many behaviour.


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
