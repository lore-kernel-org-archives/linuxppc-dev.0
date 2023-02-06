Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03BAC05027
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Feb 2023 11:11:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P9Nqt5RwSz3ccg
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Feb 2023 22:11:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=JSr9bUqc;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P9Npq27Lwz30RT
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2023 22:10:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=JSr9bUqc;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4P9NpV6n6sz4x1f;
	Mon,  6 Feb 2023 22:10:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1675681839;
	bh=kUcid2K08WtpFrwk3dq6n2jc2ZZxMaSNsif8b2qLpcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JSr9bUqckLWxlQvgXrqHdLKjhZNKCyo4/W+R7iqEdoTwQny8JL4fA9p8KLiKopoBY
	 5u53AQEtGGXSUIVhYTsKoGTQqHAWk/L2OGiEhn+0/8fSth4VXKAS3aT226D33i5p+m
	 FdbPDX2xoyL2dmmxuKSPL38q4OEI/nwe/wpGmzrwBTQTovoqi6LZ4omZBFLcu1QcvH
	 OCmTE96dRBgZqYLhxf1uVZpSZUhhjl9pivy58AnZ8D9ntUKLxW5BuUV2Rkfq3DMiAR
	 1E1dDbWxoKsiTVWbw5buAHInDRJ1Jkci48lbw53vA/21E8Kh226KSjdHUbEkKMeduf
	 u7otQ9CqmaTuA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/22] powerpc/cpu: Mark start_secondary_resume()
 __noreturn
In-Reply-To: <b5d065218265e79daa23f82bb84efc6a7ea120fc.1675461757.git.jpoimboe@kernel.org>
References: <cover.1675461757.git.jpoimboe@kernel.org>
 <b5d065218265e79daa23f82bb84efc6a7ea120fc.1675461757.git.jpoimboe@kernel.org>
Date: Mon, 06 Feb 2023 22:10:22 +1100
Message-ID: <87v8kfdp7l.fsf@mpe.ellerman.id.au>
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
Cc: juri.lelli@redhat.com, dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, x86@kernel.org, jiaxun.yang@flygoat.com, bsegall@google.com, jcmvbkbc@gmail.com, guoren@kernel.org, linux-csky@vger.kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org, kernel@xen0n.name, will@kernel.org, vschneid@redhat.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, ysato@users.sourceforge.jp, chenhuacai@kernel.org, linux@armlinux.org.uk, mingo@redhat.com, bcm-kernel-feedback-list@broadcom.com, mgorman@suse.de, mattst88@gmail.com, linux-xtensa@linux-xtensa.org, paulmck@kernel.org, richard.henderson@linaro.org, npiggin@gmail.com, ink@jurassic.park.msu.ru, rostedt@goodmis.org, loongarch@lists.linux.dev, tglx@linutronix.de, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, jgross@suse.com, chris@zankel.net, tsbogend@alpha.franken.de, bristot@redhat.com, linux-mips@vger.kernel.org, linux-alph
 a@vger.kernel.org, bp@alien8.de, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Josh Poimboeuf <jpoimboe@kernel.org> writes:
> start_secondary_resume() doesn't return.  Annotate it as such.  By
> extension this also makes arch_cpu_idle_dead() noreturn.

Can we also mark arch_cpu_idle_dead() (the C function) __noreturn ?

Seems like it would be good documentation, even if it's not required
once the generic prototype is __noreturn.

But not a show-stopper.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index f63505d74932..cfd42ca8765c 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -66,7 +66,7 @@ void start_secondary(void *unused);
>  extern int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
>  extern int smp_send_safe_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
>  extern void smp_send_debugger_break(void);
> -extern void start_secondary_resume(void);
> +extern void __noreturn start_secondary_resume(void);
>  extern void smp_generic_give_timebase(void);
>  extern void smp_generic_take_timebase(void);
>  
> -- 
> 2.39.0
