Return-Path: <SRS0=+v6T=6S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D848C47259
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 09:26:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0271524953
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 09:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0271524953
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49FyDF6WVszDqjg
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 19:26:53 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49FyB04bjkzDqdf
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2020 19:24:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49Fy9y6f3gz9sP7;
 Mon,  4 May 2020 19:24:54 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v7 14/28] powerpc: Add a probe_kernel_read_inst() function
Date: Mon, 04 May 2020 19:24:51 +1000
Message-ID: <1657842.E7IDLHXaLS@townsend>
In-Reply-To: <20200501034220.8982-15-jniethe5@gmail.com>
References: <20200501034220.8982-1-jniethe5@gmail.com>
 <20200501034220.8982-15-jniethe5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: npiggin@gmail.com, bala24@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> @@ -524,7 +524,10 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned
> long addr) struct module *mod = rec->arch.mod;
> 
>  	/* read where this goes */
> -	if (probe_kernel_read(op, ip, sizeof(op)))
> +	if (probe_kernel_read_inst(op, ip))
> +		return -EFAULT;
> +
> +	if (probe_kernel_read_inst(op + 1, ip + 4))
>  		return -EFAULT;

I had to double check the above for what happens when we introduce prefix 
instructions but it looks mostly correct. There does however look to be a 
corner case that could alter the behaviour once prefix instructions are 
introduced.

With prefix instructions probe_kernel_read_inst() will read 8 bytes if the first 
4 bytes are a valid prefix. Therefore the above could end up trying to read 12 
bytes in total if the ip is a normal instruction and ip+4 is prefixed.

Obviously this is never going to match the expected nop sequence, and prefixed 
instructions shouldn't cross page boundaries so the extra 4 bytes should never 
be the cause of a fault either. The only difference we might see is 
ftrace_make_call() incorrectly returning -EFAULT instead of -EINVAL for an 
invalid (ie. crossing a 64 byte boundary) prefix instruction sequence.

In practice this doesn't seem like it would cause any real issues and the rest 
of the patch does not appear to change any existing behaviour.

Reviewed-by: Alistair Popple <alistair@popple.id.au>

> 
>  	if (!expected_nop_sequence(ip, op[0], op[1])) {
> @@ -587,7 +590,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long
> addr) unsigned long ip = rec->ip;
> 
>  	/* read where this goes */
> -	if (probe_kernel_read(&op, (void *)ip, MCOUNT_INSN_SIZE))
> +	if (probe_kernel_read_inst(&op, (void *)ip))
>  		return -EFAULT;
> 
>  	/* It should be pointing to a nop */
> @@ -643,7 +646,7 @@ static int __ftrace_make_call_kernel(struct dyn_ftrace
> *rec, unsigned long addr) }
> 
>  	/* Make sure we have a nop */
> -	if (probe_kernel_read(&op, ip, sizeof(op))) {
> +	if (probe_kernel_read_inst(&op, ip)) {
>  		pr_err("Unable to read ftrace location %p\n", ip);
>  		return -EFAULT;
>  	}
> @@ -721,7 +724,7 @@ __ftrace_modify_call(struct dyn_ftrace *rec, unsigned
> long old_addr, }
> 
>  	/* read where this goes */
> -	if (probe_kernel_read(&op, (void *)ip, sizeof(int))) {
> +	if (probe_kernel_read_inst(&op, (void *)ip)) {
>  		pr_err("Fetching opcode failed.\n");
>  		return -EFAULT;
>  	}
> diff --git a/arch/powerpc/lib/inst.c b/arch/powerpc/lib/inst.c
> index eaf786afad2b..08dedd927268 100644
> --- a/arch/powerpc/lib/inst.c
> +++ b/arch/powerpc/lib/inst.c
> @@ -16,3 +16,14 @@ int probe_user_read_inst(struct ppc_inst *inst,
>  	*inst = ppc_inst(val);
>  	return err;
>  }
> +
> +int probe_kernel_read_inst(struct ppc_inst *inst,
> +			   struct ppc_inst *src)
> +{
> +	unsigned int val;
> +	int err;
> +
> +	err = probe_kernel_read(&val, src, sizeof(val));
> +	*inst = ppc_inst(val);
> +	return err;
> +}




