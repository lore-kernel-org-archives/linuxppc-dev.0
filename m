Return-Path: <linuxppc-dev+bounces-9683-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A33C77B7C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Jun 2025 20:45:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRcQS4NSnz2xlK;
	Wed, 25 Jun 2025 06:45:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750797904;
	cv=none; b=Wgfgyh5mlU00fvggc+XdYkWMGxmCVUWKddnORefIE30ivSklOYG0Rw3qigK7GZdAKHosv6N0bb4ZyjoIesevUnhwXH1It/bZag8G025G6BftE7q9BOuZIcnKo799gnG2XsqmIgraleXp5qrq5qaqY05olWM+Dd58Ug1dZ9VSTywjWn1mEGRmZjdF4oflCX9qyNq77GLGdmxzrhSFPpCwoEwgKPU4ls3ibA8oXygl4wZJI/v2zE6Gx93DFXWtBRKBQmhMVDNUd5DDyPrXKI6COO2Aihr3540IeqeJ0yyUkNnpRAW0hnM/z96aKN+d6Dc+58rIIoLhTV7TkrhZdaBhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750797904; c=relaxed/relaxed;
	bh=8BvU4zj5+vGvSjcwvRufRrQMsdxShsV/zYOy2q0blYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBr97gDY30+VKKxViwq1Oaptc2BAcJlOZ6r0f557SeQxG5XN5jRxxLdsqie6+xYkHrGCqidbwTK8WNT2bvU/oqo03e/l5fZtEXVquJ9Y/gboeVz873xi6QW0vE29P53q2Vys0l5X6wSqppfbWtWrYarlkCT/13vHt9fyDvQcgzUU7vCrvoYSge3r6JG3o/I63YqgQ6VjGn1VHjm1ZnQNtU/u2C4mB/dNtKH88l/iJ7ahpIM1OeiO8yCBy5EHjp9wj2/1sjYc8ZbpFWW8E+ukK58BF68s/ZkKZ7XlJmB6qNoKgGScaz+Ok5oDOWdNk9Tg2/PBfBVOmRIAzusH62Dn3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DdnrfDP1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DdnrfDP1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRcQR2QT5z2xHZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2025 06:45:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4A37C4A22E;
	Tue, 24 Jun 2025 20:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D80C4CEE3;
	Tue, 24 Jun 2025 20:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750797900;
	bh=AoFPMCIxkttPg56+0un4riAb99bPvrJcXHuKXirc4kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdnrfDP1H9mNBSpD5Y2HOlveUi/wqHGE06OJbvGfgz9LAgedeeFvamygl27k74DLg
	 z3wshVBWK9q1KHtT53hcQNy9dVSFLbDWB+b+9NhOzwT0OUGYBC7oCWwGP66REdulcR
	 ExUvcH/dJKv6VUs1oqrteB9roCwoHyjNFixHjaKU0GQxtk+tEWDi7zPhYYlHYGwpRV
	 AH5Qtf0XvLBOODaXlYkMBtEnvZHCbEpwgTE9Ypyt8oY/tYQ86nWLr99rpX+B/BdOVD
	 m6cOd7LPHkd71mK4yhsI+SD46i8WHOe2lEHsrccjP1jJXfvEbmhSnBUZog9qwAK75k
	 p0hUTMnVqPt5Q==
Date: Tue, 24 Jun 2025 23:44:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: update architecture and driver code to use
 vm_flags_t
Message-ID: <aFsOSL8hht-ZojTC@kernel.org>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <b6eb1894abc5555ece80bb08af5c022ef780c8bc.1750274467.git.lorenzo.stoakes@oracle.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6eb1894abc5555ece80bb08af5c022ef780c8bc.1750274467.git.lorenzo.stoakes@oracle.com>

On Wed, Jun 18, 2025 at 08:42:54PM +0100, Lorenzo Stoakes wrote:
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -279,7 +279,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
>  
>  static struct sgx_encl_page *sgx_encl_load_page_in_vma(struct sgx_encl *encl,
>  						       unsigned long addr,
> -						       unsigned long vm_flags)
> +						       vm_flags_t vm_flags)
>  {
>  	unsigned long vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
>  	struct sgx_encl_page *entry;
> @@ -520,9 +520,9 @@ static void sgx_vma_open(struct vm_area_struct *vma)
>   * Return: 0 on success, -EACCES otherwise
>   */
>  int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
> -		     unsigned long end, unsigned long vm_flags)
> +		     unsigned long end, vm_flags_t vm_flags)
>  {
> -	unsigned long vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
> +	vm_flags_t vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
>  	struct sgx_encl_page *page;
>  	unsigned long count = 0;
>  	int ret = 0;
> @@ -605,7 +605,7 @@ static int sgx_encl_debug_write(struct sgx_encl *encl, struct sgx_encl_page *pag
>   */
>  static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
>  						   unsigned long addr,
> -						   unsigned long vm_flags)
> +						   vm_flags_t vm_flags)
>  {
>  	struct sgx_encl_page *entry;
>  
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index f94ff14c9486..8ff47f6652b9 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -101,7 +101,7 @@ static inline int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
>  }
>  
>  int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
> -		     unsigned long end, unsigned long vm_flags);
> +		     unsigned long end, vm_flags_t vm_flags);
>  
>  bool current_is_ksgxd(void);
>  void sgx_encl_release(struct kref *ref);
 
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

