Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E630C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 11:35:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31B4206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 11:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31B4206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z3sm5rcyzDqSg
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 22:35:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z3qb2lwvzDqP1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 22:33:29 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Apr 2019 04:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; d="scan'208";a="146236271"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2019 04:33:19 -0700
Received: from andy by smile with local (Exim 4.92)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1hBe8p-0001jQ-Nk; Wed, 03 Apr 2019 14:33:15 +0300
Date: Wed, 3 Apr 2019 14:33:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrey Abramov <st5pub@yandex.ru>
Subject: Re: [PATCH v3 5/5] Lib: sort.h: remove the size argument from the
 swap function
Message-ID: <20190403113315.GW9224@smile.fi.intel.com>
References: <824481554237711@sas1-23a37bc8251c.qloud-c.yandex.net>
 <793311554238525@sas1-87f9feb8d943.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793311554238525@sas1-87f9feb8d943.qloud-c.yandex.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: peterz <peterz@infradead.org>, Dave Chinner <dchinner@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "yamada.masahiro" <yamada.masahiro@socionext.com>, paulus <paulus@samba.org>,
 hpa <hpa@zytor.com>, jslaby <jslaby@suse.cz>, sfr <sfr@canb.auug.org.au>,
 "darrick.wong" <darrick.wong@oracle.com>, richard <richard@nod.at>,
 mark <mark@fasheh.com>, x86 <x86@kernel.org>, mingo <mingo@redhat.com>,
 "naveen.n.rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-snps-arc <linux-snps-arc@lists.infradead.org>, jannh <jannh@google.com>,
 bp <bp@alien8.de>, jlbec <jlbec@evilplan.org>, jpoimboe <jpoimboe@redhat.com>,
 tglx <tglx@linutronix.de>, George Spelvin <lkml@sdf.org>,
 dedekind1 <dedekind1@gmail.com>, vgupta <vgupta@synopsys.com>,
 "ard.biesheuvel" <ard.biesheuvel@linaro.org>,
 "adrian.hunter" <adrian.hunter@intel.com>, gregkh <gregkh@linuxfoundation.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Morton Andrew <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 ocfs2-devel <ocfs2-devel@oss.oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 02, 2019 at 11:55:25PM +0300, Andrey Abramov wrote:
> Removes size argument from the swap function because:
> 	1) It wasn't used.
> 	2) Custom swap function knows what kind of objects it swaps,
> 		so it already knows their sizes.
> 
> Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
> Reviewed by: George Spelvin <lkml@sdf.org>

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>  arch/x86/kernel/unwind_orc.c | 2 +-
>  include/linux/sort.h         | 2 +-
>  kernel/jump_label.c          | 2 +-
>  lib/extable.c                | 2 +-
>  lib/sort.c                   | 7 +++----
>  5 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 89be1be1790c..dc410b567189 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -176,7 +176,7 @@ static struct orc_entry *orc_find(unsigned long ip)
>  	return orc_ftrace_find(ip);
>  }
>  
> -static void orc_sort_swap(void *_a, void *_b, int size)
> +static void orc_sort_swap(void *_a, void *_b)
>  {
>  	struct orc_entry *orc_a, *orc_b;
>  	struct orc_entry orc_tmp;
> diff --git a/include/linux/sort.h b/include/linux/sort.h
> index 2b99a5dd073d..13bb4635b5f1 100644
> --- a/include/linux/sort.h
> +++ b/include/linux/sort.h
> @@ -6,6 +6,6 @@
>  
>  void sort(void *base, size_t num, size_t size,
>  	  int (*cmp)(const void *, const void *),
> -	  void (*swap)(void *, void *, int));
> +	  void (*swap)(void *, void *));
>  
>  #endif
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index bad96b476eb6..6b1187b8a060 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -45,7 +45,7 @@ static int jump_label_cmp(const void *a, const void *b)
>  	return 0;
>  }
>  
> -static void jump_label_swap(void *a, void *b, int size)
> +static void jump_label_swap(void *a, void *b)
>  {
>  	long delta = (unsigned long)a - (unsigned long)b;
>  	struct jump_entry *jea = a;
> diff --git a/lib/extable.c b/lib/extable.c
> index f54996fdd0b8..0515a94538ca 100644
> --- a/lib/extable.c
> +++ b/lib/extable.c
> @@ -28,7 +28,7 @@ static inline unsigned long ex_to_insn(const struct exception_table_entry *x)
>  #ifndef ARCH_HAS_RELATIVE_EXTABLE
>  #define swap_ex		NULL
>  #else
> -static void swap_ex(void *a, void *b, int size)
> +static void swap_ex(void *a, void *b)
>  {
>  	struct exception_table_entry *x = a, *y = b, tmp;
>  	int delta = b - a;
> diff --git a/lib/sort.c b/lib/sort.c
> index 50855ea8c262..8704750e6bde 100644
> --- a/lib/sort.c
> +++ b/lib/sort.c
> @@ -114,7 +114,7 @@ static void swap_bytes(void *a, void *b, size_t n)
>  	} while (n);
>  }
>  
> -typedef void (*swap_func_t)(void *a, void *b, int size);
> +typedef void (*swap_func_t)(void *a, void *b);
>  
>  /*
>   * The values are arbitrary as long as they can't be confused with
> @@ -138,7 +138,7 @@ static void do_swap(void *a, void *b, size_t size, swap_func_t swap_func)
>  	else if (swap_func == SWAP_BYTES)
>  		swap_bytes(a, b, size);
>  	else
> -		swap_func(a, b, (int)size);
> +		swap_func(a, b);
>  }
>  
>  /**
> @@ -186,8 +186,7 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
>   * it less suitable for kernel use.
>   */
>  void sort(void *base, size_t num, size_t size,
> -	  int (*cmp_func)(const void *, const void *),
> -	  void (*swap_func)(void *, void *, int size))
> +	  int (*cmp_func)(const void *, const void *), swap_func_t swap_func)
>  {
>  	/* pre-scale counters for performance */
>  	size_t n = num * size, a = (num/2) * size;
> -- 
> 2.21.0
> 
> 

-- 
With Best Regards,
Andy Shevchenko


