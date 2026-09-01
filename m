Return-Path: <linuxppc-dev+bounces-26418-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DF0C624D0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 18:34:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZDzb1Dwsz2xmh;
	Wed, 02 Sep 2026 04:34:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788287675;
	cv=none; b=Pmgm5TIKaktEQ/5oK4Cx/5KJj+Y9RcFO8JY1e8c0vmbPMPBqpeYThhhumXN55tAF66EH7USkUue0LIu407/+pCoVMgXRtdg+ihakp8Worx9t/RLWFzegJ+wK1vfOvW/qT2FFSS27mPL7Od11LaWD1tNEfgzqa/tk3kGBgrkvDIHpE9PHufFDONCfFmFhSTha+eolXCOVhbNbuHR2Wf16G6kBGdS4DGl+6YjzsApwjPv7tnl+ZH8kAxxYEN1DAPrYcao+PoDt/ODIYE5pI32VYwcfmdFjUC6ES1SpfQGkwP5fWBR2nxi9mToPGwLdjKVVQcMYVCOZ8Tyx902vr+54Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788287675; c=relaxed/relaxed;
	bh=5NXgbY7RzU8g0Kf53Luap+wGnaz+b4K8573/iOsTQ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2u9TCq+eP0tQA7uEcsMFCF/tb6oR/2z17uE/qsQsY6unsouSCpEB9owfMvFiAIiYg51Npk5UZpKL86Z59C8ouL9oMO7vWFFvAU3j1KP4wAxtKifhPP6NMKF7EUF9l2bNZhlmypCb+8stdHnaURN2il+tBj3aX26+NLelekiiLf/Bgh657PwiY6d/rRljY89oA+u3TCpstu4WtBorA0SJiyKra7v7I/UIiXetnfds16z5aNP4LPzi/5OKJWewFIVBKvE+DK0BdyJpXXAp+itZ/CcN+qUvuRkNp0fy+Tg2yILnxBK9lNPedmcKA2ZcshOLnYayDIRukWvBDO3HUknxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I/ixn95t; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I/ixn95t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZDzZ0vlVz2x9g
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 04:34:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 76FE840244;
	Tue,  1 Sep 2026 18:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EDF1F000E9;
	Tue,  1 Sep 2026 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788287671;
	bh=5NXgbY7RzU8g0Kf53Luap+wGnaz+b4K8573/iOsTQ/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I/ixn95taCRJGX4PAMNj/C2sqsS1ahSoeW9hr3nqYKv27L2TmqCZFfi1XeScTVlf+
	 cbstwnjn2a3/FJPdPre8LRomsAIgGvRkr30ufESK8Ikz1ihAT1e4EFZlbXk2zU8HLl
	 ICHHFQtXJZxvByz5b71CGGjk2IP+1XjSgOlMXEDq0LNZLLkh8BQHNzaOGHep5rMr7n
	 9ox1IiG5y5PYzg0A1y8r0QUfK0PPZkloaruwpOABRYG2htBc6Pz48lBnz1ZlV+utDZ
	 Iq+UfKLLwTr8PX+yV+aVmPr3HM7CzjtIchVC9ohRkL51kOj3+kssxJRDWicb2pXwkp
	 blNMtbtGrXCJQ==
Date: Tue, 1 Sep 2026 11:34:31 -0700
From: Kees Cook <kees@kernel.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Radu Rendec <radu@rendec.net>,
	Renzo Davoli <renzo@cs.unibo.it>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] seccomp: Fix syscall skip logic on ptrace
Message-ID: <202609011132.F4A3EB7103@keescook>
References: <20260707181957.433213175@kernel.org>
 <al9NlZi20xHMvla2@kunlun.suse.cz>
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
In-Reply-To: <al9NlZi20xHMvla2@kunlun.suse.cz>

On Tue, Jul 21, 2026 at 12:44:37PM +0200, Michal Suchanek wrote:
> seccomp takes a shortcut here. When the syscall number is re-read after
> ptrace and the sign bit is set in the syscall number the syscall is
> skipped right away.
> 
> This works fairly well on x86 where the return value of the syscall is
> preset before seccomp is processed.
> 
> However, on some architectures the syscall return value overlaps with
> the syscall number or syscall arguments, and as a result the return
> value cannot be preset in advance.
> 
> For these architectures seccomp needs to exit without flagging the
> syscall as skipped. Then processing of invalid syscall number in the
> architecture code should set the return value to -ENOSYS and skip the
> syscall.
> 
> This introduces a change: If the syscall number has the sign bit
> set, such as -1, previously the filter re-check would not be done, not
> applying the filter after trace. Now the re-check is done both for
> syscall nubers with and without sign bit set. This would only make a
> difference if the syscall number or the filter was changed by the
> tracer. Otherwise the filter would be resolved the first time around.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  kernel/seccomp.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 066909393c38..9e40a38aaedf 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1318,11 +1318,8 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
>  		 */
>  		if (fatal_signal_pending(current))
>  			goto skip;
> -		/* Check if the tracer forced the syscall to be skipped. */
> -		this_syscall = syscall_get_nr(current, current_pt_regs());
> -		if (this_syscall < 0)
> -			goto skip;
>  
> +		this_syscall = syscall_get_nr(current, current_pt_regs());
>  		/*
>  		 * Recheck the syscall, since it may have changed. This
>  		 * intentionally uses a NULL struct seccomp_data to force

Does the seccomp selftest still pass with this change? I _think_ it's
fine; this just induces more work on a tracer-induced skip path, which,
in theory, shouldn't be fast-path: kicking out to the tracer is going to
be the slowest part.

-- 
Kees Cook

