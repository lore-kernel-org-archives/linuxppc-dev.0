Return-Path: <SRS0=I3TE=5Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D638C2D0EA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2020 13:59:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BF62072A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2020 13:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BF62072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48y5W65F6SzDqWf
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2020 23:59:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=sina.com (client-ip=202.108.3.164;
 helo=mail3-164.sinamail.sina.com.cn; envelope-from=hdanton@sina.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sina.com
X-Greylist: delayed 129 seconds by postgrey-1.36 at bilbo;
 Wed, 08 Apr 2020 22:51:22 AEST
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn
 [202.108.3.164])
 by lists.ozlabs.org (Postfix) with SMTP id 48y40B08kkzDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2020 22:51:16 +1000 (AEST)
Received: from unknown (HELO localhost.localdomain)([114.246.227.120])
 by sina.com with ESMTP
 id 5E8DC8290002A7AA; Wed, 8 Apr 2020 20:48:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 82000715073508
From: Hillf Danton <hdanton@sina.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/28] staging: android: ion: use vmap instead of
 vm_map_ram
Date: Wed,  8 Apr 2020 20:48:33 +0800
Message-Id: <20200408124833.13032-1-hdanton@sina.com>
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On Wed,  8 Apr 2020 13:59:00 +0200
> 
> vm_map_ram can keep mappings around after the vm_unmap_ram.  Using that
> with non-PAGE_KERNEL mappings can lead to all kinds of aliasing issues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/staging/android/ion/ion_heap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
> index 473b465724f1..a2d5c6df4b96 100644
> --- a/drivers/staging/android/ion/ion_heap.c
> +++ b/drivers/staging/android/ion/ion_heap.c
> @@ -99,12 +99,12 @@ int ion_heap_map_user(struct ion_heap *heap, struct ion_buffer *buffer,
>  
>  static int ion_heap_clear_pages(struct page **pages, int num, pgprot_t pgprot)
>  {
> -	void *addr = vm_map_ram(pages, num, -1, pgprot);
> +	void *addr = vmap(pages, num, VM_MAP);

A merge glitch?

void *vmap(struct page **pages, unsigned int count,
	   unsigned long flags, pgprot_t prot)
>  
>  	if (!addr)
>  		return -ENOMEM;
>  	memset(addr, 0, PAGE_SIZE * num);
> -	vm_unmap_ram(addr, num);
> +	vunmap(addr);
>  
>  	return 0;
>  }
> -- 
> 2.25.1

