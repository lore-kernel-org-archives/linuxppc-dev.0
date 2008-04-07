Return-Path: <hollisb@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E586BDE179
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 06:53:51 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m37Krloq000356
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 16:53:47 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m37KrlCN249394
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 16:53:47 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m37Krln6005488
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 16:53:47 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1 of 3] [POWERPC 44x] Export tlb_44x_hwater for KVM
Message-Id: <d1804f03574745f4f8f5.1207601612@localhost.localdomain>
In-Reply-To: <patchbomb.1207601611@localhost.localdomain>
Date: Mon, 07 Apr 2008 15:53:32 -0500
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev@ozlabs.org, kvm-devel@lists.sourceforge.net
Cc: kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1 file changed, 2 insertions(+)
include/asm-powerpc/mmu-44x.h |    2 ++


PowerPC 440 KVM needs to know how many TLB entries are used for the host kernel
linear mapping (it does not modify these mappings when switching between guest
and host execution).

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

diff --git a/include/asm-powerpc/mmu-44x.h b/include/asm-powerpc/mmu-44x.h
--- a/include/asm-powerpc/mmu-44x.h
+++ b/include/asm-powerpc/mmu-44x.h
@@ -53,6 +53,8 @@
 
 #ifndef __ASSEMBLY__
 
+extern unsigned int tlb_44x_hwater;
+
 typedef unsigned long long phys_addr_t;
 
 typedef struct {
