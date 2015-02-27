Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD13D1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 11:06:44 +1100 (AEDT)
Date: Thu, 26 Feb 2015 16:06:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-Id: <20150226160641.547657c397ecfee078779217@linux-foundation.org>
In-Reply-To: <CAGXu5jK0YbyL+Z=YrCfkfGbYz6=65Rr_MAXLwrF36gJa2Ce4_w@mail.gmail.com>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
 <20150227102136.17ef1fe6@canb.auug.org.au>
 <20150226153435.df670671fb10eb9efa0fa845@linux-foundation.org>
 <CAGXu5jK0YbyL+Z=YrCfkfGbYz6=65Rr_MAXLwrF36gJa2Ce4_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco Gisbert <hecmargi@upv.es>, LKML <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org\"
 <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List
 <linux-mips@linux-mips.org>,
 linuxppc-dev@lists.ozlabs.org"@localhost.localdomain,
 Ingo Molnar <mingo@kernel.org>, ismael Ripoll <iripoll@upv.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Feb 2015 15:37:37 -0800 Kees Cook <keescook@chromium.org> wrote:

> Agh, no, please let's avoid the CONFIG addition.

That is precisely how we do this.

> Hector mentioned in private mail that he was looking at an alternative
> that adds exec_base to struct mm which would avoid all this insanity.
> 
> Can't we do something like:
> 
> #ifndef mmap_rnd
> # define mmap_rnd 0
> #endif

Sure, and sprinkle

#define mmap_rnd mmap_rnd

in five arch header files where nobody thinks to look.

For better or for worse, we are consolidating such things into arch/*/Kconfig.
