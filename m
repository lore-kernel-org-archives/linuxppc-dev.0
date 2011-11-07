Return-Path: <nacc@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 09BB51007D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 10:30:04 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@us.ibm.com>;
 Mon, 7 Nov 2011 16:30:01 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA7NTwP9129048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2011 16:29:58 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA7NTwgB021803
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2011 16:29:58 -0700
Date: Mon, 7 Nov 2011 15:29:56 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH] powerpc/kvm: annotate kvm_rma_init as __init
Message-ID: <20111107232956.GA20208@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kvm_rma_init() is only called at boot-time, by setup_arch, which is also __init.
    
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index d431203..73fdcc1 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -85,7 +85,7 @@ static inline int lpcr_rmls(unsigned long rma_size)
  * to allocate contiguous physical memory for the real memory
  * areas for guests.
  */
-void kvm_rma_init(void)
+void __init kvm_rma_init(void)
 {
 	unsigned long i;
 	unsigned long j, npages;

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
