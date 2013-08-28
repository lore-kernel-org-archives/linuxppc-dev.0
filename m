Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D36F2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 18:50:12 +1000 (EST)
Received: by mail-pd0-f178.google.com with SMTP id w10so6031252pde.37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 01:50:10 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v9 10/13] KVM: PPC: remove warning from kvmppc_core_destroy_vm
Date: Wed, 28 Aug 2013 18:49:57 +1000
Message-Id: <1377679797-3744-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
References: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3S KVM implements in-kernel TCE tables via kvmppc_spapr_tce_table
structs list (created per KVM). Entries in the list are per LIOBN
(logical bus number) and have a TCE table so DMA hypercalls (such as
H_PUT_TCE) can convert LIOBN to a TCE table.

The entry in the list is created via KVM_CREATE_SPAPR_TCE ioctl which
returns an anonymous fd. This fd is used to map the TCE table to the user
space and it also defines the lifetime of the TCE table in the kernel.
Every list item also hold the link to KVM so when KVM is about to be
destroyed, all kvmppc_spapr_tce_table objects are expected to be
released and removed from the global list. And this is what the warning
verifies.

The upcoming support of VFIO IOMMU will extend kvmppc_spapr_tce_table use.
Unlike emulated devices, it will create kvmppc_spapr_tce_table structs
via new KVM device API which opens an anonymous fd
(as KVM_CREATE_SPAPR_TCE) but the release callback does not call
KVM Device's destroy callback immediately. Instead, KVM devices destruction
is postponed this till KVM destruction but this happens after arch-specific
KVM destroy function so the warning does a false alarm.

This removes the warning as it never happens in real life and there is no
any obvious place to put it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 9e823ad..5f15ff7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1974,7 +1974,6 @@ void kvmppc_core_destroy_vm(struct kvm *kvm)
 	kvmppc_rtas_tokens_free(kvm);
 
 	kvmppc_free_hpt(kvm);
-	WARN_ON(!list_empty(&kvm->arch.spapr_tce_tables));
 }
 
 /* These are stubs for now */
-- 
1.8.4.rc4
