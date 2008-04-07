Return-Path: <hollisb@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5A46DE1B5
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 06:53:51 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m37KrmvS008189
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 16:53:48 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m37Krmue241058
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 16:53:48 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m37KrlNI005501
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 16:53:47 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 2 of 3] [KVM] Add DCR access information to struct kvm_run
Message-Id: <474b35009da7b7bdb58c.1207601613@localhost.localdomain>
In-Reply-To: <patchbomb.1207601611@localhost.localdomain>
Date: Mon, 07 Apr 2008 15:53:33 -0500
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

1 file changed, 7 insertions(+)
include/linux/kvm.h |    7 +++++++


Device Control Registers are essentially another address space found on PowerPC
4xx processors, analogous to PIO on x86. DCRs are always 32 bits, and are
identified by a 32-bit number. We forward DCR accesses to userspace for
emulation.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

diff --git a/include/linux/kvm.h b/include/linux/kvm.h
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -76,6 +76,7 @@
 #define KVM_EXIT_TPR_ACCESS       12
 #define KVM_EXIT_S390_SIEIC       13
 #define KVM_EXIT_S390_RESET       14
+#define KVM_EXIT_DCR              15
 
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
@@ -155,6 +156,12 @@
 #define KVM_S390_RESET_CPU_INIT  8
 #define KVM_S390_RESET_IPL       16
 		__u64 s390_reset_flags;
+		/* KVM_EXIT_DCR */
+		struct {
+			__u32 dcrn;
+			__u32 data;
+			__u8  is_write;
+		} dcr;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
