Date: Thu, 6 Jan 2000 11:51:08 -0500 (EST)
From: Naoki Takebayashi <ntakebay@bio.indiana.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: ttsig@mindspring.com
Subject: Re: Does 2.2.14 Break SMP for PPC?
Message-ID: <Pine.SOL.4.10.10001061137170.262-100000@sunflower.bio.indiana.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>From: Tom Sightler <ttsig@mindspring.com>
>Subject: Does 2.2.14 Break SMP for PPC?
>Should SMP be working in 2.2.14?  If so, does anyone else have any
>suggestions on what may be wrong?  I really have no pressing need to
>upgrade to 2.2.14 right away since 2.2.13 with SMP has been running very
>stable, but I always like to keep my kernels updated and these machines

I also had the same problem.  After updating to 2.2.14, the secondary
processor get stuck during the boot time and smp become disabled.  After
looking at the patch files, I noticed there is a small change in
linux/arch/ppc/kernel/head.S. There are three lines added in the beginning
of the secondary CPU initialization.

>From patch-2.2.14:

@@ -245,13 +233,16 @@
        bl      prom_init
        .globl  __secondary_start
 __secondary_start:
-/*
- * Use the first pair of BAT registers to map the 1st 16MB
+/* Switch MMU off, clear BATs and flush TLB */
+       bl      mmu_off
+       bl      clear_bats
+       bl      flush_tlbs
+
+/* Use the first pair of BAT registers to map the 1st 16MB
  * of RAM to KERNELBASE.  From this point on we can't safely
  * call OF any more.
  */
        lis     r11,KERNELBASE@h

Well, I don't know PPC assembly, but I commented out the three "bl ... "
lines.  Then the 2nd CPU stack message went away and SMP was enabled.
However it it really unstable, though.  So the problem with 2.2.14 SMP
seems to be around here.  Probably someone who knows PPC assembly can
help here...

Naoki Takebayashi     <ntakebay@bio.indiana.edu>
--- Dept. of Biology, Indiana University, Jordan Hall 142
--- 1001 E. Third St. Bloomington, IN 47405-3700 USA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
