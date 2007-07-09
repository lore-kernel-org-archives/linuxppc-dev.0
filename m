Return-Path: <ahuja@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A9C0DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 05:03:50 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l69J3lPc002944
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:03:47 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l69J3kWd396236
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:03:46 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l69J3k5X015795
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:03:46 -0400
Message-ID: <46928691.2040008@austin.ibm.com>
Date: Mon, 09 Jul 2007 14:03:45 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Infinite loop/always true check possible with unsigned
	counter.
References: <469270F3.4070206@austin.ibm.com>
In-Reply-To: <469270F3.4070206@austin.ibm.com>
Content-Type: multipart/mixed; boundary="------------010104090308040504020700"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010104090308040504020700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Repost to fix my email id.

Fix to correct a possible infinite loop or an always true check when the 
unsigned long counter "i" is used in
lmb_add_region() in the following for loop:

for (i = rgn->cnt-1; i >= 0; i--)

Signed-off-by: Manish Ahuja <ahuja@austin.ibm.com>



--------------010104090308040504020700
Content-Type: text/plain;
 name="unsigned"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unsigned"

---
 arch/powerpc/mm/lmb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.22-rc4/arch/powerpc/mm/lmb.c
===================================================================
--- 2.6.22-rc4.orig/arch/powerpc/mm/lmb.c	2007-06-11 21:10:46.000000000 -0500
+++ 2.6.22-rc4/arch/powerpc/mm/lmb.c	2007-07-06 21:47:40.000000000 -0500
@@ -138,8 +138,8 @@ void __init lmb_analyze(void)
 static long __init lmb_add_region(struct lmb_region *rgn, unsigned long base,
 				  unsigned long size)
 {
-	unsigned long i, coalesced = 0;
-	long adjacent;
+	unsigned long coalesced = 0;
+	long adjacent, i;
 
 	/* First try and coalesce this LMB with another. */
 	for (i=0; i < rgn->cnt; i++) {

--------------010104090308040504020700--
