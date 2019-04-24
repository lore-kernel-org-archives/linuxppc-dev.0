Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A6BC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C081921909
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bVeZzqyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C081921909
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q6WW5ryfzDqY6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 03:19:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="bVeZzqyv"; 
 dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q6NC2B8QzDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:13:29 +1000 (AEST)
Received: by mail-ot1-x341.google.com with SMTP id d24so14106956otl.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YZeSR7Aq2N3w70JEnXehtiOMPIO6rUu44DEBTQu+WpA=;
 b=bVeZzqyvtMg15/SBGydnDu1sXE6MZGRTmM2pih0vek44kQ5MId0FnVGWw8pRW9DqTX
 susgUEtmP3XX5dNw/C5QC7xeWgf9Ebqi93lYw94PFApni0MtwW6QTlj4cRoFXfNvPus8
 6MfCk27RfL410sz3Nhpeu4z2YEQqI5Q9xtpYKJH55HLvipT5F2eANwQMcD/LktuRs8O1
 lwW9ZuhSPLPpsaTe40pd3tMM0EX5JraP6nthTyqFTJXXXqXBhT58nq1glsmP0uALnl2h
 fYnHxV4KsEvOJaeZdKgshSlj5+S5KxuA5tRMe3+XCQgl64KHuzrAiwRUJOcrVv4z2n7s
 vEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YZeSR7Aq2N3w70JEnXehtiOMPIO6rUu44DEBTQu+WpA=;
 b=HLOLJUkIcCU/lWnYnNuGAWJGhZGqyyDClUVTjwSp8HVt6UujSJWH5bBKG2N6hqT57T
 mYKGqBdmT/qRM5sXFQRGkV5nmqS5SgiY8imDgf1hRm7A9MhI5F4ghxCCK1KN29Riir0B
 yii9HZiVqXe7ei4T8sb0RHfLJiQPIBf7GHehnKZeA7Q0GON1veq8m3mb5N0aLUyGB61p
 8IWwROAKwc2MaVkkwANGz4C8TtYCD5wVHIpRggCVaQXUXXco+ugYuDH+wgQb4XJwshFA
 8CcGtwnqMFRaommPYW7h9Z7Wr7UuKmJ093QXQTFLpH5MH7iBKhAGnAVOzLBg9mWC5ZIj
 RLrw==
X-Gm-Message-State: APjAAAUfEveKdW00GmnW3J2WFhBebb3o1kysvJvCOn48DfcucqlJTaGb
 vpV4B3VyB+mqGpPoZOT2sryHtD+vRF3nvYcZQGIgjA==
X-Google-Smtp-Source: APXvYqzn34MhQI1QA5M+++qBzaGXTmfd/hleC1MMSfBitQmWj6xxPvxkYHEvfFH6xTpugoQEtfYFKXxMawNxKlCVUTM=
X-Received: by 2002:a9d:19ed:: with SMTP id k100mr1957702otk.214.1556126006611; 
 Wed, 24 Apr 2019 10:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190402115125.18803-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190402115125.18803-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Apr 2019 10:13:15 -0700
Message-ID: <CAPcyv4hzRj5yxVJ5-7AZgzzBxEL02xf2xwhDv-U9_osWFm9kiA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix modifying of page protection by
 insert_pfn_pmd()
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Chandan Rajendra <chandan@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 2, 2019 at 4:51 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> With some architectures like ppc64, set_pmd_at() cannot cope with
> a situation where there is already some (different) valid entry present.
>
> Use pmdp_set_access_flags() instead to modify the pfn which is built to
> deal with modifying existing PMD entries.
>
> This is similar to
> commit cae85cb8add3 ("mm/memory.c: fix modifying of page protection by insert_pfn()")
>
> We also do similar update w.r.t insert_pfn_pud eventhough ppc64 don't support
> pud pfn entries now.
>
> Without this patch we also see the below message in kernel log
> "BUG: non-zero pgtables_bytes on freeing mm:"
>
> CC: stable@vger.kernel.org
> Reported-by: Chandan Rajendra <chandan@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> Changes from v1:
> * Fix the pgtable leak
>
>  mm/huge_memory.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

This patch is triggering the following bug in v4.19.35.

 kernel BUG at arch/x86/mm/pgtable.c:515!
 invalid opcode: 0000 [#1] SMP NOPTI
 CPU: 51 PID: 43713 Comm: java Tainted: G           OE     4.19.35 #1
 RIP: 0010:pmdp_set_access_flags+0x48/0x50
 [..]
 Call Trace:
  vmf_insert_pfn_pmd+0x198/0x350
  dax_iomap_fault+0xe82/0x1190
  ext4_dax_huge_fault+0x103/0x1f0
  ? __switch_to_asm+0x40/0x70
  __handle_mm_fault+0x3f6/0x1370
  ? __switch_to_asm+0x34/0x70
  ? __switch_to_asm+0x40/0x70
  handle_mm_fault+0xda/0x200
  __do_page_fault+0x249/0x4f0
  do_page_fault+0x32/0x110
  ? page_fault+0x8/0x30
  page_fault+0x1e/0x30

I asked the reporter to try a kernel with commit c6f3c5ee40c1
"mm/huge_memory.c: fix modifying of page protection by
insert_pfn_pmd()" reverted and the failing test passed.

I think unaligned addresses have always been passed to
vmf_insert_pfn_pmd(), but nothing cared until this patch. I *think*
the only change needed is the following, thoughts?

diff --git a/fs/dax.c b/fs/dax.c
index ca0671d55aa6..82aee9a87efa 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1560,7 +1560,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct
vm_fault *vmf, pfn_t *pfnp,
                }

                trace_dax_pmd_insert_mapping(inode, vmf, PMD_SIZE, pfn, entry);
-               result = vmf_insert_pfn_pmd(vma, vmf->address, vmf->pmd, pfn,
+               result = vmf_insert_pfn_pmd(vma, pmd_addr, vmf->pmd, pfn,
                                            write);
                break;
        case IOMAP_UNWRITTEN:


I'll ask the reporter to try this fix as well.
