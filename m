Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 42E4F2C016A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 21:30:10 +1000 (EST)
Date: Thu, 23 May 2013 12:24:01 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since
 always need it.
Message-ID: <20130523112401.GO18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com> <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
 <201305231259.43750.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201305231259.43750.arnd@arndb.de>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
 Linux-sh list <linux-sh@vger.kernel.org>, Chen Gang <gang.chen@asianux.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Michel Lespinasse <walken@google.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>,
 Serge Hallyn <serge.hallyn@canonical.com>, Mike Frysinger <vapier@gentoo.org>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 Will Deacon <will.deacon@arm.com>, Jeff Dike <jdike@addtoit.com>,
 Akinobu Mita <akinobu.mita@gmail.com>,
 uml-user <user-mode-linux-user@lists.sourceforge.net>,
 "uclinux-dist-devel@blackfin.uclinux.org"
 <uclinux-dist-devel@blackfin.uclinux.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Richard Kuo <rkuo@codeaurora.org>, Paul Mundt <lethal@linux-sh.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-hexagon@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 23, 2013 at 12:59:43PM +0200, Arnd Bergmann wrote:
> On Thursday 23 May 2013, Russell King - ARM Linux wrote:
> > So, if you want to use this, then you should update the CONFIG_BUG text
> > to include a warning to this effect:
> > 
> >      Warning: if CONFIG_BUG is turned off, and control flow reaches
> >      a BUG(), the system behaviour will be undefined.
> > 
> > so that people can make an informed choice about this, because at the
> > moment:
> > 
> >           Disabling this option eliminates support for BUG and WARN, reducing
> >           the size of your kernel image and potentially quietly ignoring
> >           numerous fatal conditions. You should only consider disabling this
> >           option for embedded systems with no facilities for reporting errors.
> >           Just say Y.
> > 
> > will become completely misleading.  Turning this option off will not
> > result in "quietly ignoring numerous fatal conditions".
> 
> I must be missing something, to me the two descriptions mean the same thing.

To me, the current text suggests that we still detect the fatal condition
but the code continues to execute in a manner controlled by the program.

The latter is uncontrolled code (or data) execution in ways unspecified
by the program.

> You don't just want to avoid the code for printing the bug message and
> the invalid instruction, we also want the compiler to not emit the 
> function call or check the enum for unexpected values. The meaning of
> BUG() is really that person writing that statement was sure it cannot
> happen unless there is a bug in the kernel, which has likely already
> corrupted data. Printing a diagnostic at this point is nice if someone
> is there to look at it, but letting the kernel do further actions that
> may be undefined is not going to make things worse.

I'm not talking about printing a diagnostic.  I'm talking about the CPU
remaining under the control of the program it is running - that being
the Linux kernel.

With CONFIG_BUG unset, turning on things like reboot-on-panic and such
like is worthless.  Arguably even is having a hardware watchdog - because
even if you hit one of these BUG() conditions where the CPU goes off and
does its own thing, it might be sufficient that the system is still able
to take care of the watchdog.

This is the problem you guys are missing - unreachable() means "we lose
control of the CPU at this point".

If you have an embedded system and you've taken out all the printk()
stuff, you most certainly want the system to do _something_ if you hit
an unexpected condition.
