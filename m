Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB5C10F06
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31452206DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31452206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z9YR4qWyzDqJ7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 02:51:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Z9Vc2qByzDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 02:49:12 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFD1380D;
 Wed,  3 Apr 2019 08:49:10 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1BC33F68F;
 Wed,  3 Apr 2019 08:49:04 -0700 (PDT)
Date: Wed, 3 Apr 2019 16:49:02 +0100
From: Will Deacon <will.deacon@arm.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
Message-ID: <20190403154902.GB16866@fuggles.cambridge.arm.com>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87tvff24a1.fsf@concordia.ellerman.id.au>
 <20190403111134.GA7159@fuggles.cambridge.arm.com>
 <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
 <20190403151932.GA16866@fuggles.cambridge.arm.com>
 <032faa2f-6317-75b6-8514-076ef1a244e8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032faa2f-6317-75b6-8514-076ef1a244e8@kernel.dk>
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

On Wed, Apr 03, 2019 at 09:39:52AM -0600, Jens Axboe wrote:
> On 4/3/19 9:19 AM, Will Deacon wrote:
> > On Wed, Apr 03, 2019 at 07:49:26AM -0600, Jens Axboe wrote:
> >> On 4/3/19 5:11 AM, Will Deacon wrote:
> >>> will@autoplooker:~/liburing/test$ ./io_uring_register 
> >>> RELIMIT_MEMLOCK: 67108864 (67108864)
> >>> [   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> >>> [   35.478969] Mem abort info:
> >>> [   35.479296]   ESR = 0x96000004
> >>> [   35.479785]   Exception class = DABT (current EL), IL = 32 bits
> >>> [   35.480528]   SET = 0, FnV = 0
> >>> [   35.480980]   EA = 0, S1PTW = 0
> >>> [   35.481345] Data abort info:
> >>> [   35.481680]   ISV = 0, ISS = 0x00000004
> >>> [   35.482267]   CM = 0, WnR = 0
> >>> [   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> >>> [   35.483486] [0000000000000070] pgd=0000000000000000
> >>> [   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> >>> [   35.484788] Modules linked in:
> >>> [   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
> >>> [   35.486712] Hardware name: linux,dummy-virt (DT)
> >>> [   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
> >>> [   35.488228] pc : link_pwq+0x10/0x60
> >>> [   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
> >>> [   35.489550] sp : ffff000017e2bbc0
> >>
> >> Huh, this looks odd, it's crashing inside the wq setup.
> > 
> > Enabling KASAN seems to indicate a double-free, which may well be related.
> 
> Does this help?

Yes, thanks for the quick patch. Feel free to add:

Reported-by: Will Deacon <will.deacon@arm.com>
Tested-by: Will Deacon <will.deacon@arm.com>

if you spin a proper patch.

Will

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index bbdbd56cf2ac..07d6ef195d05 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2215,6 +2215,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
>  			fput(ctx->user_files[i]);
>  
>  		kfree(ctx->user_files);
> +		ctx->user_files = NULL;
>  		ctx->nr_user_files = 0;
>  		return ret;
>  	}
> 
> -- 
> Jens Axboe
> 
