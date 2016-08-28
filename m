Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMhMv6DnwzDrff
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 03:19:07 +1000 (AEST)
Subject: [PATCH 1/6] KVM: PPC: e500: Use kmalloc_array() in
 kvm_vcpu_ioctl_config_tlb()
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Mackerras <paulus@samba.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <317e0112-55cc-cc91-100f-bc5e301dbe76@users.sourceforge.net>
Date: Sun, 28 Aug 2016 19:12:57 +0200
MIME-Version: 1.0
In-Reply-To: <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 28 Aug 2016 16:30:07 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kvm/e500_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 29911a0..26f3737 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -779,7 +779,7 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 
 	num_pages = DIV_ROUND_UP(cfg->array + array_len - 1, PAGE_SIZE) -
 		    cfg->array / PAGE_SIZE;
-	pages = kmalloc(sizeof(struct page *) * num_pages, GFP_KERNEL);
+	pages = kmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
 
-- 
2.9.3
