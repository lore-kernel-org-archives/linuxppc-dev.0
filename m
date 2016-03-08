Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F407E1A005D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 08:43:04 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (smtprelay0253.hostedemail.com
 [216.40.44.253])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 68D94140327
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 08:43:03 +1100 (AEDT)
Date: Tue, 8 Mar 2016 16:42:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 duwe@lst.de, linux-kernel@vger.kernel.org, kamalesh@linux.vnet.ibm.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz, Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160308164256.5979e42f@gandalf.local.home>
In-Reply-To: <1457023921-2051-1-git-send-email-pmladek@suse.com>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  3 Mar 2016 17:52:01 +0100
Petr Mladek <pmladek@suse.com> wrote:

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
> 
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

For the changes to the ftrace files, add my:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

You can take the rest.

-- Steve


>  9 files changed, 171 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/livepatch.h
>  create mode 100644 arch/powerpc/kernel/livepatch.c
> 


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


> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 57a6eea84694..f4e6aae6ebe7 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1533,7 +1533,19 @@ static int ftrace_cmp_recs(const void *a, const void *b)
>  	return 0;
>  }
>  
> -static unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> +/**
> + * ftrace_location_range - return the first address of a traced location
> + *	if it touches the given ip range
> + * @start: start of range to search.
> + * @end: end of range to search (inclusive). @end points to the last byte
> + *	to check.
> + *
> + * Returns rec->ip if the related ftrace location is a least partly within
> + * the given address range. That is, the first address of the instruction
> + * that is either a NOP or call to the function tracer. It checks the ftrace
> + * internal tables to determine if the address belongs or not.
> + */
> +unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>  {
>  	struct ftrace_page *pg;
>  	struct dyn_ftrace *rec;
