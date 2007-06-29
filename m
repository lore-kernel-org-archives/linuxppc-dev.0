Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 306A0DDEE7
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 06:50:23 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5TKoLsV032705
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 16:50:21 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5TKoL5E242974
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 14:50:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5TKoKBX019583
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 14:50:20 -0600
Subject: [PATCH v2.1 ] Fix VDSO gettimeofday() when called with NULL struct
	timeval.
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: willschm@linux.vnet.ibm.com
In-Reply-To: <1183149584.22547.51.camel@farscape.rchland.ibm.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
	<20070625235032.GH9768@bakeyournoodle.com>
	<1183149584.22547.51.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 15:49:50 -0500
Message-Id: <1183150190.22547.62.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



The vdso64 portion of patch 74609f4536f2b8fd6a48381bbbe3cd37da20a527 for
fixing problems with NULL gettimeofday input mistakenly checks for a
null tz field twice, when it should be checking for null tz once, and
null tv once; by way of a r10/r11 typo. 

Any application calling gettimeofday(&tv,NULL) will "fail".

This corrects that typo, and makes my G5 happy.

tested on G5. 


Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: Tony Breeds <tony@bakeyournoodle.com>
cc: Ben Herrenschmidt <benh@kernel.crashing.org>

---

diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index 2d7a510..c6401f9 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -31,7 +31,7 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	mr	r11,r3			/* r11 holds tv */
 	mr	r10,r4			/* r10 holds tz */
 	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
-	cmpldi	r10,0			/* check if tv is NULL */
+	cmpldi	r11,0			/* check if tv is NULL */
 	beq	2f
 	bl	V_LOCAL_FUNC(__do_get_xsec)	/* get xsec from tb & kernel */
 	lis     r7,15			/* r7 = 1000000 = USEC_PER_SEC */
