Subject: Memory corruption bug in HardHat-1.2 CPU6 workaround
To: mgreer@mvista.com
Date: Thu, 28 Sep 2000 16:24:49 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000928052449.15FE54FF6B@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mark,

I've picked you at random from the MontaVista people on the list; if you're
not the right guy, could you please forward this to the appropriate person?

I've just noticed some potential memory corruption bugs associated with
the CPU6 workaround in the PPC HardHat-1.2 kernel.  I posted a complete fix
for this to the mailing list in response to Dan's initial half fix to the
previous CPU6 workaround which corrupted the kernel command line, but it
looks like my patch didn't quite make it in.  See:
    http://lists.linuxppc.org/listarcs/linuxppc-embedded/200006/msg00038.html

The bugs are a carry-over from when the CPU6 workaround used a word of data
12 bytes into the kernel command line as scratch space.  It looks like
the remaining cmd_line references were changed without removing the 12 byte
offset, meaning that they will clobber an unrelated value in memory 8 bytes
after cpu6_bug.  While I haven't observed any errant behaviour from this yet,
it's just waiting to bite someone unexpectedly, and will be darned hard to
find when it does.  Better to fix it now.

Here's a patch to fix the problem:

--- arch/ppc/kernel/head.S	Wed Sep 27 12:29:21 2000
+++ arch/ppc/kernel/head.S.fix	Thu Sep 28 16:12:09 2000
@@ -2428,12 +2428,12 @@
 	lis	r6, cpu6_bug@h
 	ori	r6, r6, cpu6_bug@l
 	li	r7, 0x3980
-	stw	r7, 12(r6)
-	lwz	r7, 12(r6)
+	stw	r7, 0(r6)
+	lwz	r7, 0(r6)
         mtspr   M_TWB, r9               /* Update MMU base address */
 	li	r7, 0x3380
-	stw	r7, 12(r6)
-	lwz	r7, 12(r6)
+	stw	r7, 0(r6)
+	lwz	r7, 0(r6)
         mtspr   M_CASID, r5             /* Update context */
 #else
         mtspr   M_TWB, r9               /* Update MMU base address */
@@ -2574,8 +2574,8 @@
 	lis	r7, cpu6_bug@h
 	ori	r7, r7, cpu6_bug@l
 	li	r4, 0x3980
-	stw	r4, 12(r7)
-	lwz	r4, 12(r7)
+	stw	r4, 0(r7)
+	lwz	r4, 0(r7)
         mtspr   M_TWB, r3               /* Update MMU base address */
 	SYNC
 	mtmsr	r5

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
