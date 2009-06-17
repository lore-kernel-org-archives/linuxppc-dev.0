Return-Path: <mohan@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F3760B71D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 21:34:53 +1000 (EST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE20CDDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 21:34:53 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5HBY029020053
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 21:34:00 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5HBYpQ7831492
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 21:34:51 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5HBYpIx026672
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 21:34:51 +1000
Date: Wed, 17 Jun 2009 17:04:56 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Do not inline putprops function
Message-ID: <20090617113456.GC31595@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: horms@verge.net.au, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do not inline putprops function

With the recent kexec-tools git tree, both kexec and kdump kernels hang (i.e
kexec -l and kexec -p respectively). This happened after the patch "ppc64:
cleanups" commit b43a84a31a4be6ed025c1bdef3bb1c3c12e01b16. I tried
reverting each hunk and then found out that retaining following lines in
fs2dt.c makes kexec/kdump work.

-static unsigned *dt_len; /* changed len of modified cmdline
-                           in flat device-tree */

[....]

-               dt_len = dt;

I don't have any clue why removing a unused variable would cause the kexec
kernel to hang. After further investigation, I observed that if the putprops
function is not inlined, kexec/kdump kernel would work even after removing
the above lines.

This patch directs gcc to not inline the putprops function. Now we could
invoke kexec and kdump kernels.
---
 kexec/arch/ppc64/fs2dt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index 1f551fd..1e01f74 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -259,7 +259,7 @@ static void add_usable_mem_property(int fd, int len)
 }
 
 /* put all properties (files) in the property structure */
-static void putprops(char *fn, struct dirent **nlist, int numlist)
+__attribute__ ((noinline)) static void putprops(char *fn, struct dirent **nlist, int numlist)
 {
 	struct dirent *dp;
 	int i = 0, fd, len;
-- 
1.6.0.6
