Date: Mon, 12 Jul 2004 08:11:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040712151119.GL28002@smtp.west.cox.net>
References: <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <20040704072350.GA7060@suse.de> <20040705183219.GI2146@smtp.west.cox.net> <20040709013429.GN23135@smtp.west.cox.net> <20040712090618.GB32413@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040712090618.GB32413@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 12, 2004 at 11:06:18AM +0200, Olaf Hering wrote:
>  On Thu, Jul 08, Tom Rini wrote:
>
> > OK.  After giving this a whirl (after a NAK from Matt, privately), it looks
> > like some versions of binutils don't make proper use of -many (in 2.14 it
> > will override ppc_cpu, and PPC_OPCODE_ANY doesn't look to be used).  So
> > that brings us to the following patch.  Olaf, can you please verify this
> > still works for you?  Paul, is this OK with you?
>
> This is not enough.
> as needs -many (or at least -maltivec) unconditionally for binutils 2.15
> gcc needs also -maltivec because -mppc seems to disable -maltivec again.

Hmm.  So with binutils 2.14, we need to do -many,-mppc as -many will
zero out all previous flags.  On binutils 2.15, -mppc always resets
the cpu_flags, thus clearing out -many.  -mppc64bridge, -me500 and
-m405/etc all do the same.  So far we end up being lucky, imho, that
don't trip over this on !CONFIG_6xx.  So while I'm not exactly happy
we have to do this, the following is the least ugly fix for this:

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.55/arch/ppc/Makefile	2004-07-05 03:27:10 -07:00
+++ edited//home/trini/work/kernel/pristine/linux-2.6/arch/ppc/Makefile	2004-07-12 08:10:10 -07:00
@@ -32,6 +32,7 @@
 endif

 cflags-$(CONFIG_4xx)		+= -Wa,-m405
+cflags-$(CONFIG_6xx)		+= -Wa,-maltivec
 cflags-$(CONFIG_E500)		+= -Wa,-me500
 cflags-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge


--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
