Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADCDC3065A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jul 2024 18:21:00 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J8neZdN7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WCZ9R2dD6z3dWC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2024 04:20:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J8neZdN7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=naveen@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WCZ8g2gNrz3c5q
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2024 04:20:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8C8686173D;
	Mon,  1 Jul 2024 18:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6D1C116B1;
	Mon,  1 Jul 2024 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719858016;
	bh=v61sebZAM5Fq8S2wGe6p+xdUAaooGWaG2e3NPPa8p8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8neZdN7VMZUQ+pCnikRCXfuUW2R4Kl2KJlnHoTTqgR8/ND6ugQR8ik4guKKyEaV8
	 Yp6r7hiv6i4MiZe/vEv7tmSLHM4AjDZLBQYYU+ghNXUi57FqertEaKwpJ0uSszZzxm
	 bXQzrf2dsVwaS0Y6RipKlMz7iA6gFOXbHOxCyGcmwwPXGbuI37GcR29Kd7am4NgdtI
	 QAp4r4eCucHbZZde9lJJg1hyjv7LQBn+qzRWj7k6co9BqGVykA/4Qw2KOYVhunyOvY
	 1RJq7zWeSnM+/jTA58WseqJ1hbf3+fFGurgwNsBimt5fNp9oQKdhk2Q9rK4ycwerrt
	 Cq4E6x5imI3UA==
Date: Mon, 1 Jul 2024 23:48:37 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v3 01/11] powerpc/kprobes: Use ftrace to determine if
 a probe is at function entry
Message-ID: <owili23kr3wim6carm6ueogyureim6h2iv5a37kkz7viu564ca@xxkhtzst6l7n>
References: <cover.1718908016.git.naveen@kernel.org>
 <2cd04be69e90adc34bcf98d405ab6b21f268cb6a.1718908016.git.naveen@kernel.org>
 <D2E2GLXWB7TH.1L7TFQZO3149Y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2E2GLXWB7TH.1L7TFQZO3149Y@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, Masahiro Yamada <masahiroy@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nick,
Thanks for the reviews!

On Mon, Jul 01, 2024 at 06:40:50PM GMT, Nicholas Piggin wrote:
> On Fri Jun 21, 2024 at 4:54 AM AEST, Naveen N Rao wrote:
> > Rather than hard-coding the offset into a function to be used to
> > determine if a kprobe is at function entry, use ftrace_location() to
> > determine the ftrace location within the function and categorize all
> > instructions till that offset to be function entry.
> >
> > For functions that cannot be traced, we fall back to using a fixed
> > offset of 8 (two instructions) to categorize a probe as being at
> > function entry for 64-bit elfv2, unless we are using pcrel.
> >
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Naveen N Rao <naveen@kernel.org>
> > ---
> >  arch/powerpc/kernel/kprobes.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> > index 14c5ddec3056..ca204f4f21c1 100644
> > --- a/arch/powerpc/kernel/kprobes.c
> > +++ b/arch/powerpc/kernel/kprobes.c
> > @@ -105,24 +105,22 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
> >  	return addr;
> >  }
> >  
> > -static bool arch_kprobe_on_func_entry(unsigned long offset)
> > +static bool arch_kprobe_on_func_entry(unsigned long addr, unsigned long offset)
> >  {
> > -#ifdef CONFIG_PPC64_ELF_ABI_V2
> > -#ifdef CONFIG_KPROBES_ON_FTRACE
> > -	return offset <= 16;
> > -#else
> > -	return offset <= 8;
> > -#endif
> > -#else
> > +	unsigned long ip = ftrace_location(addr);
> > +
> > +	if (ip)
> > +		return offset <= (ip - addr);
> > +	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && !IS_ENABLED(CONFIG_PPC_KERNEL_PCREL))
> > +		return offset <= 8;
> 
> If it is PCREL, why not offset == 0 as well?

That's handled by the fallback code that is after the above line:
	return !offset;

That addresses both pcrel, as well as 32-bit powerpc.

Thanks,
Naveen

