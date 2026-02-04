Return-Path: <linuxppc-dev+bounces-16596-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1DBE9D41E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 17:51:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5nwc21kSz2xm3;
	Thu, 05 Feb 2026 04:51:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770227504;
	cv=none; b=ZD6bmXTxI6kEGZshNq6cJywcJcHJYPC3zjKNenJJQr9jxiEnOs7F5Dnfwn3baf8igdUQq/XVdl3Dg9Rqdhu8gldzm2+xfv8fd9LpkQsxlY0Di3GY4lefNaPAyz8Zxt8xMsb602fMoR+eYWErdkZDz7n35MWUorbINejWvDRNrcJteQxE0vZTrCPYf82pqIjD561Pk/MFc471gEOOCRBffQBC/UkyC29A48onXLwiGn5WBoKEmlrm/20Q1gAnKSRKwfzy4LU5t8vQEivyK8RUdSW/XKXcXX1ZIY+GJtC+oZcYelmwqFZMH9/NvDRNOR+fE/r8BOV6IemiJBQlk0SfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770227504; c=relaxed/relaxed;
	bh=zGmkLBBMEhPf9U51mjaGj2W4sK5Fb8sEWslngDTXwm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy3Z4828vftpC1KbbXIUGqHVYzHA4Du4b4SQOZe0RoqT9qni+M1Ntx4Jp9io7sTcp931RQkkSDJDBtGMJdOC3N0V9g+DBaSZPLRka/a1+ZKA6vr6vQXWM/jSIJxK/ERdpbR9a0Ev/do35sQ54AnjyH0MgzYb0z2+ISZOYlFzS8FTmjTJLca4OZ61XW5lrnEppJCKP+rv2dL0hx8YLP2HGWuUEKJPPNGrtGPTP0yiCf826XTqwnSTcc+dwjVYocWzS3qwv/cv2SouqZ8ZCrJyUocQi/J3zdOjImdWcwhuT0sQfsPGrhK3VXK2iewvLn7jMb/QOhGsxFQi+/jJj8cV5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5nwb1ljVz2xJ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 04:51:41 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9297339;
	Wed,  4 Feb 2026 09:50:58 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0B163F778;
	Wed,  4 Feb 2026 09:51:01 -0800 (PST)
Date: Wed, 4 Feb 2026 17:50:59 +0000
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
Subject: Re: [PATCH 01/15] arm64: vDSO: gettimeofday: Explicitly include
 vdso/clocksource.h
Message-ID: <aYOHA7ZEpKDowJH5@arm.com>
References: <20260114-vdso-header-cleanups-v1-0-803b80ee97b4@linutronix.de>
 <20260114-vdso-header-cleanups-v1-1-803b80ee97b4@linutronix.de>
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
In-Reply-To: <20260114-vdso-header-cleanups-v1-1-803b80ee97b4@linutronix.de>

On Wed, Jan 14, 2026 at 09:01:33AM +0100, Thomas Weiﬂschuh wrote:
> The reference to VDSO_CLOCKMODE_NONE requires vdso/clocksource.h. Currently
> this header is included transitively, but that transitive inclusion is
> about to go away.
> 
> Explicitly include the header.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

