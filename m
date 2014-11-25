Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1EA71A0287
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 22:43:41 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 11:43:37 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2AC9017D8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 11:43:51 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAPBhZYx51511372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 11:43:35 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAPBhZbL005698
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 04:43:35 -0700
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [RFC 1/2] powerpc/fsl-pci: atomic get_user when pagefault_disabled
Date: Tue, 25 Nov 2014 12:43:25 +0100
Message-Id: <1416915806-24757-2-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, dahi@linux.vnet.ibm.com,
 paulus@samba.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whenever we have pagefaults disabled, we have to use the atomic variants of
(set|get)_user and copy_(from|to)_user.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 65d2ed4..c0af4ef 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1025,7 +1025,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 	if (is_in_pci_mem_space(addr)) {
 		if (user_mode(regs)) {
 			pagefault_disable();
-			ret = get_user(regs->nip, &inst);
+			ret = __get_user_inatomic(regs->nip, &inst);
 			pagefault_enable();
 		} else {
 			ret = probe_kernel_address(regs->nip, inst);
-- 
1.8.5.5
