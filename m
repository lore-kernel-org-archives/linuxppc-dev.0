Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMDXR10ZQzDrmy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 21:25:59 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id y192so2257248pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 04:25:59 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v1 3/3] arch/powerpc/net/bpf: Basic EBPF support
Date: Tue,  1 Aug 2017 21:25:35 +1000
Message-Id: <20170801112535.20765-4-bsingharora@gmail.com>
In-Reply-To: <20170801112535.20765-1-bsingharora@gmail.com>
References: <20170801112535.20765-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 861c5af..d81110e 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1054,6 +1054,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	fp->jited = 1;
 	fp->jited_len = alloclen;
 
+	bpf_jit_binary_lock_ro(bpf_hdr);
 	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE));
 
 out:
@@ -1064,15 +1065,3 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 
 	return fp;
 }
-
-/* Overriding bpf_jit_free() as we don't set images read-only. */
-void bpf_jit_free(struct bpf_prog *fp)
-{
-	unsigned long addr = (unsigned long)fp->bpf_func & PAGE_MASK;
-	struct bpf_binary_header *bpf_hdr = (void *)addr;
-
-	if (fp->jited)
-		bpf_jit_binary_free(bpf_hdr);
-
-	bpf_prog_unlock_free(fp);
-}
-- 
2.9.4
