Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B93C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:21:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C02D2075E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C02D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z8tY4Z6nzDqKK
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 02:21:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Z8rg1gWnzDqBb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 02:19:45 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 721BFA78;
 Wed,  3 Apr 2019 08:19:43 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88453F68F;
 Wed,  3 Apr 2019 08:19:37 -0700 (PDT)
Date: Wed, 3 Apr 2019 16:19:32 +0100
From: Will Deacon <will.deacon@arm.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
Message-ID: <20190403151932.GA16866@fuggles.cambridge.arm.com>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87tvff24a1.fsf@concordia.ellerman.id.au>
 <20190403111134.GA7159@fuggles.cambridge.arm.com>
 <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-mips@vger.kernel.org,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jens,

On Wed, Apr 03, 2019 at 07:49:26AM -0600, Jens Axboe wrote:
> On 4/3/19 5:11 AM, Will Deacon wrote:
> > will@autoplooker:~/liburing/test$ ./io_uring_register 
> > RELIMIT_MEMLOCK: 67108864 (67108864)
> > [   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> > [   35.478969] Mem abort info:
> > [   35.479296]   ESR = 0x96000004
> > [   35.479785]   Exception class = DABT (current EL), IL = 32 bits
> > [   35.480528]   SET = 0, FnV = 0
> > [   35.480980]   EA = 0, S1PTW = 0
> > [   35.481345] Data abort info:
> > [   35.481680]   ISV = 0, ISS = 0x00000004
> > [   35.482267]   CM = 0, WnR = 0
> > [   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> > [   35.483486] [0000000000000070] pgd=0000000000000000
> > [   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > [   35.484788] Modules linked in:
> > [   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
> > [   35.486712] Hardware name: linux,dummy-virt (DT)
> > [   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
> > [   35.488228] pc : link_pwq+0x10/0x60
> > [   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
> > [   35.489550] sp : ffff000017e2bbc0
> 
> Huh, this looks odd, it's crashing inside the wq setup.

Enabling KASAN seems to indicate a double-free, which may well be related.

Will

[  149.890370] ==================================================================
[  149.891266] BUG: KASAN: double-free or invalid-free in io_sqe_files_unregister+0xa8/0x140
[  149.892218] 
[  149.892411] CPU: 113 PID: 3974 Comm: io_uring_regist Tainted: G    B             5.1.0-rc3-00012-g40b114779944 #3
[  149.893623] Hardware name: linux,dummy-virt (DT)
[  149.894169] Call trace:
[  149.894539]  dump_backtrace+0x0/0x228
[  149.895172]  show_stack+0x14/0x20
[  149.895747]  dump_stack+0xe8/0x124
[  149.896335]  print_address_description+0x60/0x258
[  149.897148]  kasan_report_invalid_free+0x78/0xb8
[  149.897936]  __kasan_slab_free+0x1fc/0x228
[  149.898641]  kasan_slab_free+0x10/0x18
[  149.899283]  kfree+0x70/0x1f8
[  149.899798]  io_sqe_files_unregister+0xa8/0x140
[  149.900574]  io_ring_ctx_wait_and_kill+0x190/0x3c0
[  149.901402]  io_uring_release+0x2c/0x48
[  149.902068]  __fput+0x18c/0x510
[  149.902612]  ____fput+0xc/0x18
[  149.903146]  task_work_run+0xf0/0x148
[  149.903778]  do_notify_resume+0x554/0x748
[  149.904467]  work_pending+0x8/0x10
[  149.905060] 
[  149.905331] Allocated by task 3974:
[  149.905934]  __kasan_kmalloc.isra.0.part.1+0x48/0xf8
[  149.906786]  __kasan_kmalloc.isra.0+0xb8/0xd8
[  149.907531]  kasan_kmalloc+0xc/0x18
[  149.908134]  __kmalloc+0x168/0x248
[  149.908724]  __arm64_sys_io_uring_register+0x2b8/0x15a8
[  149.909622]  el0_svc_common+0x100/0x258
[  149.910281]  el0_svc_handler+0x48/0xc0
[  149.910928]  el0_svc+0x8/0xc
[  149.911425] 
[  149.911696] Freed by task 3974:
[  149.912242]  __kasan_slab_free+0x114/0x228
[  149.912955]  kasan_slab_free+0x10/0x18
[  149.913602]  kfree+0x70/0x1f8
[  149.914118]  __arm64_sys_io_uring_register+0xc2c/0x15a8
[  149.915009]  el0_svc_common+0x100/0x258
[  149.915670]  el0_svc_handler+0x48/0xc0
[  149.916317]  el0_svc+0x8/0xc
[  149.916817] 
[  149.917101] The buggy address belongs to the object at ffff8004ce07ed00
[  149.917101]  which belongs to the cache kmalloc-128 of size 128
[  149.919197] The buggy address is located 0 bytes inside of
[  149.919197]  128-byte region [ffff8004ce07ed00, ffff8004ce07ed80)
[  149.921142] The buggy address belongs to the page:
[  149.921953] page:ffff7e0013381f00 count:1 mapcount:0 mapping:ffff800503417c00 index:0x0 compound_mapcount: 0
[  149.923595] flags: 0x1ffff00000010200(slab|head)
[  149.924388] raw: 1ffff00000010200 dead000000000100 dead000000000200 ffff800503417c00
[  149.925706] raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
[  149.927011] page dumped because: kasan: bad access detected
[  149.927956] 
[  149.928224] Memory state around the buggy address:
[  149.929054]  ffff8004ce07ec00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
[  149.930274]  ffff8004ce07ec80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  149.931494] >ffff8004ce07ed00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  149.932712]                    ^
[  149.933281]  ffff8004ce07ed80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  149.934508]  ffff8004ce07ee00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  149.935725] ==================================================================
