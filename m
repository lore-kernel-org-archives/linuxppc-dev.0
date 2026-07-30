Return-Path: <linuxppc-dev+bounces-25069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B140EC54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:24:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9fLj1XSsz2xnp;
	Thu, 30 Jul 2026 16:24:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785392685;
	cv=none; b=kazX7hH0g8FseBkQUeQ7vizZhAxaZQrSfWtXLEGtaGoJjtT+R9l5HeY2bA+QGJp6G73B/7Lbrbd/1s9zleqevt1VZw7ba7EiGhciztRapQHrFLHGlQz7XSH/Gi6Cgq67ZwEzl4SYXHQU1xg40Cv5uQ0sd7kaBBEauLOuMoced6Bql6ZtMZ1/1gkX4XWSXbR8NnY7nj5CpnLe9rOoDkqT3KJZ6fgdSa8qlNKN7SdJogw/wn5M4r9MJ+06tlSH6LG1YTIBX0gMsnMD79IHc/pyXOYtki4eej3X3kO0gz8Ar1jGnFhlkPrMryDKkOmV0NwHnT9UHELMAmgFuXoNIwG/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785392685; c=relaxed/relaxed;
	bh=SwccytV2B70zPPZl28k2aY6iXbyDzW4BAwGCPpYWraI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKHAWLsca1MKsShpV94IA4BMuX7xBUpBPu3PIFMo+gMXgZZ3ZxbW9OS+0pvxLJ+1o0jMV996Nv/OGUkNuJm3bCuz13QRQadXP8P4B/4LABdQjs5hiz5XVeFbgteBxIHo8GuXfx0U2FGUPWB+Pz1QAUrYOVeICKUUIvuK+qv7Z3ThWGJTLQdPyxm5W8DueTbVaRGpJfmTYVL59DKVNqHnQ5zn7Kji7x2Fa8z6WmY5Y/XZhjXSOGzotiRpX65N7fU+QO8+yt3fbBiGzk8ElOLKOhP0HW+l+whiycxDBvyYHiKKj5rvNj8c4m5avREIliZMic8hcq4C5beJ4lfMn+EUzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGIrya//; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGIrya//;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9fLg3GRfz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:24:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 671AF600AA;
	Thu, 30 Jul 2026 06:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72461F000E9;
	Thu, 30 Jul 2026 06:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785392681;
	bh=SwccytV2B70zPPZl28k2aY6iXbyDzW4BAwGCPpYWraI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PGIrya//QF7IX3sHsPiXwclfRw3PBTpbH/JETP8D0lvfOQBPj6BZy/ijonWy+ucYU
	 +v6ksmApE0eGxbyclb2NRrP2mCyfX+LZe6mH1Em0DCPJqZr1R5ftXZzUBNn2E+dtSd
	 3E3VwG8vpM/vBBjodrFYF0QtqH+ppeBpjmf1j5H5jVaaFRbIPcqWY8++zAwAKJffcE
	 fewO4854xgKvQ0Gv5VM38De+0uzMwrLjVL4JyXqNjDRjkyvZOI1SEUPEOjsRlRKRI2
	 LwdWSw3lsBtm7GRVoXuxh95LDSBq/CvNpZT5dePnqDa2VewWqS9DzfclAtCyxdBYcP
	 3wkzQ6L7zylvA==
Message-ID: <c48b748a-67d9-4fd4-b516-c54d2cf70704@kernel.org>
Date: Thu, 30 Jul 2026 08:24:36 +0200
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
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_2/2=5D_powerpc/sstep=3A_Don=E2=80=99t_defi?=
 =?UTF-8?Q?ne_variables_we_won=E2=80=99t_be_using?=
To: Link Mauve <linkmauve@linkmauve.fr>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 techflashYT <officialTechflashYT@gmail.com>, Ash Logan <ash@heyquark.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20260729204958.755143-1-linkmauve@linkmauve.fr>
 <20260729204958.755143-3-linkmauve@linkmauve.fr>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260729204958.755143-3-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2026 à 22:49, Link Mauve a écrit :
> It seems this function has only compiled without warnings on PPC64, not
> on PowerPC, so before this commit it would fail with:
> ```
> ../arch/powerpc/lib/sstep.c: In function 'analyse_instr':
> ../arch/powerpc/lib/sstep.c:1350:28: error: variable 'suffix' set but not used [-Werror=unused-but-set-variable]
>   1350 |         unsigned int word, suffix;
>        |                            ^~~~~~
> ../arch/powerpc/lib/sstep.c:1346:38: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
>   1346 |         unsigned int opcode, ra, rb, rc, rd, spr, u;
>        |                                      ^~
> cc1: all warnings being treated as errors
> ```
> 

I'm surprised we still have this issue. I remember seeing it reported 
several times allthough I've not been able to spot when.

By the way on my side it happens only when I do a W=1 build.

Same as previous patch, I'd prefer using CONFIG_PPC64 instead of 
__powerpc64__

> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> ---
>   arch/powerpc/lib/sstep.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 597a0d841fe8..c866e4337f94 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1342,16 +1342,20 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>   {
>   #ifdef __powerpc64__
>   	unsigned int suffixopcode, prefixtype, prefix_r;
> +	unsigned int rc;
> +	unsigned int suffix;

A single line would be enough:

	unsigned int rc, suffix;

>   #endif
> -	unsigned int opcode, ra, rb, rc, rd, spr, u;
> +	unsigned int opcode, ra, rb, rd, spr, u;
>   	unsigned long int imm;
>   	unsigned long int val, val2;
>   	unsigned int mb, me, sh;
> -	unsigned int word, suffix;
> +	unsigned int word;
>   	long ival;
>   
>   	word = ppc_inst_val(instr);
> +#ifdef __powerpc64__
>   	suffix = ppc_inst_suffix(instr);
> +#endif
>   
>   	op->type = COMPUTE;
>   
> @@ -1469,7 +1473,9 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>   	rd = (word >> 21) & 0x1f;
>   	ra = (word >> 16) & 0x1f;
>   	rb = (word >> 11) & 0x1f;
> +#ifdef __powerpc64__
>   	rc = (word >> 6) & 0x1f;
> +#endif
>   
>   	switch (opcode) {
>   #ifdef __powerpc64__


