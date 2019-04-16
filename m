Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F190DC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7312720872
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7312720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kBhl1nClzDqGW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 03:10:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44kBfn4qdkzDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 03:09:03 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976F280D;
 Tue, 16 Apr 2019 10:09:02 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41583F59C;
 Tue, 16 Apr 2019 10:08:59 -0700 (PDT)
Date: Tue, 16 Apr 2019 18:08:57 +0100
From: Will Deacon <will.deacon@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v2 5/5] kselftest: Extend vDSO selftest to clock_getres
Message-ID: <20190416170857.GC7342@fuggles.cambridge.arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-6-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416161434.32691-6-vincenzo.frascino@arm.com>
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linux-kselftest@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Greentime Hu <green.hu@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 16, 2019 at 05:14:34PM +0100, Vincenzo Frascino wrote:
> The current version of the multiarch vDSO selftest verifies only
> gettimeofday.
> 
> Extend the vDSO selftest to clock_getres, to verify that the
> syscall and the vDSO library function return the same information.
> 
> The extension has been used to verify the hrtimer_resoltion fix.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  tools/testing/selftests/vDSO/Makefile         |   2 +
>  .../selftests/vDSO/vdso_clock_getres.c        | 108 ++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c

Assuming this will go via Shuah's tree.

Will
