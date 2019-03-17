Return-Path: <SRS0=npwJ=RU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A08C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 22:07:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842FA2087C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 22:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lb3u8a6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842FA2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MtjC5tPVzDqHX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 09:07:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="lb3u8a6p"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MtgS3rqZzDqLy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 09:06:09 +1100 (AEDT)
Received: by mail-qk1-x741.google.com with SMTP id c20so3803967qkc.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=IcWacMfHF/AVn0k21ppx7/coY7WOvCyg2dM8iR4NJXs=;
 b=lb3u8a6pPVm8uoNsiHm5xunrfvg339f1A6zuVExgsvlk9TxKL7iwpSWadBnhT4yEVc
 j03Y2HrKwWQgLmr6JuGYlkM6jOlHsfwb7UxkXT41uHcrUIoSvjzbZH5UqzS41htO+H50
 nLrNYFN4oZLh54fQp6k3C72Z4hnvjzKCL/mHmtoB3FvMdzGoC4HM5B/IgEeGRFiWOXR8
 K18GEfFWmPnQuqI68PhPfc8sCVbYSs43UP03OqdK2DDeeEEQZgKyYm2hH2ThtWOFVPsm
 XR/pKlUjmJ+bCEdzYSwj8OmNWsI7+2Z27SnG4fChJVR5fPkg3S2xLcS9vj7mK/iDDydj
 kiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=IcWacMfHF/AVn0k21ppx7/coY7WOvCyg2dM8iR4NJXs=;
 b=TL6H+g6incH5CqqwxwTdcv7XoV/i/Qz9OAzRwLGU9/5SIup87IdsdtIQp0I6oibH0U
 j7yoP74H3VA2DWjLArNm9jY97nevuo1dzEnh6u7ZY4flolOgD3+jZYa7mQXWVKXwJVCP
 54xs6gKuidWrId5ZHtqoZLV9OvmoHYCdg9iiGEZ/NIFQEADDsmHtui5lAz9OctEP0Oo+
 xPdPV8B9EK783ixc6jJkZBC+gbxw0rhgLfE2qBjAxoxkrUEX8F8VdY7lUQ+jg82u52qS
 BZtAbeOyR3DAFppMguKH6B9nY2xyfwFndXANbYGwJsfel0oiAg+M7R9DXkqBIn+2xrCh
 38cQ==
X-Gm-Message-State: APjAAAXI08qGGu7q+JA7TA49wVL4LA/BYDoBTimpifav++fXrLBMVOJj
 R8MTkzy94mFfKM9iFmUQVLhoWQ==
X-Google-Smtp-Source: APXvYqxfYLcIq0OWqTUdqZV1k4PcSOCNVkvQqMCLCRcSu2rH8enduAxIzpi0NgtRFm6Q0+zQWaDN3g==
X-Received: by 2002:a37:4b4e:: with SMTP id y75mr10734924qka.158.1552860366714; 
 Sun, 17 Mar 2019 15:06:06 -0700 (PDT)
Received: from ovpn-116-105.phx2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id x29sm5339984qtm.74.2019.03.17.15.06.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Mar 2019 15:06:06 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org,
	paulus@samba.org
Subject: [RESEND PATCH v2] powerpc: mute unused-but-set-variable warnings
Date: Sun, 17 Mar 2019 18:05:16 -0400
Message-Id: <20190317220516.92654-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

pte_unmap() compiles away on some powerpc platforms, so silence the
warnings below by making it a static inline function.

mm/memory.c: In function 'copy_pte_range':
mm/memory.c:820:24: warning: variable 'orig_dst_pte' set but not used
[-Wunused-but-set-variable]
mm/memory.c:820:9: warning: variable 'orig_src_pte' set but not used
[-Wunused-but-set-variable]
mm/madvise.c: In function 'madvise_free_pte_range':
mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]
mm/swap_state.c: In function 'swap_ra_info':
mm/swap_state.c:634:15: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by:: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: make it a static inline function.

 arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
 arch/powerpc/include/asm/nohash/64/pgtable.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 868fcaf56f6b..d798e33a0c86 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1006,7 +1006,8 @@ extern struct page *pgd_page(pgd_t pgd);
 	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+
+static inline void pte_unmap(pte_t *pte) { }
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index e77ed9761632..0384a3302fb6 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -205,7 +205,8 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
   (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+
+static inline void pte_unmap(pte_t *pte) { }
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
-- 
2.17.2 (Apple Git-113)

