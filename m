Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74E86B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 23:47:28 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5SDPKGl015145
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 09:25:20 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5SDl68L1622196
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 09:47:06 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5SDl59J012542
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 07:47:06 -0600
Date: Tue, 28 Jun 2011 09:47:11 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jdl@jdl.com, david@gibson.dropbear.id.au
Subject: [PATCH v2] dtc: Remove unused variable in flat_read_mem_reserve
Message-ID: <20110628134711.GF10237@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The *p variable is declared and used to save inb->ptr, however p is
later never used.  This has been the case since commit 6c0f3676 and can
lead to build failures with -Werror=unused-but-set-variable:

	flattree.c: In function 'flat_read_mem_reserve':
	flattree.c:700:14: error: variable 'p' set but not used [-Werror=unused-but-set-variable]
	cc1: all warnings being treated as errors
	make: *** [flattree.o] Error 1

Remove the variable.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

diff --git a/flattree.c b/flattree.c
index ead0332..28d0b23 100644
--- a/flattree.c
+++ b/flattree.c
@@ -697,7 +697,6 @@ static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
 {
 	struct reserve_info *reservelist = NULL;
 	struct reserve_info *new;
-	const char *p;
 	struct fdt_reserve_entry re;
 
 	/*
@@ -706,7 +705,6 @@ static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
 	 *
 	 * First pass, count entries.
 	 */
-	p = inb->ptr;
 	while (1) {
 		flat_read_chunk(inb, &re, sizeof(re));
 		re.address  = fdt64_to_cpu(re.address);
