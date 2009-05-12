Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr5.xs4all.nl (smtp-vbr5.xs4all.nl [194.109.24.25])
	by ozlabs.org (Postfix) with ESMTP id E87C9DDF85
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 00:10:54 +1000 (EST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id n4CEApxn024167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 16:10:52 +0200 (CEST)
	(envelope-from nvbolhuis@aimvalley.nl)
Message-ID: <4A09836A.5090707@aimvalley.nl>
Date: Tue, 12 May 2009 16:10:50 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
CC: linuxppc-dev@ozlabs.org
Subject: Re: howto disable dcache (on a MPC8313)
References: <4A02F905.6080904@aimvalley.nl>
In-Reply-To: <4A02F905.6080904@aimvalley.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I hate open ends, so for those interested.

I made a small change in u-boot and kernel and it works now.
btw. it makes a huge performance difference. The kernel boots
much slower and my user-space calculation now runs in 44 secs
(no data-cache) instead of 2.8 secs (with data-cache).

in u-boot the data-cache is initially used for data and stack.
Once RAM is available and the u-boot relocation has been done
the data cache can be disabled by clearing DCE in HID0. This
must be done after flushing the cache.

diff -C 5 -r1.3 start.S
*** start.S     2 Apr 2009 10:36:46 -0000       1.3
--- start.S     8 May 2009 13:44:38 -0000
***************
*** 928,937 ****
--- 928,949 ----
   5:    dcbst   0,r4
         add     r4,r4,r6
         cmplw   r4,r5
         blt     5b
         sync                    /* Wait for all dcbst to complete on bus */
+
+ /* disable data-cache (TEST) */
+         mfspr   r20, HID0
+         li      r21, HID0_DCE|HID0_DLOCK
+         andc    r20, r20, r21
+         ori     r21, r20, HID0_DCFI
+         sync
+         mtspr   HID0, r21       /* sets invalidate, clears enable and lock */
+         sync
+         mtspr   HID0, r20       /* clears invalidate */
+
+
         mr      r4,r3
   6:    icbi    0,r4
         add     r4,r4,r6
         cmplw   r4,r5
         blt     6b



The linux kernel enables the cache through
__setup_cpu_603 -> setup_common_caches
this function gets called from call_setup_cpu which has nothing
to do with CONFIG_(HAVE_)OPROFILE.
It's easy to modify this function not to set the HID0_DCE (without
caring much about the assembly).

diff -C 5 -r1.1.1.1 cpu_setup_6xx.S
*** arch/powerpc/kernel/cpu_setup_6xx.S 5 Jan 2009 10:55:25 -0000       1.1.1.1
--- arch/powerpc/kernel/cpu_setup_6xx.S 8 May 2009 13:53:31 -0000
***************
*** 79,90 ****
         blr

   /* Enable caches for 603's, 604, 750 & 7400 */
   setup_common_caches:
         mfspr   r11,SPRN_HID0
!       andi.   r0,r11,HID0_DCE
!       ori     r11,r11,HID0_ICE|HID0_DCE
         ori     r8,r11,HID0_ICFI
         bne     1f                      /* don't invalidate the D-cache */
         ori     r8,r8,HID0_DCI          /* unless it wasn't enabled */
   1:    sync
         mtspr   SPRN_HID0,r8            /* enable and invalidate caches */
--- 79,90 ----
         blr

   /* Enable caches for 603's, 604, 750 & 7400 */
   setup_common_caches:
         mfspr   r11,SPRN_HID0
!       andi.   r0,r11,(0<<14)
!       ori     r11,r11,HID0_ICE|(0<<14)
         ori     r8,r11,HID0_ICFI
         bne     1f                      /* don't invalidate the D-cache */
         ori     r8,r8,HID0_DCI          /* unless it wasn't enabled */
   1:    sync
         mtspr   SPRN_HID0,r8            /* enable and invalidate caches */
