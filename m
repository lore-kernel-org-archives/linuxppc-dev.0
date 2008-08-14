Return-Path: <rocky.craig@hp.com>
Received: from g1t0028.austin.hp.com (g1t0028.austin.hp.com [15.216.28.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3BEACDE081
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 23:18:26 +1000 (EST)
Message-ID: <48A42F1A.6080903@hp.com>
Date: Thu, 14 Aug 2008 07:11:54 -0600
From: Rocky Craig <rocky.craig@hp.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2.6.27] [POWERPC] Invalidate all TLB entries in a specified
	range
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus@samba.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Rocky Craig <rocky.craig@hp.com>

The apparent intent of "flush_tlbs" is to invalidate TLB entries that
might match in the address range 0 to 0x00400000.  A loop counter is 
set up at the high value and decremented by page size.  However, the 
loop is only done once as the sense of the conditional branch at the
loop end does not match the setup/decrement.

Signed-off-by: Rocky Craig <rocky.craig@hp.com>
---

Source is from 2.6.27 development, but the bug appears as far back as 2.4.0.
The small user-space program below demonstrates the loop behavior.  It was
compiled via crosstool gcc 3.4.5 / glibc 2.3.6 for an MPC8347 target.

int main()
{
	long endval;				// 16(r31)

	__asm__ __volatile__(
		"	lis 10,0x40\n"
		"1:	addic. 10,10,-0x1000\n"
		"	bgt 1b\n"
		"	stw 10,16(31)\n");	// endval

	printf("end value = 0x%08lx\n", endval);
}

This might win the prize for "Smallest actual code patch ever".

--- a/arch/powerpc/kernel/head_32.S.orig	2008-07-24 19:25:09.000000000 -0600
+++ a/arch/powerpc/kernel/head_32.S	2008-07-24 19:25:22.000000000 -0600
@@ -1155,7 +1155,7 @@ flush_tlbs:
 	lis	r10, 0x40
 1:	addic.	r10, r10, -0x1000
 	tlbie	r10
-	blt	1b
+	bgt	1b
 	sync
 	blr
 
