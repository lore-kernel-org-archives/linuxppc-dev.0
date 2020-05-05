Return-Path: <SRS0=ZeYp=6T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411B9C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 01:43:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E8A206B9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 01:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E8A206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49GMtg6Pc1zDqdV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 11:43:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49GMs02W2hzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2020 11:41:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49GMry07nYz9sSs;
 Tue,  5 May 2020 11:41:37 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v7 15/28] powerpc/kprobes: Use patch_instruction()
Date: Tue, 05 May 2020 11:41:36 +1000
Message-ID: <1746162.D6oU1Leszo@townsend>
In-Reply-To: <20200501034220.8982-16-jniethe5@gmail.com>
References: <20200501034220.8982-1-jniethe5@gmail.com>
 <20200501034220.8982-16-jniethe5@gmail.com>
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

Without CONFIG_STRICT_KERNEL_RWX this boils down to doing the same thing 
(although with a few more safety checks along the way), and with 
CONFIG_STRICT_KERNEL_RWX this should make it actually work (although perhaps 
there was some other mechanism that made it work anyway).

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Friday, 1 May 2020 1:42:07 PM AEST Jordan Niethe wrote:
> Instead of using memcpy() and flush_icache_range() use
> patch_instruction() which not only accomplishes both of these steps but
> will also make it easier to add support for prefixed instructions.
> 
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
> v6: New to series.
> ---
>  arch/powerpc/kernel/kprobes.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index f64312dca84f..a72c8e1a42ad 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -125,11 +125,8 @@ int arch_prepare_kprobe(struct kprobe *p)
>  	}
> 
>  	if (!ret) {
> -		memcpy(p->ainsn.insn, p->addr,
> -				MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
> +		patch_instruction((struct ppc_inst *)p->ainsn.insn, insn);
>  		p->opcode = ppc_inst_val(insn);
> -		flush_icache_range((unsigned long)p->ainsn.insn,
> -			(unsigned long)p->ainsn.insn + sizeof(kprobe_opcode_t));
>  	}
> 
>  	p->ainsn.boostable = 0;




