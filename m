Return-Path: <linuxppc-dev+bounces-24639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B54C44539
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 10:30:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4rB90qWWz2ydn;
	Wed, 22 Jul 2026 20:30:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784716241;
	cv=none; b=MPIQ4n0+Sb1ZiAxr0PM7krYxdR0FRt2ANKnCnk1TaJ2JTutdyBXeAAMIQ5/0lHb0lKcUEXz46VLQeyJauGXuKDF4cGDx0x66MI7iyPTm3WmMLFy9whMiAAHnFZYRKdYuFZ2ePhRcvHbpew3qy0iaULn0H75VBTQE2mkuAMKFyEj/A6nqrQ07wrl9C5DKqX0nReRxs+aU5VSEwfNOwNAX0FXgFKlwWO8Rlgtoa0MMToWeY7s4iqcD2JEABE3BLBxTM2a8ZC5QzjT9Dg0A5PhxHZd9mwAaIR4Ohk3nkPkyk+6j7FGX/XhBNn1E7rBJMfT677cyPVnUuDVLkTqqBB3ruw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784716241; c=relaxed/relaxed;
	bh=Bqw75Hr9cbMZdN/VJ7ycHVSH3fkXQ/VbjraTfaTJVxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX5HOnjdxPuRRQjB5A8dsby1PvH4tTbOUeA0kO2MvUwXIvEaPEuIT9sp4xRj0XOvcNtUDZfDG6FAxM16MRxA9qPp7e04rCpzAIDKk85hawuV27lLMwgJc4Y7Gti6nbeGvgfho883hWKPenIL+TSKd5Zj7Sa8XnnsXV6iZhDwTLH7FqEdAgLILmCu6ork2lK1R0rahdwEhglU+FZJ/FR7H71IhDvKhzWHAQw+MyUIPnmcmLDeqTBVi+vhNeOcsN6oNL82mRvAKA6/wJY+Gf9SOY3X17VVnfD/8cw8VeItSeI0ulkpitrQI5AGEz+5vVDS7M1+gI78h84IgK9R3UXcQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eAYQxnVw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eAYQxnVw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4rB7425lz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 20:30:38 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-84e0a4334b6so1342467b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784716235; x=1785321035; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bqw75Hr9cbMZdN/VJ7ycHVSH3fkXQ/VbjraTfaTJVxo=;
        b=eAYQxnVwOdeV9JH1Yu3QlXAjLP0xIlzjoiJR3SmAP5vAnR0UzLorafywekVf+PYBfm
         2M+ZXMJ3KfXttuVbXfllmSVJMPKZwtQsbWK4G5jiP+8N8wODuwpODNfTAC1MNPLIPJa1
         8oDeE64uNJlJ2eceStG6St0Jbvfjaq1vyGiK5ASI8vCCfdEdPBK5EVTDdcKksgCzqH1U
         Z07ZEEg0XWr0qmq9vD1soQ/UmQfc/6Ph6wNqOE/buLJwbR9ZU/YTxLe12qY1L2a7B5kh
         G5iBYCawNZzBwM9XRQMUWIjz+xWL/pPDkyXxeevb6rwIq/ALdxSuD65cIJsZaDdUxhjx
         ++cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784716235; x=1785321035;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bqw75Hr9cbMZdN/VJ7ycHVSH3fkXQ/VbjraTfaTJVxo=;
        b=Udwiy2zes95qVBLnZFmnojm9q1PPaRAMhU8YvQpRUoYOjonFmCBiw3muSofP3NWqBh
         KFHICuYcxp3QaOqPXrrXAmNe/1ur5lO+GBLe218ddpqGhL2IGwTzFoMEJfm7KX2CN9au
         GLeXy8jLNvYsmscdhvXYBPG5NOwEgjXIvmWMTVUoLhIp9NQ1qxmWaenfnL6QoI4d1dTq
         2Ii8VJjtf1i307VoSatHX3TnWykVjwv1N/xXdoHlcsQcFLUd8654LmjeeBQpouzMgpbV
         2jN0BO/bB3xob6SDzyNd1bcbQvVawCA8pnxFbegd7n9X4Akr7Qj7wpOAjw7StXSootBv
         ZZAg==
