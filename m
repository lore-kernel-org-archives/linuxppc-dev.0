Return-Path: <mohan@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0A82B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 00:13:58 +1000 (EST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09800DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 00:13:57 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7AEDmfq001366
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 19:43:48 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7AEDmhj909380
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 19:43:48 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7AEDmpg031805
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 19:43:48 +0530
Date: Mon, 10 Aug 2009 19:43:51 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: horms@verge.net.au, kexec@lists.infradead.org
Subject: [PATCH 1/2] Make dtstruct variable to be 8 byte aligned
Message-ID: <20090810141351.GD3110@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, nhorman@redhat.com, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 1/2] Make dtstruct variable to be 8 byte aligned

kexec is creating a version 3 device tree to be backwards compatible. This
version of the struct has 8-byte alignment for properties whose value is 8 or
more bytes. As the code directly checks the pointer when deciding to add the
alignment word, the struct memory must start on an 8 byte boundary. Force the
dtstruct variable to be always 8 bytes aligned.

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 kexec/arch/ppc64/fs2dt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index 1f551fd..b01ff86 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -41,7 +41,7 @@
 
 static char pathname[MAXPATH], *pathstart;
 static char propnames[NAMESPACE] = { 0 };
-static unsigned dtstruct[TREEWORDS], *dt;
+static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;
 static unsigned long long mem_rsrv[2*MEMRESERVE] = { 0, 0 };
 
 static int crash_param = 0;
-- 
1.6.2.5
