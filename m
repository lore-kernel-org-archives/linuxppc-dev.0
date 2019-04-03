Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A920C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 11:13:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70C02084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 11:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70C02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z3Nc27MQzDqQ9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 22:13:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Z3Lf5DlvzDqND
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 22:11:49 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D030B80D;
 Wed,  3 Apr 2019 04:11:46 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201A33F59C;
 Wed,  3 Apr 2019 04:11:40 -0700 (PDT)
Date: Wed, 3 Apr 2019 12:11:34 +0100
From: Will Deacon <will.deacon@arm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, axboe@kernel.dk
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
Message-ID: <20190403111134.GA7159@fuggles.cambridge.arm.com>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87tvff24a1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvff24a1.fsf@concordia.ellerman.id.au>
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

Hi Michael,

On Wed, Apr 03, 2019 at 01:47:50PM +1100, Michael Ellerman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> > index b18abb0c3dae..00f5a63c8d9a 100644
> > --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> > +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> > @@ -505,3 +505,7 @@
> >  421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
> >  422	32	futex_time64			sys_futex			sys_futex
> >  423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
> > +424	common	pidfd_send_signal		sys_pidfd_send_signal
> > +425	common	io_uring_setup			sys_io_uring_setup
> > +426	common	io_uring_enter			sys_io_uring_enter
> > +427	common	io_uring_register		sys_io_uring_register
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
> Lightly tested.
> 
> The pidfd_test selftest passes.

That reports pass for me too, although it fails to unshare the pid ns, which I
assume is benign.

> Ran the io_uring example from fio, which prints lots of:

How did you invoke that? I had a play with the tests in:

  git://git.kernel.dk/liburing

but I quickly ran into the kernel oops below.

Will

--->8

will@autoplooker:~/liburing/test$ ./io_uring_register 
RELIMIT_MEMLOCK: 67108864 (67108864)
[   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
[   35.478969] Mem abort info:
[   35.479296]   ESR = 0x96000004
[   35.479785]   Exception class = DABT (current EL), IL = 32 bits
[   35.480528]   SET = 0, FnV = 0
[   35.480980]   EA = 0, S1PTW = 0
[   35.481345] Data abort info:
[   35.481680]   ISV = 0, ISS = 0x00000004
[   35.482267]   CM = 0, WnR = 0
[   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
[   35.483486] [0000000000000070] pgd=0000000000000000
[   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   35.484788] Modules linked in:
[   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
[   35.486712] Hardware name: linux,dummy-virt (DT)
[   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
[   35.488228] pc : link_pwq+0x10/0x60
[   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
[   35.489550] sp : ffff000017e2bbc0
[   35.490088] x29: ffff000017e2bbc0 x28: ffff8004b9118000 
[   35.490939] x27: 0000000000000000 x26: ffff8004c21c4200 
[   35.491786] x25: 0000000000000004 x24: ffff00001123e1b0 
[   35.492640] x23: ffff8004c5390000 x22: ffff8004bb440500 
[   35.493502] x21: ffff8004bb440500 x20: 0000000000000070 
[   35.494355] x19: 0000000000000022 x18: 0000000000000000 
[   35.495202] x17: 0000000000000000 x16: 0000000000000000 
[   35.496054] x15: 0000000000000000 x14: ffff7e0012e8a240 
[   35.496910] x13: 00004a73a5e663e2 x12: 0000000000000000 
[   35.497764] x11: 0000000000000001 x10: 0000000000000070 
[   35.498611] x9 : ffff8004cb49d610 x8 : 00000000ffffffff 
[   35.499462] x7 : ffff8004c4ff9c70 x6 : ffff8004cb49ccb0 
[   35.500308] x5 : ffff8004c66cc4c0 x4 : 0000000000000001 
[   35.501173] x3 : 0000000000000000 x2 : 0000000000000040 
[   35.502019] x1 : 0000000000000004 x0 : 0000000000000000 
[   35.502872] Process io_uring_regist (pid: 3973, stack limit = 0x(____ptrval____))
[   35.504052] Call trace:
[   35.504463]  link_pwq+0x10/0x60
[   35.504987]  apply_wqattrs_commit+0xe0/0x118
[   35.505681]  apply_workqueue_attrs_locked+0x3c/0x80
[   35.506460]  apply_workqueue_attrs+0x3c/0x60
[   35.507152]  alloc_workqueue+0x264/0x430
[   35.507786]  io_uring_setup+0x478/0x6a8
[   35.508414]  __arm64_sys_io_uring_setup+0x18/0x20
[   35.509183]  el0_svc_common+0x80/0xf0
[   35.509786]  el0_svc_handler+0x2c/0x80
[   35.510393]  el0_svc+0x8/0xc
[   35.510873] Code: a9bd7bfd 910003fd a90153f3 9101c014 (f9403802) 
[   35.511843] ---[ end trace 0a53e45ee26def4c ]---
Segmentation fault
