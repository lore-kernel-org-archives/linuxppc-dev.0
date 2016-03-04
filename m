Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D0B41A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 19:06:41 +1100 (AEDT)
Message-ID: <1457078800.20076.4.camel@ellerman.id.au>
Subject: How to merge? (was Re: [PATCH][v4] livepatch/ppc: Enable
 livepatching on powerpc)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Petr Mladek <pmladek@suse.com>, linuxppc-dev@ozlabs.org
Cc: jeyu@redhat.com, jkosina@suse.cz, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, duwe@lst.de,
 live-patching@vger.kernel.org, mbenes@suse.cz, Torsten Duwe <duwe@suse.de>,
 jikos@kernel.org, vojtech@suse.com, jpoimboe@redhat.com,
 sjenning@redhat.com
Date: Fri, 04 Mar 2016 19:06:40 +1100
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

Hi livepatch maintainers,

On Thu, 2016-03-03 at 17:52 +0100, Petr Mladek wrote:
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
>  9 files changed, 171 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/livepatch.h
>  create mode 100644 arch/powerpc/kernel/livepatch.c


How should we go about merging this?

Obviously it depends heavily on the content of my series, which will go into
powerpc#next, so it would make sense if this went there too.

I don't see any changes in linux-next for livepatch, so merging it via powerpc
would probably work fine and not cause any conflicts, unless there's some
livepatch changes pending for 4.6 that aren't in linux-next yet?

The other option is that I put my ftrace changes and this in a topic branch
(based on v4.5-rc3), and then that can be merged into both powerpc#next and the
livepatch tree.

Also regardless of who takes it an Ack from Steve for the ftrace changes would
be good.

cheers
