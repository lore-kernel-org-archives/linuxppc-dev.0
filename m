Date: Mon, 22 Sep 2003 09:45:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michel D?nzer <michel@daenzer.net>
Cc: Cliff White <cliffw@osdl.org>, linuxppc-dev@lists.linuxppc.org,
	211668@bugs.debian.org
Subject: Re: 2.6.0-test5 "incorrect section attributes for .plt"
Message-ID: <20030922164511.GJ7443@ip68-0-152-218.tc.ph.cox.net>
References: <200309192258.h8JMwWs04059@mail.osdl.org> <1064060622.1347.45.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
In-Reply-To: <1064060622.1347.45.camel@thor.holligenstrasse29.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Sep 20, 2003 at 02:23:42PM +0200, Michel D?nzer wrote:

> On Sat, 2003-09-20 at 00:58, Cliff White wrote:
> > System is an iBook2,
> > distro is Debian unstable
> > kernel is 2.6.0-test5 or current from
> > bk://ppc.bkbits.net/linuxppc-2.5
> >
> > gcc version 3.3.2 20030908 (Debian prerelease)
> >
> > When compiling modules, i get this warning, repeatedly:
> >  CC [M]  sound/ppc/pmac.o
> > {standard input}: Assembler messages:
> > {standard input}:3: Warning: setting incorrect section attributes for .plt
> >
> > Then, this failure:
> >
> >   AS      arch/ppc/boot/common//util.o
> > arch/ppc/boot/common/util.S: Assembler messages:
> > arch/ppc/boot/common/util.S:220: Warning: setting incorrect section attributes
> > for .relocate_code
> > arch/ppc/boot/common//util.o: File truncated
> > arch/ppc/boot/common/util.S:281: FATAL: Can't write
> > arch/ppc/boot/common//util.o: File truncated
> > make[2]: *** [arch/ppc/boot/common//util.o] Error 1
> > make[1]: *** [arch/ppc/boot/common/] Error 2
>
> See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=211668 .

I followed up on this to lkml/kernelnewbies, and then saw this so (and
the bug# is cc'ed as well).  I suspect the problem is that binutils is
no longer happy with:
.section "foo","attrs"
... asm ...
.previous
\n
\n
EOF
(and possibly just .previous\nEOF)

But I don't think the .previous is needed anyhow, so if someone could
verify that the following works (vs 2.6 current, but also a problem in
2.4)

===== arch/ppc/boot/common/util.S 1.6 vs edited =====
--- 1.6/arch/ppc/boot/common/util.S	Thu Aug 21 10:17:00 2003
+++ edited/arch/ppc/boot/common/util.S	Mon Sep 22 09:21:37 2003
@@ -277,6 +277,3 @@
 	addi	r3,r3,L1_CACHE_BYTES	/* Next line, please */
 	bdnz	00b
 10:	blr
-
-	.previous
-

I'll check this into the kernel.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
