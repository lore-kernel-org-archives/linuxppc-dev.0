Date: Thu, 13 Mar 2003 17:07:24 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mikpe@csd.uu.se, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
Message-ID: <20030313160724.GA10742@suse.de>
References: <15984.39762.858447.704784@gargle.gargle.HOWL> <20030313152506.GB28311@suse.de> <15984.43692.736225.647094@gargle.gargle.HOWL> <1047571502.790.76.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1047571502.790.76.camel@zion.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Thu, Mar 13, Benjamin Herrenschmidt wrote:

> what are the respective sizes of the working 2.4.6 kernel
> and my non working 2.4.20 ? Can you try to shrink the 2.4.20
> down to the 2.4.6 size (removing drivers etc...) and see if
> that helps ?

There are 2 problems.
My 'loading data' failure must be fixed by page alignment.

diff -purN linux_ppc.orig/arch/ppc/boot/ld.script linux_ppc/arch/ppc/boot/ld.script
--- linux_ppc.orig/arch/ppc/boot/ld.script      2002-11-27 14:42:42.000000000 +0000
+++ linux_ppc/arch/ppc/boot/ld.script   2002-11-27 18:53:34.000000000 +0000
@@ -39,7 +39,8 @@ SECTIONS
   PROVIDE (etext = .);

   /* Read-write section, merged into data segment: */
-  . = ALIGN(8);
+  /* this must be page aligned for OF 1.05 in old Macs, for coff boot */
+  . = ALIGN(0x1000);
   .data    :
   {
     *(.data)

The second problem might be related, I remember Eddie can not boot
anymore with recent kernels and the patch above doesnt fix it. It is
probably still unfixed, and the cause unknown.


Gruss Olaf

--
A: No.
Q: Should I include quotations after my reply?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
