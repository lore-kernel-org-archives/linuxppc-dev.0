Return-Path: <linuxppc-dev+bounces-16597-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F82E9D41E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 17:51:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5nwn30Hpz2xJ5;
	Thu, 05 Feb 2026 04:51:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770227513;
	cv=none; b=IL/vqRxJqElGwPmXxgYC0s2/qVT79bENjt/f/+JDTQhley7XgdYYQZRPn7D0SQGGaS85iv9pEXZE9MMhMH8EFDfO5LqFcXk6WqAiFMC5nD1ew2IYsF8ygS+h71cNqV03rt/bxh5yoDBugvxzvVSV/8sKEHjvgKS4EK6JL/WffK0PjgntPfqoDqF3f56bkk/gm3BO4hm4BnF/EEbVugPqv3OC+Oc31du7Gckt3Vp2oU3hijrDNbGzpqPC952WPILo7IQw7FdhIK+SqCAfp4OEKrB0GLvh4fivxzPBndGxt9NCRIRLG34Mc6E1jdy5G6/uW5lVPnmOz8+XsIIJitniTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770227513; c=relaxed/relaxed;
	bh=SI+heq64YP9+5g4kboLB5eo83jOiOIu1p++YEBS/B3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYvjluL5rHkVO81ktV4Ad8Z6/KYrawOgWNMjAHRTurLQHg8/1afRX6f2chhppbXd0iNK1YFGwJZtt2AE0sfmsluEkiKiXz/8EsPMfKf1xI0ljWuK4AMrgqn2/6Kp7lKeddYDxaWaWTIvHQBIKqzbovr4SMEb1CAl6qkvWbXIPRaRhVUY7UzKdNva4IfUipRU8q/iTdrWccXFnwlXFTH2eUXJpIbvDnINA6IPa/n/vSEVOexIYw9stMAtG3o8luICqXnKVbFykxdq2LvMA0LxosUu8m0fHfsoGmA61CAJ0XpBo4oPrKNVyqvBC9BOh//OCIJIS11KvsmpuqKiMVJKJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5nwm5xSJz2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 04:51:52 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 678371516;
	Wed,  4 Feb 2026 09:51:15 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EC233F778;
	Wed,  4 Feb 2026 09:51:18 -0800 (PST)
Date: Wed, 4 Feb 2026 17:51:15 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH 02/15] arm64: vDSO: compat_gettimeofday: Add explicit
 includes
Message-ID: <aYOHEzX4Djcui5vO@arm.com>
References: <20260114-vdso-header-cleanups-v1-0-803b80ee97b4@linutronix.de>
 <20260114-vdso-header-cleanups-v1-2-803b80ee97b4@linutronix.de>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114-vdso-header-cleanups-v1-2-803b80ee97b4@linutronix.de>

On Wed, Jan 14, 2026 at 09:01:34AM +0100, Thomas Weiﬂschuh wrote:
> The reference to VDSO_CLOCKMODE_ARCHTIMER requires vdso/clocksource.h and
> 'struct old_timespec32' requires vdso/time32.h. Currently these headers
> are included transitively, but those transitive inclusions are about to go
> away.
> 
> Explicitly include the headers.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

