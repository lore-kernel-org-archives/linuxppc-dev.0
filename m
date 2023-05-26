Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BC1C7EE23
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 May 2023 08:52:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QSJZR0N7dz3fHb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 May 2023 18:51:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=n84NiyNj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=n84NiyNj;
	dkim-atps=neutral
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QSJYQ71Fwz3c6v
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2023 18:51:04 +1000 (AEST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso345412a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2023 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685091056; x=1687683056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUvWLoLJ7ecOqnvXeIvpdjcIeOwM/KgQz5/8pA9G8eQ=;
        b=n84NiyNjWL1xHP6179rB/rjlflDf5X2HBFQ63nbtEgqvmk9lOoFy98AwhuuOGcGLLZ
         sRC0lvwHR8T9j1pFRXiRzeIW7cJCYhJZUvJaYfEw7/ugrQzqpBIKVjvmZq2KsOAIbteM
         QSD/sC+dRhzssEexVYJLwthLIZIMQlgKerWfGQIXgVsmMgL+CFd//j+mdPSTMylWg/mN
         Z5SyA7v208OHyaDuH2s3qmioliEg5QOLjHPFbD154gszPG7OBzh4X0kccRieqw+uf/VF
         XapyyMNJWhFSON2li3VQjCVZAlLiDtmKktG3bJbh0e+81e1YPcnOB65bU4pYFbDnq+ED
         FN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685091056; x=1687683056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUvWLoLJ7ecOqnvXeIvpdjcIeOwM/KgQz5/8pA9G8eQ=;
        b=Ms+1F5qq9njnjToFLcMfD0ezZ76R+7OrapwJ0sU1w/041ijlJdiWdb6ODLDeMdAfj+
         NoIUBQeThTfU7Ebln5wMsWnAC2m90R2HZcIQCTyl2jGeWGEWg5rqUdCJhI1CGMI5aVMo
         0WYmk/d3Dr/T9KnmMBm9oK8g6pQ8VaVOrIQ+uYJV/n7c9c+1rmUwYYxpL+X5tupsZkTU
         PQpRntaqu1xjv9l3/HWCjMAGPVs6m0vTY/RDpYyVRm+TLvHu/eiehZHRBGUiuZlLdjQ2
         nr7hC1PsMyI8VPHwznnnmEMCKH2qarSSnnlDCfWaV8FsexUnFHTPJPLe+0dxc8nkV9mg
         NKbw==
X-Gm-Message-State: AC+VfDwhZQvCRHQ8prknKtgD8n/kCoOHVdoE6Hk+rDcDr1o5BlLL2GoG
	+EtP/Wut48/2g6JVKm+YFF4=
X-Google-Smtp-Source: ACHHUZ5vLWV4BA5GbUd7uTb6R3TNt35h/LrNw5FK47z6XTA7FhoAMdRuoTd1JbFzYtOHZbAJyUOY9A==
X-Received: by 2002:a17:907:7e81:b0:959:6fb2:1c3b with SMTP id qb1-20020a1709077e8100b009596fb21c3bmr1366954ejc.39.1685091055982;
        Fri, 26 May 2023 01:50:55 -0700 (PDT)
Received: from gmail.com (1F2EF43E.nat.pool.telekom.hu. [31.46.244.62])
        by smtp.gmail.com with ESMTPSA id e14-20020a50ec8e000000b00509d1c6dcefsm1347783edr.13.2023.05.26.01.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:50:55 -0700 (PDT)
Date: Fri, 26 May 2023 10:50:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: boot failure after merge of the tip tree
Message-ID: <ZHBy6hkfQze53pOS@gmail.com>
References: <20230524154459.48cda184@canb.auug.org.au>
 <20230524093454.GI4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524093454.GI4253@hirez.programming.kicks-ass.net>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 24, 2023 at 03:44:59PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the tip tree, today's linux-next build (powerpc
> > pseries_le_defconfig) failed to boot like this:
> > 
> >  Built 1 zonelists, mobility grouping on.  Total pages: 32736
> >  Policy zone: Normal
> >  mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> >  Memory: 2027392K/2097152K available (17984K kernel code, 3328K rwdata, 14784K rodata, 6080K init, 1671K bss, 69760K reserved, 0K cma-reserved)
> > 
> > *crickets*
> > 
> > Bisected to commit
> > 
> >   f4ab23558310 ("slub: Replace cmpxchg_double()")
> > 
> > I have reverted that commit (and the following one) for today.
> 
> Sorry about that; turns out I forgot to test the case where cmpxchg128
> wasn't available.
> 
> Please see:
> 
>   https://lkml.kernel.org/r/20230524093246.GP83892@hirez.programming.kicks-ass.net
> 
> As stated there, I'm going to zap tip/locking/core for a few days and
> let this fixed version run through the robots again before re-instating
> it.

Note to -next, this should now be resolved in the tip:auto-latest branch.

Thanks,

	Ingo
