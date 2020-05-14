Return-Path: <SRS0=AY7V=64=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1280C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 12:08:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1958D206A5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 12:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1958D206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49N9LS3TSYzDqGT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 22:08:48 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49N9Hs1kWVzDq9R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2020 22:06:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49N9Hp5DD6z9sRK;
 Thu, 14 May 2020 22:06:30 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v8 23/30] powerpc: Add prefixed instructions to
 instruction data type
Date: Thu, 14 May 2020 22:06:27 +1000
Message-ID: <1850220.JuIOMCfrUL@townsend>
In-Reply-To: <56ca6bcb-c719-a049-63b0-aae73023bde5@csgroup.eu>
References: <20200506034050.24806-1-jniethe5@gmail.com>
 <20200506034050.24806-24-jniethe5@gmail.com>
 <56ca6bcb-c719-a049-63b0-aae73023bde5@csgroup.eu>
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
Cc: christophe.leroy@c-s.fr, Jordan Niethe <jniethe5@gmail.com>,
 npiggin@gmail.com, bala24@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thursday, 14 May 2020 4:11:43 PM AEST Christophe Leroy wrote:
> @@ -249,7 +249,7 @@ int arch_prepare_optimized_kprobe(struct
> optimized_kprobe *op, struct kprobe *p)
> > * Fixup the template with instructions to:
> > * 1. load the address of the actual probepoint
> > */
> > -       patch_imm64_load_insns((unsigned long)op, buff + TMPL_OP_IDX);
> > +       patch_imm64_load_insns((unsigned long)op, 3, buff + TMPL_OP_IDX);
> > 
> > /*
> > * 2. branch to optimized_callback() and emulate_step()
> > @@ -282,7 +282,11 @@ int arch_prepare_optimized_kprobe(struct
> > optimized_kprobe *op, struct kprobe *p) /*
> > * 3. load instruction to be emulated into relevant register, and
> > */
> > -       patch_imm32_load_insns(*p->ainsn.insn, buff + TMPL_INSN_IDX);
> > +       temp = ppc_inst_read((struct ppc_inst *)p->ainsn.insn);
> > +       patch_imm64_load_insns(ppc_inst_val(temp) |
> > +                              ((u64)ppc_inst_suffix(temp) << 32),
> > +                              4,
> 
> So now we are also using r4 ? Any explanation somewhere on the way it
> works ? This change seems unrelated to this patch, nothing in the
> description about it. Can we suddenly use a new register without problem ?

Unless I missed something there is no change in register usage here that I 
could see. patch_imm32_load_insns() was/is hardcoded to use register r4.

- Alistair


