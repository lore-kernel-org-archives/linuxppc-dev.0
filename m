Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54132C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 07:55:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C262073F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 07:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBg4Q0pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C262073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jyN73PkmzDqHH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=jikos@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="FBg4Q0pI"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jyKv0YYpzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 17:53:38 +1000 (AEST)
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A70F2073F;
 Tue, 16 Apr 2019 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1555401216;
 bh=ONqeZcRHRT/O4g4lf7ZcpK42MxCIqizXMac+tt9gYaY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=FBg4Q0pIZL9TzwGBeYNIsctEvSg9Xx1zDVoIJ8BBPSImdhijx5iyU5zfnuznvWNaW
 GgsIOlz1u2GnfLehgDY/RZ4KUFg838OqNk+mpm0X3nkfHreLYfzrN4t//RYhmSTgIi
 yM2b4pHeeElMHPiKlio78LPNCpf28uUgF10x+Ogs=
Date: Tue, 16 Apr 2019 09:53:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 0/5] cpu/speculation: Add 'mitigations=' cmdline option
In-Reply-To: <cover.1555085500.git.jpoimboe@redhat.com>
Message-ID: <nycvar.YFH.7.76.1904160952410.9803@cbobk.fhfr.pm>
References: <cover.1555085500.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Steven Price <steven.price@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Phil Auld <pauld@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 12 Apr 2019, Josh Poimboeuf wrote:

> v2:
> - docs improvements: [Randy, Michael]
> - Rename to "mitigations=" [Michael]
> - Add cpu_mitigations_off() function wrapper [Michael]
> - x86: Simplify logic [Boris]
> - powerpc: Fix no_rfi_flush checking bug (use '&&' instead of '||')
> - arm64: Rebase onto Jeremy Linton's v7 patches [Will]
> - arm64: "kpti command line option" [Steve P]
> - arm64: Add nospectre_v2 support
> 
> -----------
> 
> Keeping track of the number of mitigations for all the CPU speculation
> bugs has become overwhelming for many users.  It's getting more and more
> complicated to decide which mitigations are needed for a given
> architecture.  Complicating matters is the fact that each arch tends to
> have its own custom way to mitigate the same vulnerability.
> 
> Most users fall into a few basic categories:
> 
> a) they want all mitigations off;
> 
> b) they want all reasonable mitigations on, with SMT enabled even if
>    it's vulnerable; or
> 
> c) they want all reasonable mitigations on, with SMT disabled if
>    vulnerable.
> 
> Define a set of curated, arch-independent options, each of which is an
> aggregation of existing options:
> 
> - mitigations=off: Disable all mitigations.
> 
> - mitigations=auto: [default] Enable all the default mitigations, but
>   leave SMT enabled, even if it's vulnerable.
> 
> - mitigations=auto,nosmt: Enable all the default mitigations, disabling
>   SMT if needed by a mitigation.
> 
> Josh Poimboeuf (5):
>   cpu/speculation: Add 'mitigations=' cmdline option
>   x86/speculation: Support 'mitigations=' cmdline option
>   powerpc/speculation: Support 'mitigations=' cmdline option
>   s390/speculation: Support 'mitigations=' cmdline option
>   arm64/speculation: Support 'mitigations=' cmdline option

Tested-by: Jiri Kosina <jkosina@suse.cz> (on x86)
Reviewed-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

