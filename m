MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16472.13017.785682.193184@cargo.ozlabs.ibm.com>
Date: Wed, 17 Mar 2004 22:13:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppcdev@qbjnet.com
Cc: linuxppc-dev@lists.linuxppc.org, trini@kernel.crashing.org
Subject: Re: Can't get 7248 PreP boot disk working in 2.6
In-Reply-To: <20040316234723.18931.qmail@kunk.qbjnet.com>
References: <20040316234723.18931.qmail@kunk.qbjnet.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


linuxppcdev@qbjnet.com writes:

> I've never had trouble making a boot disk for 2.4.x kernels. Using the
> current bitkeeper 2.4 and 2.6 however, the 2.4 works fine and the 2.6
> reads a few sectors and goes to the System Maint disk insert dialog.
> Tried different floppies, etc.

There is a bug in arch/ppc/boot/utils/mkprep.c in 2.6.  This patch
should fix it.  Tom, how about sending this to Linus and Andrew?

diff -urN linux-2.5/arch/ppc/boot/utils/mkprep.c linux-2.4/arch/ppc/boot/utils/mkprep.c
--- linux-2.5/arch/ppc/boot/utils/mkprep.c	2004-01-03 11:27:07.000000000 +1100
+++ linux-2.4/arch/ppc/boot/utils/mkprep.c	2003-12-31 09:32:23.000000000 +1100
@@ -219,6 +219,8 @@
   pe.number_of_sectors = cpu_to_le32(2*18*80-1);
 #endif /* __i386__ */

+  memcpy(&block[0x1BE],&pe,sizeof(pe));
+
   write( out, block, sizeof(block) );
   write( out, entry, sizeof(*entry) );
   write( out, length, sizeof(*length) );

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
