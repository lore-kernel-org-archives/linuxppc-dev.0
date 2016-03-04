Return-Path: <jpoimboe@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FA6F1A0BAB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 08:56:18 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 27B61140291
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2016 08:56:17 +1100 (AEDT)
Date: Fri, 4 Mar 2016 15:56:14 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, jeyu@redhat.com, jkosina@suse.cz,
 live-patching@vger.kernel.org, mbenes@suse.cz, Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160304215614.GB8104@treble.redhat.com>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1457023921-2051-1-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Petr,

On Thu, Mar 03, 2016 at 05:52:01PM +0100, Petr Mladek wrote:
> From: Balbir Singh <bsingharora@gmail.com>
> 
> Changelog v4:
> 	1. Renamed klp_matchaddr() to klp_get_ftrace_location()
> 	   and used it just to convert the function address.
> 	2. Synced klp_write_module_reloc() with s390(); made it
> 	   inline, no error message, return -ENOSYS
> 	3. Added an error message when including
> 	   powerpc/include/asm/livepatch.h without HAVE_LIVEPATCH
> 	4. Update some comments.
> Changelog v3:
> 	1. Moved -ENOSYS to -EINVAL in klp_write_module_reloc
> 	2. Moved klp_matchaddr to use ftrace_location_range
> Changelog v2:
> 	1. Implement review comments by Michael
> 	2. The previous version compared _NIP from the
> 	   wrong location to check for whether we
> 	   are going to a patched location
> 
> This applies on top of the patches posted by Michael
> https://patchwork.ozlabs.org/patch/589791/
> 
> It enables livepatching. This takes patch 6/8 and 7/8 of v8 as the base.
> (See the reference [1] below) and adds logic for checking offset ranges
> in livepatch with ftrace_location_range.
> 
> I tested the sample in the livepatch

This commit message needs a rewrite.  Most of the above information can
be moved to the diffstat section so it doesn't end up in the git log.
The log itself should be a straightforward description of the changes in
the patch itself.

> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/powerpc/Kconfig                 |  3 +++
>  arch/powerpc/include/asm/livepatch.h | 47 +++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/Makefile         |  1 +
>  arch/powerpc/kernel/entry_64.S       | 50 ++++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/livepatch.c      | 29 +++++++++++++++++++++
>  include/linux/ftrace.h               |  1 +
>  include/linux/livepatch.h            |  2 ++
>  kernel/livepatch/core.c              | 28 +++++++++++++++++---
>  kernel/trace/ftrace.c                | 14 +++++++++-
>  9 files changed, 171 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/livepatch.h
>  create mode 100644 arch/powerpc/kernel/livepatch.c
[...]
> diff --git a/arch/powerpc/kernel/livepatch.c b/arch/powerpc/kernel/livepatch.c
> new file mode 100644
> index 000000000000..267ce0fdd89b
> --- /dev/null
> +++ b/arch/powerpc/kernel/livepatch.c
> @@ -0,0 +1,29 @@
> +/*
> + * livepatch.c - powerpc-specific Kernel Live Patching Core
> + *
> + * Copyright (C) 2015 SUSE
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/ftrace.h>
> +#include <asm/livepatch.h>
> +
> +/*
> + * LivePatch works only with -mprofile-kernel on PPC. In this case,
> + * the ftrace location is always within the first 16 bytes.
> + */

No need for use CamelCase for LivePatch :-)

> +unsigned long klp_get_ftrace_location(unsigned long faddr)
> +{
> +	return ftrace_location_range(faddr, faddr + 16);
> +}
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index c2b340e23f62..fb13cd3e68f9 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -455,6 +455,7 @@ int ftrace_update_record(struct dyn_ftrace *rec, int enable);
>  int ftrace_test_record(struct dyn_ftrace *rec, int enable);
>  void ftrace_run_stop_machine(int command);
>  unsigned long ftrace_location(unsigned long ip);
> +unsigned long ftrace_location_range(unsigned long start, unsigned long end);
>  unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec);
>  unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec);
>  
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index a8828652f794..25a267bcb01f 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -134,6 +134,8 @@ int klp_unregister_patch(struct klp_patch *);
>  int klp_enable_patch(struct klp_patch *);
>  int klp_disable_patch(struct klp_patch *);
>  
> +unsigned long klp_get_ftrace_location(unsigned long faddr);
> +
>  #endif /* CONFIG_LIVEPATCH */
>  
>  #endif /* _LINUX_LIVEPATCH_H_ */
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index bc2c85c064c1..9ad597faa57f 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -298,22 +298,39 @@ unlock:
>  	rcu_read_unlock();
>  }
>  
> +/*
> + * Convert a function address into the appropriate ftrace location.
> + *
> + * The given address is returned on most architectures. LivePatching
> + * usually works only when the ftrace location is the first instruction
> + * in the function.
> + */

s/LivePatching/Live patching/

Otherwise the livepatch changes look good to me.

-- 
Josh
