Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 340E6DDDD8
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 21:51:30 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id lA5AoccH015006
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 21:50:38 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lA5AoeAx2633940
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 21:50:40 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA5AoXDk000370
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 21:50:34 +1100
Date: Mon, 5 Nov 2007 16:11:12 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cpm_load_patch() - declartion conflict
Message-ID: <20071105104112.GA18347@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The build fails with following error

  CC      arch/powerpc/sysdev/micropatch.o
arch/powerpc/sysdev/micropatch.c:625: error: conflicting types for ‘cpm_load_patch’
include/asm/commproc.h:94: error: previous declaration of ‘cpm_load_patch’ was here
arch/powerpc/sysdev/micropatch.c: In function ‘cpm_load_patch’:
arch/powerpc/sysdev/micropatch.c:630: warning: unused variable ‘smp’
arch/powerpc/sysdev/micropatch.c:629: warning: unused variable ‘spp’
arch/powerpc/sysdev/micropatch.c:628: warning: unused variable ‘iip’
make[1]: *** [arch/powerpc/sysdev/micropatch.o] Error 1
make: *** [arch/powerpc/sysdev] Error 2

The commit f2a0bd3753dad7ea4605ebd5435716b39e9f92bb defines the function
with void cpm_load_patch(cpm8xx_t *cp) prtotype and is declared as 
extern void cpm_load_patch(volatile immap_t *immr) in the header file.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
diff --git a/include/asm-powerpc/commproc.h b/include/asm-powerpc/commproc.h
index 0307c84..a2328b8 100644
--- a/include/asm-powerpc/commproc.h
+++ b/include/asm-powerpc/commproc.h
@@ -91,7 +91,7 @@ extern uint m8xx_cpm_hostalloc(uint size);
 extern int  m8xx_cpm_hostfree(uint start);
 extern void m8xx_cpm_hostdump(void);
 
-extern void cpm_load_patch(volatile immap_t *immr);
+extern void cpm_load_patch(cpm8xx_t *cp);
 
 /* Buffer descriptors used by many of the CPM protocols.
 */


--
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
