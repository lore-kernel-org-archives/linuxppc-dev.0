To: Dan Malek <dan@netx4.com>
Cc: Cort Dougan <cort@fsmlabs.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.3.37 / 2.3.18 / 2.2.13
References: <20000107213528.A29581@mail.ro.nu> <387A38DB.8C51AB1D@netx4.com> <20000110211045.F8416@mail.ro.nu> <387A5FD5.33A21291@netx4.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 11 Jan 2000 20:17:11 +0100
In-Reply-To: Dan Malek's message of "Mon, 10 Jan 2000 17:40:21 -0500"
Message-ID: <kfyn1qc770o.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> Robin O'Leary wrote:
> 
> 
> > ....  Although I have now
> > coaxed 2.3.18 as far as trying to load the initrd, it has been an uphill
> > struggle all the way and I still haven't got the compressed bootloader
> > going properly.  Could it be that my problems stem from using 2.3.18?
> 
> 
> As I recall, the ram disk didn't work in 2.3.18.  There are some
> general things that don't work in 2.3.18, so I bailed out and
> updated 2.2.xx to get something stable.  Since 2.3.xx is now
> in it's mid-30's (still younger than I :-), perhaps it is mature
> enough that I should visit again and make sure the 8xx configuration
> continues to work.

Speaking of updating and 2.2, 8xx support were broken in 2.2.14 because
of changes in kernel/head.S. Could someone take care so that the
following patch makes it into 2.2.15:

--- linux-2.2.14.orig/arch/ppc/mbxboot/head.S	Wed Dec 22 17:52:37 1999
+++ linux-2.2.14/arch/ppc/mbxboot/head.S	Tue Jan 11 16:38:54 2000
@@ -222,12 +222,10 @@
 	lwz	r5,0(r2)
 	
 	/* tell kernel we're prep */
-	/* 
-	 * get start address of kernel code which is stored as a coff
-	 * entry.  see boot/head.S -- Cort 
+	/*
+	 * now all PPC kernels start execution at address 0
 	 */
 	li	r9,0x0
-	lwz	r9,0(r9)
 	mtlr	r9
 
 	/* Invalidate the instruction cache because we just copied a

Also, is there any reason why not at least the 8xx-only code in 2.2.15
could be updated to working versions?

//Marcus
-- 
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
