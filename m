Return-Path: <hollisb@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95245DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 06:03:21 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9VJ3G5W019929
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 15:03:16 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9VJ3G4J117454
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 15:03:16 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9VJ37NU032157
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 15:03:08 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/44x: declare tlb_44x_index for use in C code
Message-Id: <59bd162a744af080479f.1225479792@localhost.localdomain>
Date: Fri, 31 Oct 2008 14:03:12 -0500
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

# HG changeset patch
# User Hollis Blanchard <hollisb@us.ibm.com>
# Date 1225479768 18000
# Node ID 59bd162a744af080479fedffa97d01e26dceee6a
# Parent  635f3f74befc230d93f79dc3198c509394247ee8
powerpc/44x: declare tlb_44x_index for use in C code

KVM currently ignores the host's round robin TLB eviction selection, instead
maintaining its own TLB state and its own round robin index. However, by
participating in the normal 44x TLB selection, we can drop the alternate TLB
processing in KVM. This results in a significant performance improvement,
since that processing currently must be done on *every* guest exit.

Accordingly, KVM needs to be able to access and increment tlb_44x_index.
(KVM on 440 cannot be a module, so there is no need to export this symbol.)

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

---

Josh, can I get your ack? I'll submit through the KVM tree as usual.

diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -54,6 +54,7 @@
 #ifndef __ASSEMBLY__
 
 extern unsigned int tlb_44x_hwater;
+extern unsigned int tlb_44x_index;
 
 typedef struct {
 	unsigned long id;
