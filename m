Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AA606A319
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=wS32jOje
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9Z1l3rymz2y2J;
	Fri, 23 Oct 2026 05:10:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792692603;
	cv=none; b=mnxFKCxtxRkURw2mU19o82zc6eZTsPIOvmj1UnrrWto2/DZ8oS6kCQxk/W7Gqkl4NAFiLPVCvGJAJCpSEu3YuepszGn+/OoyJs8xQptDpOzoHgFqFBC/KG4M359PJkDSVhT9YPW7uFZM3RBTYtjXzSETplAJFGNrcKp3jeSr57yhO5ya4RIbtewPrh2Z3wy3oY0AhlmLNe2ReAbM85BCW+BQIfN5iPixy+MMT8rGF4ivqyTFYpEY1E2+9jNSN1V6LdEvVXFedPrR/hw1mQLWA1AXppJ9ndeYEeC+nbw/aaQXaU1snmUoj9KtPKZlIUvermacZif4pDrmIGLs/yxrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792692603; c=relaxed/relaxed;
	bh=RhnfvKmfoxy+HUbDsORpInOXf0Z9ck2xlJJLmjkZQrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkZsr4299ONagoIsXVAeQNecRZFJVl3ECJ131hcuDXDqbT8GZNROSdHmfNMd91u6HQTIfE00tgTm7xw+f+RKuPsyneffAgoCRAmTThAb72psAwj0DBqERHzLicCw/p/gQwxrNVXvQkW+Ai4NXDaFqR3lrV8fwtYCKHV055LF7sdf+E5UL3DoI2RdGu5ulJoIVWyfBOieBTTGeGZyZ1K/+wSMWRtD0ly58gEjsN4Ruvn9bf/KfpR2F4XAXJBQ9CgoKptFBdtyxQ83cfBxckbVPXRkra0h8wySbyumJFmWaxFnhJN0H15CMEsqfAuxEU+nw1NPs4jHsegxyVnZ1GBRcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=wS32jOje; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=wS32jOje;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 327 seconds by postgrey-1.37 at boromir; Fri, 23 Oct 2026 05:10:00 AEDT
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9Z1h47FSz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 05:10:00 +1100 (AEDT)
Received: from [172.27.3.124] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69MI2jre822700
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 22 Oct 2026 11:02:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69MI2jre822700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792692174;
	bh=RhnfvKmfoxy+HUbDsORpInOXf0Z9ck2xlJJLmjkZQrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wS32jOjeFWsFEs7/XC2lmhjx+vaso38Aa1yvVUAkT9A1W3myWjPjlKJ97J5iL0Ywq
	 bPF69gGCe7jooHw6vT1puqfAAMWwIenPVsBB0BtjXDHBnYwO13DlDPhjiEozTqjEHM
	 Tnne7bJIubMKnpcLaITiN/m+5GZf8SNZmR76JFs4RsiRgOXjXb7KnOu57Xbk4+jf0R
	 res/2bYXDI5YQACu5N7auw0s2PeA2biV4pFQrygkfChnNdCyphEU5uiDFSgPKPiKVV
	 mrz+yPrxO0ZpIXSlYj8frGR29U2PsHFm2Ceilf5VQYeo3Indd2RWAuBubWzuARjG4V
	 DyvcySggronVQ==
Message-ID: <9d875fab-fdad-413e-9737-6160fac2a406@zytor.com>
Date: Thu, 22 Oct 2026 11:00:24 -0700
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra
 <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org> <20261022142425.3Wx-RrU5@linutronix.de>
 <20261022150235.V2CSdtmu@linutronix.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20261022150235.V2CSdtmu@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22 08:02, Sebastian Andrzej Siewior wrote:
> On 2026-10-22 16:24:30 [+0200], To Thomas Gleixner wrote:
>> The test could be updated via the hunk below in case the new behaviour
>> is what is expected. hpa made the extension to the test in commit
>> 795e2a023b808 ("selftests/x86/syscall: Add tests under ptrace to
>> syscall_numbering_64").
>>
>> diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
>> index ca0eca7b9dced..1435394fba022 100644
>> --- a/tools/testing/selftests/x86/syscall_numbering.c
>> +++ b/tools/testing/selftests/x86/syscall_numbering.c
> 
> Now I notice the fix depends on CONFIG_X86_X32_ABI=y (fails for =n).
> But we want to get rid of it anyway so…
> CONFIG_IA32_EMULATION is not affected (with the fix).
> 
It would be very simple to probe for by issuing a simple system call like
getppid() with the x32 bit set.

	-hpa