X-Forwarded-Encrypted: i=1; AHgh+RoulvbRaohzoWhsPlSNiLHW9EuLg+sfNcaXyrjOvhr99sj9C5imGoIYV780qDckJBQ/jIDj25za1HppNjg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyL7oyT+72QtaOUDgBqbwrQmhkeblLdXd26Q5cyEiuGsVypfR0q
	pVLrWu+2pqLNPGE5xnj4aFNcWY4M+ixLbX9hh1l/SzgO0AmQo7H3G2PR
X-Gm-Gg: AR+sD13icON78LQB8Ecw9n8UNIwSrgMJF3gyCSYDTuNRNN/VtwA0+3UrpDn9GE5imLd
	A4ZURkbzOEvz17M/eq6w6kg2PzZO+3KHx4TBpY4jWWdtTmlgCtKdHmQ8x1qfUcU9CkuvUAomqRO
	p+9zUxIg4B64ufAX+21q3Uq0dOTVLUwHGgcJWOmSm9fIZ7TOGq3AXm/ZH6bUBhknKII7tX3P2XP
	q7WRLqIV/HjjcUw7cMsgGPMeU74bw8f2HU8BOO3r6pYfM7ULlos2jBIA/zWG+gjNZbcUZ5JKp5U
	Aa9G9wH0hSRFVj+cZ7+Pl39954S496AN2wpjcxFE0/Iihs0hQhQKEU5o1VNb3W+eMkyKG8aN6kb
	hGt+hhnEGBT/38wSFW7zs7w/blrcydSFFZ8QA2ez9kuJTJHOqPDxpq4+ZECMdwscSHgmtNESOcw
	Q/FF21kQs3HfaLmjuhsanqOxj+0snIaQER2Ydey/HwluPM0Pla
X-Received: by 2002:aa7:8744:0:b0:84e:89a:b8ed with SMTP id d2e1a72fcca58-84e089ab9d8mr5006303b3a.70.1784716234595;
        Wed, 22 Jul 2026 03:30:34 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1760025esm1104697b3a.57.2026.07.22.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:30:34 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:00:21 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, 
	Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com, thuth@redhat.com, 
	ruanjinjie@huawei.com, sshegde@linux.ibm.com, akpm@linux-foundation.org, 
	charlie@rivosinc.com, deller@gmx.de, macro@orcam.me.uk, segher@kernel.crashing.org, 
	peterz@infradead.org, bigeasy@linutronix.de, namcao@linutronix.de, tglx@linutronix.de, 
	mark.barnett@arm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 5/8] powerpc: add exit_flags field in pt_regs
Message-ID: <amCawOZu7-tgJssG@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260123073916.956498-1-mkchauras@linux.ibm.com>
 <20260123073916.956498-6-mkchauras@linux.ibm.com>
 <20260722070155.GA11808@strace.io>
 <lhuzezj8nng.fsf@oldenburg.str.redhat.com>
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
In-Reply-To: <lhuzezj8nng.fsf@oldenburg.str.redhat.com>

On Wed, Jul 22, 2026 at 09:54:43AM +0200, Florian Weimer wrote:
> * Dmitry V. Levin:
> 
> > On Fri, Jan 23, 2026 at 01:09:13PM +0530, Mukesh Kumar Chaurasiya wrote:
> >> From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> >> 
> >> Add a new field `exit_flags` in the pt_regs structure. This field will hold
> >> the flags set during interrupt or syscall execution that are required during
> >> exit to user mode.
> >
> > Apparently, this change breaks PTRACE_GETREGS as the latter has no means
> > to communicate the size of struct pt_regs being written to userspace.
> >
> > As result, the kernel with this patch will write to userpsace 32 more
> > bytes than before, and unless the userspace is re-compiled with the latest
> > ptrace.h, 32 bytes of userspace memory after struct pt_regs will be
> > overwritten.
> >
> > This issue was detected by strace test suite, specifically, the test that
> > checks whether the actual number of bytes written by
> > ptrace(PTRACE_GETREGS) matches sizeof(struct pt_regs), and that test failed
> > with runtime version v7.1 and headers version v7.2-rc1.
> 
> I think this needs to be reverted because it breaks existing ptrace
> users.  This isn't like iptables, where kernel updates did mandate
> specific versions of the userspace tools.
> 
> Thanks,
> Florian
> 
Hey,

Thanks for reporting this. I was unaware that this would break userspace.
I am working on a fix for this, I am trying to maintain this state
somewhere else than pt_regs. That would make the userspace work without
recompilation.

Regards,
Mukesh

