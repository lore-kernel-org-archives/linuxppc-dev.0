Return-Path: <ananth@in.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B7F0DDED7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 23:02:08 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n16BtOUX000587
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2009 06:55:24 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n16C24Ls178920
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2009 07:02:04 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n16C23Mg018416
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2009 07:02:03 -0500
Date: Fri, 6 Feb 2009 17:32:00 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Don't emulate mr. instructions
Message-ID: <20090206120200.GU3695@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently emulate_step() emulates mr. instructions without updating cr0
and this can be disastrous. Don't emulate mr.

This bug has been around for a while, but I am not sure if its a worthy
-stable candidate. I'll leave it to Ben do decide.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/lib/sstep.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.29-rc3/arch/powerpc/lib/sstep.c
===================================================================
--- linux-2.6.29-rc3.orig/arch/powerpc/lib/sstep.c
+++ linux-2.6.29-rc3/arch/powerpc/lib/sstep.c
@@ -172,6 +172,8 @@ int __kprobes emulate_step(struct pt_reg
 			}
 			break;
 		case 0x378:	/* orx */
+			if (instr & 1)
+				break;
 			rs = (instr >> 21) & 0x1f;
 			rb = (instr >> 11) & 0x1f;
 			if (rs == rb) {		/* mr */
