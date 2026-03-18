Return-Path: <linuxppc-dev+bounces-18351-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAE4103E160
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 11:51:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbRy42wb8z2ygd;
	Wed, 18 Mar 2026 22:51:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773834716;
	cv=none; b=e+TvNsWq5jkgluDZR2SR09MRkqjnjfqYZLjmfhVg47nL8LYqgbHAnW8qgnD6+YGjw8Myv55OqZV1sn8w7+5kG1JY3va2kptcx9GOJ3cD4Mpc3nrNhn8Wiqr/v9Alz3+e0m9PSirHoPcOFbjzabqSF+IfxZf3IsCbRSf++5T+2yOK0tmsZ0QxqAxZKRKTxLkANnqjDpONyd6zr47ImcDEPavQfnX3XIdzrG/uXhJXxPsZFphfrhVOwyrUg3yLTNAvVwK+c7V4vDif+/7er33J0R9auJWZDDwy2XG7smTndeLaHJ9CqwPS6rnYSLmKkORK0q/n2LVBeiIkzxo42uM1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773834716; c=relaxed/relaxed;
	bh=afzruJUIHhjRgEtR8G9CKa7Vip21g2rH702voM+cpf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXTWYhc1l7agX7qUCE1k1I/zeMvGTnbQatVS5jv0trGq4BfZ8vzT9boKutxU8LEmnwnSuxOanudie931Q95YmW7zUE/vPWDyDgi3wpOpniH8NmEim+wVTlg4prtQV8Q+a2wKThuk1acg/p3Gl6/ARnIoJp7cjKTrPg7Mvah//LT9R0LVy/s+nhZl580aoTrMMd9RCRa04ykpKwOxHUfFHXQYLc/oCIehgXw6Reze8X2dyXtrlOdtemO5AzgJV+7TmyNzA3ODGZM7KAqnhil1crKJfEGJDonWx1zbQ/irnqywRQ23Eml8lcifZ34HLsSkEKWU8Q4s0VzvjRc/3fYAxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbRy31GKtz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 22:51:54 +1100 (AEDT)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 62IBpPiG963920;
	Wed, 18 Mar 2026 06:51:25 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 62IBpO97963917;
	Wed, 18 Mar 2026 06:51:24 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 18 Mar 2026 06:51:24 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Geoff Levand <geoff@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH RESEND 1/2] powerpc/ps3: Drop redundant result assignment
Message-ID: <abqRvDiAI85w2bCe@gate>
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>

On Tue, Mar 17, 2026 at 02:08:24PM +0100, Krzysztof Kozlowski wrote:
> Return value of ps3_start_probe_thread() is not used, so code can be
> simplified to fix W=1 clang warnings:
> 
>   arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]

And this is exactly why -Werror is harmful.  A boring harmless warning
turned into a build break :-(

You can sometimes usefully turn *some* warnings into errors, and any
user is of course free to invite as much pain as he or she wants to
bear, but heaping nonsense like this onto unsuspecting users is just
evil.  And it is even worse when the warnings can change with compiler
version!


Segher

