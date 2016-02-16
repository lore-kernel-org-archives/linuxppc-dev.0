Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1BB01A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 16:47:28 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 11:17:24 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G5l2Qj32702710
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 11:17:04 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G5lDHu014675
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 11:17:14 +0530
Date: Tue, 16 Feb 2016 11:17:02 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Torsten Duwe <duwe@lst.de>, Jiri Kosina <jkosina@suse.cz>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace location
 during build
Message-ID: <20160216054701.GA20570@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174517.8347D692C8@newverein.lst.de>
 <1455293609.16012.9.camel@gmail.com>
 <20160212164517.GO12548@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160212164517.GO12548@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Petr Mladek <pmladek@suse.com> [2016-02-12 17:45:17]:

[...]
> I guess that you used a broken gcc and cheated the check
> to pass the compilation. Did you, please?
> 
> The test used to detect the offset is using a minimalistic
> function is is afftected by the gcc bug.
> 
> The patch below might be used to cheat the offset check as well.
> 
> Torsten, please mention this somewhere if you, just by chance,
> send a new version of the patchset.
> 
> From f6a438a3f2f60cc1acc859b41d0cc9259c9a331e Mon Sep 17 00:00:00 2001
> From: root <root@c79.arch.suse.de>
> Date: Tue, 2 Feb 2016 15:35:06 +0100
> Subject: [PATCH 2/2] livepatch: Make sure the TOC is handled when detecting
>  ftrace location
> 
> There seems to be a bug in gcc on PPC. It does not handle TOC
> if the function does not access global variables or functions
> by default. But it should when profiling is enabled.
> 
> This patch works around this problem by adding a call
> to a global function.
> 
> This patch is for testing only!
> ---
>  kernel/livepatch/ftrace-test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/livepatch/ftrace-test.c b/kernel/livepatch/ftrace-test.c
> index 22f0c54bf7b3..a3b7aabb67e5 100644
> --- a/kernel/livepatch/ftrace-test.c
> +++ b/kernel/livepatch/ftrace-test.c
> @@ -1,6 +1,9 @@
>  /* Sample code to figure out mcount location offset */
> +#include <linux/printk.h>
> +
>  
>  int test(int a)
>  {
> +	printk("%d\n", a);
>  	return ++a;
>  }

Thanks. This workaround, helped to load sample livepatch module.

Thanks,
Kamalesh.
