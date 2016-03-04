Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A05C1A0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 17:09:07 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BD8341402DE
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 17:09:06 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:38:34 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2468Ht247513696
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 11:38:18 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2468LWj001141
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 11:38:24 +0530
Date: Fri, 4 Mar 2016 11:38:12 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Petr Mladek <pmladek@suse.com>
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz,
 Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160304060811.GA30681@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1457023921-2051-1-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Petr Mladek <pmladek@suse.com> [2016-03-03 17:52:01]:

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

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

I tried it, with the sample livepatch module.

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>



Thanks,
Kamalesh.
