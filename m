Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B94F1A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 18:58:52 +1100 (AEDT)
Message-ID: <1457078325.20076.1.camel@ellerman.id.au>
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Petr Mladek <pmladek@suse.com>, linuxppc-dev@ozlabs.org
Cc: jeyu@redhat.com, jkosina@suse.cz, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, duwe@lst.de,
 live-patching@vger.kernel.org, mbenes@suse.cz, Torsten Duwe <duwe@suse.de>
Date: Fri, 04 Mar 2016 18:58:45 +1100
In-Reply-To: <1457023921-2051-1-git-send-email-pmladek@suse.com>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Petr,

On Thu, 2016-03-03 at 17:52 +0100, Petr Mladek wrote:

> From: Balbir Singh <bsingharora@gmail.com>
>
> Changelog v4:
> 	1. Renamed klp_matchaddr() to klp_get_ftrace_location()
> 	   and used it just to convert the function address.
> 	2. Synced klp_write_module_reloc() with s390(); made it
> 	   inline, no error message, return -ENOSYS

OK.

> 	3. Added an error message when including
> 	   powerpc/include/asm/livepatch.h without HAVE_LIVEPATCH

I don't know why we want to do that, I don't see how it is helpful. It doesn't
even do what it says:

> +#ifdef CONFIG_LIVEPATCH
...
> +#else /* CONFIG_LIVEPATCH */
> +#error Include linux/livepatch.h, not asm/livepatch.h
> +#endif /* CONFIG_LIVEPATCH */

If I turn on CONFIG_LIVEPATCH then I can quite happily include asm/livepatch.h
and not get an error. So the check doesn't do what the message suggests.

If we *really* want to prevent people from including asm/livepatch.h then it
needs to check for _LINUX_LIVEPATCH_H_. But there's no reason I can see why we
*must* prevent people from including asm/livepatch.h.

And on x86 & s390 it does:

  #else
  #error Live patching support is disabled; check CONFIG_LIVEPATCH
  #endif

Which is also not helpful AFAICS, and just likely to break the build for no
good reason.

> This applies on top of the patches posted by Michael
> https://patchwork.ozlabs.org/patch/589791/
>
> It enables livepatching. This takes patch 6/8 and 7/8 of v8 as the base.
> (See the reference [1] below) and adds logic for checking offset ranges
> in livepatch with ftrace_location_range.
>
> I tested the sample in the livepatch

Thanks.

cheers
