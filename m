Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com
 [IPv6:2a00:1450:400c:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A30BC1A0C7F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 18:39:12 +1100 (AEDT)
Received: by mail-wi0-f169.google.com with SMTP id em10so25159792wid.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 23:39:09 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 24 Feb 2015 08:39:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Hector Marco Gisbert <hecmargi@upv.es>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-ID: <20150224073906.GA16422@gmail.com>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150223205436.15133mg1kpyojyik@webmail.upv.es>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Kees Cook <keescook@chromium.org>, "x86@kernel.org" <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, ismael Ripoll <iripoll@upv.es>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Hector Marco Gisbert <hecmargi@upv.es> wrote:

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + brk_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

That pointless repetition should be avoided.

Thanks,

	Ingo
