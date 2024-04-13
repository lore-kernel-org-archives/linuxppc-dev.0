Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90840C4345F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2024 09:39:30 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=MjH6/odP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VGpL853msz3vbN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2024 19:39:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=MjH6/odP;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VGpKN1tR0z3cJl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2024 19:38:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713001128;
	bh=jPYPpXrOTdq14zbY1a5WM5rZP3IYtTcbIcNsjXlJspk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MjH6/odPeFgoAEfNG2rNSGt2thn4S+aADBoSLF86JXfv/dzzX80RNdWPYVPLWA4km
	 WABN2/vhWdwd4HsPSsxQNyWLQDu6QVoZfSOqmsukC9DZaJ0tj27yUlx4bgXQqGe+F6
	 7vE+canYaQukx6oxuedLYuJav6633yNYphxX7VCQoyIkzH+qRF7Pg0GQTWkWvhtGeC
	 TipxPPhkh9hRKBh6VFWbs16RXSaOOGQavzY0JWXgyoXZn8kw6AWo1ianMcDg4HVZWG
	 bMW6Uy37rKrath0YVIVn6h6nF4qu8QXvzFbrGlTW+nzI3LSrKdXLIihEZkUVcNx7C2
	 Znym4ghrFREwQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VGpKM2sTsz4wb2;
	Sat, 13 Apr 2024 19:38:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Sean Christopherson
 <seanjc@google.com>
Subject: Re: [PATCH 1/3] x86/cpu: Actually turn off mitigations by default
 for SPECULATION_MITIGATIONS=n
In-Reply-To: <87edb9d33r.fsf@mail.lhotse>
References: <20240409175108.1512861-1-seanjc@google.com>
 <20240409175108.1512861-2-seanjc@google.com>
 <20240413115324.53303a68@canb.auug.org.au> <87edb9d33r.fsf@mail.lhotse>
Date: Sat, 13 Apr 2024 19:38:47 +1000
Message-ID: <87bk6dd2l4.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org, Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <hca@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Josh Poimboeuf <jpoimboe@kernel.org>, Daniel Sneddon <daniel.sneddon@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
...
>> On Tue,  9 Apr 2024 10:51:05 -0700 Sean Christopherson <seanjc@google.com> wrote:
...
>>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>>> index 8f6affd051f7..07ad53b7f119 100644
>>> --- a/kernel/cpu.c
>>> +++ b/kernel/cpu.c
>>> @@ -3207,7 +3207,8 @@ enum cpu_mitigations {
>>>  };
>>>  
>>>  static enum cpu_mitigations cpu_mitigations __ro_after_init =
>>> -	CPU_MITIGATIONS_AUTO;
>>> +	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
>>> +						     CPU_MITIGATIONS_OFF;
>>>  
>>>  static int __init mitigations_parse_cmdline(char *arg)
>>>  {

I think a minimal workaround/fix would be:

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..290be2f9e909 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -191,6 +191,10 @@ config GENERIC_CPU_AUTOPROBE
 config GENERIC_CPU_VULNERABILITIES
        bool

+config SPECULATION_MITIGATIONS
+       def_bool y
+       depends on !X86
+
 config SOC_BUS
        bool
        select GLOB

cheers
