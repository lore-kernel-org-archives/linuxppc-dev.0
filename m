Return-Path: <mkravetz@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2F78679E6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 10:20:12 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2RNJxad032622
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2006 18:19:59 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2RNJmRZ230510
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2006 18:19:48 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2RNJmRt024801
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2006 18:19:48 -0500
Date: Mon, 27 Mar 2006 15:20:00 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Workaround for RTAS bug
Message-ID: <20060327231959.GA15383@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A bug in the RTAS services incorrectly interprets some bits in the CR
when called from the OS.  Specifically, bits in CR4.  The result could
be a firmware crash that also takes down the partition.  A firmware
fix is in the works.  We have seen this situation when performing DLPAR
operations.  As a temporary workaround, clear the CR in enter_rtas().
Note that enter_rtas() will not set any bits in CR4 before calling RTAS.

Also note that the 32 bit version of enter_rtas() should have the same
work around even though the chances of hitting the bug are much smaller
due to the lack of DLPAR on 32 bit kernels.  However, my assembly skills
are a bit rusty and the 32 bit code doesn't seem to follow the conventions
for where things should be saved.  In addition, I don't have a system
to test 32 bit kernels.  Help creating and at least touch testing the
same workaround for 32 bit would be appreciated.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.16/arch/powerpc/kernel/entry_64.S linux-2.6.16.work/arch/powerpc/kernel/entry_64.S
--- linux-2.6.16/arch/powerpc/kernel/entry_64.S	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16.work/arch/powerpc/kernel/entry_64.S	2006-03-27 17:17:59.000000000 +0000
@@ -616,6 +616,12 @@ _GLOBAL(enter_rtas)
 	mfsrr1	r10
 	std	r10,_SRR1(r1)
 
+	/* Temporary workaround to clear CR until RTAS can be modified to
+	 * ignore all bits.
+	 */
+	li	r0,0
+	mtcr	r0
+
 	/* There is no way it is acceptable to get here with interrupts enabled,
 	 * check it with the asm equivalent of WARN_ON
 	 */
