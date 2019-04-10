Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE0CC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:08:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6422070D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6422070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fDHF22zVzDqMv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 16:08:25 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fDFT0RJdzDqKq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 16:06:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44fDFQ5M3vz9s7T;
 Wed, 10 Apr 2019 16:06:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
In-Reply-To: <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
Date: Wed, 10 Apr 2019 16:06:50 +1000
Message-ID: <87pnpuwg05.fsf@concordia.ellerman.id.au>
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Josh Poimboeuf <jpoimboe@redhat.com> writes:
> Configure powerpc CPU runtime speculation bug mitigations in accordance
> with the 'cpu_spec_mitigations=' cmdline options.  This affects
> Meltdown, Spectre v1, Spectre v2, and Speculative Store Bypass.
>
> The default behavior is unchanged.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
>  arch/powerpc/kernel/security.c                  | 6 +++---
>  arch/powerpc/kernel/setup_64.c                  | 2 +-
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 29dc03971630..0e8eae1e8a25 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2552,10 +2552,11 @@
>  
>  			off
>  				Disable all speculative CPU mitigations.
> -				Equivalent to: nopti [x86]
> +				Equivalent to: nopti [x86, powerpc]
> +					       nospectre_v1 [powerpc]
>  					       nospectre_v2 [x86]

Not sure if you meant to omit powerpc from nospectre_v2?

You have patched it in the code below.

>  					       spectre_v2_user=off [x86]
> -					       spec_store_bypass_disable=off [x86]
> +					       spec_store_bypass_disable=off [x86, powerpc]
>  					       l1tf=off [x86]
>  
>  			auto (default)
> @@ -2568,7 +2569,7 @@
>  				Equivalent to: pti=auto [x86]
>  					       spectre_v2=auto [x86]
>  					       spectre_v2_user=auto [x86]
> -					       spec_store_bypass_disable=auto [x86]
> +					       spec_store_bypass_disable=auto [x86, powerpc]
>  					       l1tf=flush [x86]
>  
>  			auto,nosmt
> @@ -2579,7 +2580,7 @@
>  				Equivalent to: pti=auto [x86]
>  					       spectre_v2=auto [x86]
>  					       spectre_v2_user=auto [x86]
> -					       spec_store_bypass_disable=auto [x86]
> +					       spec_store_bypass_disable=auto [x86, powerpc]
>  					       l1tf=flush,nosmt [x86]
>  
>  	mminit_loglevel=
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> index b33bafb8fcea..5aed4ad729ba 100644
> --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -57,7 +57,7 @@ void setup_barrier_nospec(void)
>  	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
>  		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
>  
> -	if (!no_nospec)
> +	if (!no_nospec && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
>  		enable_barrier_nospec(enable);

Adding a wrapper func that checks for CPU_SPEC_MITIGATIONS_OFF would
make these a little less verbose, eg:

	if (!no_nospec && !cpu_spec_mitigations_off())
  		enable_barrier_nospec(enable);

But that's a nitpick.

> @@ -116,7 +116,7 @@ static int __init handle_nospectre_v2(char *p)
>  early_param("nospectre_v2", handle_nospectre_v2);
>  void setup_spectre_v2(void)
>  {
> -	if (no_spectrev2)
> +	if (no_spectrev2 || cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
>  		do_btb_flush_fixups();
>  	else
>  		btb_flush_enabled = true;
> @@ -300,7 +300,7 @@ void setup_stf_barrier(void)
>  
>  	stf_enabled_flush_types = type;
>  
> -	if (!no_stf_barrier)
> +	if (!no_stf_barrier && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
>  		stf_barrier_enable(enable);
>  }
>  
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index ba404dd9ce1d..d9d796a66a79 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -932,7 +932,7 @@ void setup_rfi_flush(enum l1d_flush_type types, bool enable)
>  
>  	enabled_flush_types = types;
>  
> -	if (!no_rfi_flush)
> +	if (!no_rfi_flush || cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
>  		rfi_flush_enable(enable);
>  }

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
