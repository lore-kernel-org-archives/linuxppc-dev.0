Return-Path: <linuxppc-dev+bounces-23944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF832C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:23:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx0dj2q0gz3c9x;
	Fri, 10 Jul 2026 02:23:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783614233;
	cv=none; b=Y5MpsKW9FYggxw1OlrSj7SOGRidRFxiIY1Jqx6QLijgvX+lZWKJh27CdNOJm2UoDdQGHq+5QS+MATik6O3jm8k7tDX6EUXeSTg84C+MMGO9ifmCtHSZ50YviHRtWgnQL7O4m+ITuE29SXciXw4y3plTvYE25FOdNMLNE5nQoHicdx0c2ohuoiPoG8I+1lFopWhf7AKupu65TPYsfxVBGlB33nkkH+LdIfWd89OpCxW8lkhefwAT4mpFojAqdpZyVLLiiZ9yLDkzZ70gZICG4e18sh1IBSJCMd18lNkpyAkni86iFxn6IBwqYs6mrAPFJxBo3Umfgt9JF8K7zDbiwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783614233; c=relaxed/relaxed;
	bh=PVNPrFU1PGB9ZkQlUfz3ePnrtlBWmUW1vci7gbMc020=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/91eZiPI6f1CAenLICvnKqmBdt+jRpp68KJNVFFAHHS4vDd8ef0d9YYdhaOSdkuoahQ9h9wzFPEAsAKy7khU3iJTR29+B7W3HaBDSm5N/qxTCyLTApuiWrNd0wi/XIxDDKGmY1Ehcwt1OM4qjD5LKnDSyuv4BLh25t0NxyGRaDjG5nNVsHD+ZNWUUJPTNGOVofc5mZ7vDP6lIXIPtlb2OIHHQRM6U3HsoycgwlgoQv+YOIFwN1V2H30HCHDuJYsk7CZgFtWIAFOaGY0k/7UDNIvHiAgerb9m14AwuV7sfJtPXnT8Z64Iuw9cls12SCRPlEHPQ+RVE5eICsW2Z+6yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEsGFvG0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEsGFvG0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx0dh1kSjz3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 02:23:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 16346405C4;
	Thu,  9 Jul 2026 16:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F271F00A3A;
	Thu,  9 Jul 2026 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614228;
	bh=PVNPrFU1PGB9ZkQlUfz3ePnrtlBWmUW1vci7gbMc020=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dEsGFvG0entc+CRLpmVOaUBCJG4D03DxA7ZPHMA+0bz+ArzFZ4oZ25h3XsZAVyxRR
	 x10/LoE7lElTzHD06XWpE2m6rYMtKRUGebUhQapIBfB+ep4fG37Ng0RaVsx6GdmjM4
	 W83GkVnhwTOjct2PRlsvXAgfF8WsuxadhgjUrZKIFxbiAgM07wgLkRHLtXBID76WXL
	 vXpw2i5GZ2AEQYDFtIGxLdWwAY7AsLhILvFuoodFrluXUPHF4msNedMhyKYrHXoB8T
	 JJj34DTu2/8Sq2sDLaSW1Xi2u/2ZNgMk1vZ51THvkxDDB/2K6ZsmwZ7UkwuT1KfO4D
	 Hq6xN5eyBwNEw==
Date: Thu, 9 Jul 2026 09:23:47 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
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
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
Message-ID: <202607090922.4ECAE32C07@keescook>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.768842729@kernel.org>
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
In-Reply-To: <20260707190253.768842729@kernel.org>

On Tue, Jul 07, 2026 at 09:06:02PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
> 
> Provide a irqsoff() variant, which avoids that.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Seems good. I don't think macro'izing the interior is worth it since
both cases are very short, with only the lockdep and raw bits changed.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook

