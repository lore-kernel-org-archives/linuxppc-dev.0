Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A1781A0C65
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 20:06:23 +1100 (AEDT)
Date: Fri, 4 Dec 2015 10:06:20 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 8/9] Implement kernel live patching for ppc64le (ABIv2)
Message-ID: <20151204090620.GB2861@lst.de>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172937.9425E69260@newverein.lst.de>
 <20151203162445.GG8047@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151203162445.GG8047@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 03, 2015 at 05:24:45PM +0100, Petr Mladek wrote:
> > +++ b/arch/powerpc/include/asm/livepatch.h
> > @@ -0,0 +1,45 @@
> [...]
> > +#include <linux/module.h>
> > +#include <linux/ftrace.h>
> > +
> > +#ifdef CONFIG_LIVEPATCH
> > +static inline int klp_check_compiler_support(void)
> > +{
> > +#if !defined(_CALL_ELF) || _CALL_ELF != 2
> 
> I am just curious why we do not check CC_USING_MPROFILE_KERNEL
> like in the other similar locations. It would look less cryptic.
> But I am not sure if it is precise enough.

Because a ppc with a gcc > 4.8.5 is not sufficient. The code
currently only works for the PPC ELF ABI v2, a.k.a. ppc64le.
But now that you say it, CC_USING_MPROFILE_KERNEL should go
into that condition as well. Thanks!

	Torsten
