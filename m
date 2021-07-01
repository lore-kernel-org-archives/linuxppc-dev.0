Return-Path: <SRS0=ZiU1=LZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EEEC11F64
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 16:04:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3ABB61403
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 16:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3ABB61403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GG31R39Yhz3bhg
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 02:04:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=W1hitavD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::231;
 helo=mail-lj1-x231.google.com; envelope-from=alexei.starovoitov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=W1hitavD; dkim-atps=neutral
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GG30t0n8yz3001
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2021 02:03:41 +1000 (AEST)
Received: by mail-lj1-x231.google.com with SMTP id e3so726045ljo.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jul 2021 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=csy0oso8sVVNOjKf5Gla0HtyiXTuq9Jx8AcUlJu8ImQ=;
 b=W1hitavDQEn8qNccnxW8+c9VumLiSxCJcP12eYPMdesJOpDw+paTePwzJA1Gua8Iel
 2GM50RvgO0jf8yvuEecDlrtjJBs/Mz8/2fIymDYYHr08u8zSQJFY6Pv5DaLiv5wVtxVv
 SJlOYKaMMZbMC/A2RAL1dJzPdnM4G7XO+crdmBz5Aw/tXgFCAOy4uZB3+o/SmuNEA+W1
 v1j8j440WhQEQF5Q7A7tJAlWO8eWRawEukYNXRpIJ3ev0zn5wJ7HlwK9qx2ZW6RK3UAK
 W8U6Sw76TVO36oILcUl142hF9NVUdFGSLz1hflHxC9z4UWOUaxQ2daAYyCeQPHhlqqW5
 ZylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=csy0oso8sVVNOjKf5Gla0HtyiXTuq9Jx8AcUlJu8ImQ=;
 b=kTfQKD83aI3nNnxmXLqZsDv1Pqz/eH8K2sZDfpFNcIyBsp0Ll7fIDFQbZJSqfSlyBh
 1JOxnc9lJx8sQ5fPN6qULx0uMJ8/Zkj2MkYOZKZMzcFqW78fNDWR8GeGw12oUpCwG9NC
 U7x2PKVLOmVAxFNe+GvO2NUQagSLVfXGoXSWsItxDuqY+dpyyLdnFjW18Dure2Ma1jXa
 QRuvc687srFHOZFBHlB0iwF+bRL6l3tIM+yordbhwgiA5LW9f0Ukp+M3xfzV+FhMbsYs
 /pz1HP3I9eMfKTE47gC73CwkA9SU3tXN13aQZs494VkzsES1JcwIBBmJsYOJ2NYT94kX
 9FJg==
X-Gm-Message-State: AOAM53120/W+Kb5nMHPx3SnVZM0tNEcioZkRFdupxdWt9OTM+t1rnsUG
 86hX2TR5oB5NaCNaillvt10decgbkAYNEDiR3h4=
X-Google-Smtp-Source: ABdhPJwvTVCLAGoZOJRP0cbmhkzFDDGwtTUKErvtvOWGV08yJxAwgFzrRudfLAQcVSjb5vTaIPhzQ+N/SyE/3VBKqno=
X-Received: by 2002:a2e:390f:: with SMTP id g15mr231914lja.44.1625155414065;
 Thu, 01 Jul 2021 09:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
 <4117b430ffaa8cd7af042496f87fd7539e4f17fd.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <4117b430ffaa8cd7af042496f87fd7539e4f17fd.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Jul 2021 09:03:22 -0700
Message-ID: <CAADnVQ+78iDs7N=8xA6BZVBnPx78Q-Ljp860nmb8cOq7V_6qtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/bpf: Fix detecting BPF atomic instructions
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Brendan Jackman <jackmanb@google.com>,
 bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 1, 2021 at 8:09 AM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Commit 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other
> atomics in .imm") converted BPF_XADD to BPF_ATOMIC and added a way to
> distinguish instructions based on the immediate field. Existing JIT
> implementations were updated to check for the immediate field and to
> reject programs utilizing anything more than BPF_ADD (such as BPF_FETCH)
> in the immediate field.
>
> However, the check added to powerpc64 JIT did not look at the correct
> BPF instruction. Due to this, such programs would be accepted and
> incorrectly JIT'ed resulting in soft lockups, as seen with the atomic
> bounds test. Fix this by looking at the correct immediate value.
>
> Fixes: 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other atomics in .imm")
> Reported-by: Jiri Olsa <jolsa@redhat.com>
> Tested-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Hi Jiri,
> FYI: I made a small change in this patch -- using 'imm' directly, rather
> than insn[i].imm. I've still added your Tested-by since this shouldn't
> impact the fix in any way.
>
> - Naveen

Excellent debugging! You guys are awesome.
How do you want this fix routed? via bpf tree?
