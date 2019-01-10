Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8AFC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 10:56:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45ACA206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 10:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45ACA206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b2wp4FBzzDqdw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 21:56:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b2tv1zpgzDqWb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 21:54:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43b2tv0VNRz9sMQ; Thu, 10 Jan 2019 21:54:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43b2tt5mbVz9s7h;
 Thu, 10 Jan 2019 21:54:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Use seq_buf to avoid pr_cont() in __die()
In-Reply-To: <53b82835-630a-beb9-8a4e-5badc07960c9@c-s.fr>
References: <20190108120500.2547-1-mpe@ellerman.id.au>
 <53b82835-630a-beb9-8a4e-5badc07960c9@c-s.fr>
Date: Thu, 10 Jan 2019 21:54:28 +1100
Message-ID: <87k1jcsryz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 08/01/2019 =C3=A0 13:04, Michael Ellerman a =C3=A9crit=C2=A0:
>> Using pr_cont() risks having our output interleaved with other output
>> from other CPUs. Instead use a seq_buf to construct the line and then
>> print it as a whole.
>
> Why not simply doing a single printk() or similar on the same model as=20
> X86 for instance ?=20
> (https://elixir.bootlin.com/linux/v5.0-rc1/source/arch/x86/kernel/dumpsta=
ck.c#L368)

Yeah we could do it that way, though it can become a bit of a mess.

In this case I guess it's not *too* bad:

	printk("%s PAGE_SIZE=3D%luK%s%s%s%s%s %s\n",
	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
	       PAGE_SIZE / 1024,
	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=3D" __stringify(NR_CPUS)) : "",
	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
	       IS_ENABLED(CONFIG_NUMA) ? " NUMA" : "",
	       ppc_md.name ? ppc_md.name : "");

And the generated code is obviously a lot smaller.

So yeah I'll go with that. Thanks for the review.

cheers
