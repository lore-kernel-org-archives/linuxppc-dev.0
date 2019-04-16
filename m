Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD8C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 11:43:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E7B20675
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 11:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E7B20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k3Qg0pbrzDqJm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 21:43:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=catalin.marinas@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44k3NW5BVWzDqDc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 21:41:14 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC77EBD;
 Tue, 16 Apr 2019 04:41:12 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 7FF603F68F; Tue, 16 Apr 2019 04:41:06 -0700 (PDT)
Date: Tue, 16 Apr 2019 12:41:04 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [v2] arch: add pidfd and io_uring syscalls everywhere
Message-ID: <20190416114103.GB28994@arrakis.emea.arm.com>
References: <20190415143007.2989285-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415143007.2989285-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>,
 Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <jhogan@kernel.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, linux-alpha@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 15, 2019 at 04:22:57PM +0200, Arnd Bergmann wrote:
> Add the io_uring and pidfd_send_signal system calls to all architectures.
> 
> These system calls are designed to handle both native and compat tasks,
> so all entries are the same across architectures, only arm-compat and
> the generic tale still use an old format.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> (s390)
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes since v1:
> - fix s390 table
> - use 'n64' tag in mips-n64 instead of common.
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      | 4 ++++
>  arch/arm/tools/syscall.tbl                  | 4 ++++
>  arch/arm64/include/asm/unistd.h             | 2 +-
>  arch/arm64/include/asm/unistd32.h           | 8 ++++++++
>  arch/ia64/kernel/syscalls/syscall.tbl       | 4 ++++
>  arch/m68k/kernel/syscalls/syscall.tbl       | 4 ++++
>  arch/microblaze/kernel/syscalls/syscall.tbl | 4 ++++
>  arch/mips/kernel/syscalls/syscall_n32.tbl   | 4 ++++
>  arch/mips/kernel/syscalls/syscall_n64.tbl   | 4 ++++
>  arch/mips/kernel/syscalls/syscall_o32.tbl   | 4 ++++
>  arch/parisc/kernel/syscalls/syscall.tbl     | 4 ++++
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 4 ++++
>  arch/s390/kernel/syscalls/syscall.tbl       | 4 ++++
>  arch/sh/kernel/syscalls/syscall.tbl         | 4 ++++
>  arch/sparc/kernel/syscalls/syscall.tbl      | 4 ++++
>  arch/xtensa/kernel/syscalls/syscall.tbl     | 4 ++++
>  16 files changed, 65 insertions(+), 1 deletion(-)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
