Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F64C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 09:37:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F007A20830
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 09:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F007A20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XnLp3XchzDqMb
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 20:37:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XnK91b0QzDqKZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 20:36:09 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Apr 2019 02:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; d="scan'208";a="138963625"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by orsmga003.jf.intel.com with ESMTP; 01 Apr 2019 02:35:56 -0700
Received: from andy by smile with local (Exim 4.92)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1hAtMB-0003Wz-1k; Mon, 01 Apr 2019 12:35:55 +0300
Date: Mon, 1 Apr 2019 12:35:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrey Abramov <st5pub@yandex.ru>
Subject: Re: [PATCH v2 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Message-ID: <20190401093555.GD9224@smile.fi.intel.com>
References: <19606671554056883@myt3-1179f584969c.qloud-c.yandex.net>
 <23051461554058370@iva6-3ac3de5fcc31.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23051461554058370@iva6-3ac3de5fcc31.qloud-c.yandex.net>
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

On Sun, Mar 31, 2019 at 09:52:50PM +0300, Andrey Abramov wrote:
> Replace int type with size_t type of the size argument
> in the swap function, also affect all its dependencies.
> 
> It's always been weird that sort() takes a size_t element size,
> but passes an int size to (*swap)(). Not a bug because we don't
> sort objects >2GB large, but it's ugly.

Hmm... If (*swap)() is called recursively it means the change might increase
stack usage on 64-bit platforms.

Am I missing something?

> 
> Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
> Reviewed by: George Spelvin <lkml@sdf.org>
> ---
>  arch/x86/kernel/unwind_orc.c | 2 +-
>  include/linux/sort.h         | 2 +-
>  kernel/jump_label.c          | 2 +-
>  lib/extable.c                | 2 +-
>  lib/sort.c                   | 6 +++---
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 89be1be1790c..1078c287198c 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -176,7 +176,7 @@ static struct orc_entry *orc_find(unsigned long ip)
>  	return orc_ftrace_find(ip);
>  }
>  
> -static void orc_sort_swap(void *_a, void *_b, int size)
> +static void orc_sort_swap(void *_a, void *_b, size_t size)
>  {
>  	struct orc_entry *orc_a, *orc_b;
>  	struct orc_entry orc_tmp;
> diff --git a/include/linux/sort.h b/include/linux/sort.h
> index 2b99a5dd073d..aea39d552ff7 100644
> --- a/include/linux/sort.h
> +++ b/include/linux/sort.h
> @@ -6,6 +6,6 @@
>  
>  void sort(void *base, size_t num, size_t size,
>  	  int (*cmp)(const void *, const void *),
> -	  void (*swap)(void *, void *, int));
> +	  void (*swap)(void *, void *, size_t));
>  
>  #endif
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index bad96b476eb6..340b788571fb 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -45,7 +45,7 @@ static int jump_label_cmp(const void *a, const void *b)
>  	return 0;
>  }
>  
> -static void jump_label_swap(void *a, void *b, int size)
> +static void jump_label_swap(void *a, void *b, size_t size)
>  {
>  	long delta = (unsigned long)a - (unsigned long)b;
>  	struct jump_entry *jea = a;
> diff --git a/lib/extable.c b/lib/extable.c
> index f54996fdd0b8..db2888342cd7 100644
> --- a/lib/extable.c
> +++ b/lib/extable.c
> @@ -28,7 +28,7 @@ static inline unsigned long ex_to_insn(const struct exception_table_entry *x)
>  #ifndef ARCH_HAS_RELATIVE_EXTABLE
>  #define swap_ex		NULL
>  #else
> -static void swap_ex(void *a, void *b, int size)
> +static void swap_ex(void *a, void *b, size_t size)
>  {
>  	struct exception_table_entry *x = a, *y = b, tmp;
>  	int delta = b - a;
> diff --git a/lib/sort.c b/lib/sort.c
> index 50855ea8c262..60fbbc29104a 100644
> --- a/lib/sort.c
> +++ b/lib/sort.c
> @@ -114,7 +114,7 @@ static void swap_bytes(void *a, void *b, size_t n)
>  	} while (n);
>  }
>  
> -typedef void (*swap_func_t)(void *a, void *b, int size);
> +typedef void (*swap_func_t)(void *a, void *b, size_t size);
>  
>  /*
>   * The values are arbitrary as long as they can't be confused with
> @@ -138,7 +138,7 @@ static void do_swap(void *a, void *b, size_t size, swap_func_t swap_func)
>  	else if (swap_func == SWAP_BYTES)
>  		swap_bytes(a, b, size);
>  	else
> -		swap_func(a, b, (int)size);
> +		swap_func(a, b, size);
>  }
>  
>  /**
> @@ -187,7 +187,7 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
>   */
>  void sort(void *base, size_t num, size_t size,
>  	  int (*cmp_func)(const void *, const void *),
> -	  void (*swap_func)(void *, void *, int size))
> +	  void (*swap_func)(void *, void *, size_t size))
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


