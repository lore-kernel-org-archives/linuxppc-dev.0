Return-Path: <linuxppc-dev+bounces-27477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373AFC982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 09:50:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlDdq51lzz2y2W;
	Wed, 16 Sep 2026 19:50:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789552223;
	cv=none; b=NBy3aHQA1FJlpR6f3fZARmr8/E7M9itBGe26CjWex9cQrrwcPia0Ohxp+NHlZCoT70fnI3ynrb87nxqNBgAgpAA+qfdJArS7jOeWVeSWcarFUfb5HFX1ypP5HBhlFSq5w93utTQhELw1+Kp9BB4vJ8FsiVrctEifgODGGGz+1oiSs34+l6AuEK0+65iGzOcuz1iB4YAViD1DKHfz8nl7LYqphz6vqQVvVYrPJ2+SrHalmRg89uIb5wjGq7PUJCrzf9EZ0//nLbEvHyZIpmji6nqYg+5t1t5z+WQvIdI3iGqEF44l/eUPVVwM69N2JFrPQMdZpS1hbYZo/w+hd880ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789552223; c=relaxed/relaxed;
	bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+CetksI+wMFTSkNjhwvtdkagiTAm9Ga/uXpGd0VJC8pEdGU3YALa2l5r0clOitE0jXiUtZnNDOFdVtYTDHIACYZRuj2OC0ycRzNNM4Ccaff6+0F4imoUohGtpNVNac7twE4qNnd194se58Ksqf6SLwv+rdHks04vaU0joi8wcMwbZLy9u7DhGdF5CFLnvzH1zLsdTF8+4UcK0ACJkMYeUk3dMOhuJYYeCaPZHWBLAeUeBnTybfVi30P1trjK/XGzcNnXBUvgLdWrRG7b7SfptkDGfLdoYaTw44xB7fs019chd1YkRpK7AUlW3sAvmwNV2/YDcfEu3xc+KRi0qehrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E+N0pK/K; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E+N0pK/K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlDdp3Nhxz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 19:50:22 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e620fa473so4413275e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789552219; x=1790157019; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=E+N0pK/KShxQe5cYwIEp6bsAeda6kxlQnwQ6RsZp3RBoHBathhtPPdFcIDo1xL3ZtY
         vKdN58Cf1sdWfF1ySqG85VnLR2cBh7NPdfaOTUmBppM2006VZcTXGokksXPdk8yj9Gg2
         CNycGBCpi/oq4LbILcIBZGALX/FEPLzKNPjWnIfwVwP66nN3139jw455xSgSTYL1kR03
         5e3QJLj44R2tPdRYc/mNI+PP7lNpsz3HyWSe0rsXIkR7GrQneYFZ6vzL7nsL2BS+EbVS
         fkSGUdxGepPvtrM3nEyujYrMAYeuORs7j2rggSnfM1FhXwYFZKTGSqiLFSEMQZGYGNqh
         3ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552219; x=1790157019;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=QshXZcJWJm7QsGNeV9Edgj90XGxGtkOrhMg0neE2LXIcruyex/kOWO2SHw46G+TWmR
         kw66+w6X16wHiENLeUr9I1LHlhHetPFvVvhLRL+b00Ca6WgThLmHQWpPHGe7mo0Tg2xN
         iouB3xFBNFOsF/I5dj0FcYq1PplrqI1k7VPXiprhbVuWqV46fH1zm0Ilp/nfI4qX5Yvy
         9yDV9G4fU7pRyodGPTqPiP7btPBJFfhiwkPZn5WWHIuhjnELviAlUlzEAbgOBh0rg1bh
         1rIql0xkoi62kMKNpdF7Wjbd1Rz5M799M8UETdbXNGT491QiCoNkJze6H4mHNFtANj1o
         1soA==
X-Forwarded-Encrypted: i=1; AKwUvBzg5Gu2sDekeaNQ3KBINriLEOxOOkkLYdifdzUDTkH54KWQEMDXqSQl7yE4GN/o9IkmRA4kl0qlQMfngmk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lnmwI6QILjsiX60UR/ss2YmJBFy0DlhQmeFZzz8fxpNc1h5jXQ
	pxuoSc0+S5Gz2+JhQvWaoJ2AAfbtmkwsBdT37nfjMhRDGK95rBl1iFGS
X-Gm-Gg: AYBFou2+yasPQfbxkMdXSehtFEb2cW1NLLedBLxQLDehRjQYC6mQ+Hz0LWZVSDFlM01
	vfq0UAg59WMIaocNVjILyY5IwurMs46baN15U6vtPIzSCysDqKPhLW18q7VE/SrPtfn9x0tJZYL
	UIOXxojMQJxrGwHJTTba272O2T8ScOir1NPbvPnb2jcvAkFaBLZoXub6+f7wkS2b1cQPaVfJBiR
	bB/XYEtRvvLM50mQgQhRw2Bmvx+IJF/K+kWuKcrnLxWTlBNdlg9XMXXa6mddx9Dq03Hw5X0W+ZH
	mkC7OIE3hSJBgXgcz9OfpDweg3rPSv2lko/cV643Y0wJHZziY5EO5KYbAe0Obi1riNaKYu4iWKg
	GRlPGjLBX2RNIxwYFc/AyvIX82f1puCOefsXRJWxrPLCQGynH7gKAOha3zbivX8GKewJkCSk8E2
	MnZTI6CMVVDrht/fKLEQl9xS9/1fB6azC7D6stzX1kfURQMkyQv34a2PIfkqlO3QakOI6W5RDFi
	DObbWTWai/T9UQ82kyOmr/vy/elGewsSL1nA7MV+w8ps8Y=
X-Received: by 2002:a05:600c:4ec6:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49eb732aec0mr19444455e9.24.1789552219000;
        Wed, 16 Sep 2026 02:50:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83b02245sm84055225e9.10.2026.09.16.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:50:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:50:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Jens Axboe
 <axboe@kernel.dk>, io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
Message-ID: <20260916105017.13ea5e36@pumpkin>
In-Reply-To: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
	<CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
	<CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 12:08:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
> >
> > Is this mainly about stuff like "we installed a file descriptor and
> > then the following put_user() failed"? Because if so, I think a nicer
> > fix would be to have a policy of "if userspace provides unwritable
> > memory to a syscall, just keep going and pretend the access worked",
> > and maybe have a sysctl that kills the process when this happens to
> > emphasize that userspace should not be doing this.  
> 
> We've done that before, where we just ignore put_user() errors and the
> user gets whatever the user gets.
> 
> It is maybe not optimal, but it's fine. You can find quite a lot of
> unchecked put_user() calls with a pattern like
> 
>         git grep '^[[:space:]]*put_user(.*);'
> 
> and some of them are in core code - see the two in kernel/fork.c, for example.
> 
> One of them says "if userspace has not set up a proper pointer then
> tough luck". The other one doesn't even bother with a comment.

I think the code should try to return EFAULT (IIRC that is too hard
in one of the exec cases).
Otherwise very unexpected things might happen if the memory is just
readonly.
If you ignore the error and the pointer is invalid the application will
get a SIGSEGV and (usually) die.
But winding back kernel data because a user copy failed is likely to
be problematic/difficult and at best have error path code that isn't
really tested.

As well as writing fd numbers to userspace, some sockopt code tries to
wind back if the write to optlen fails (which has been read earlier).

I've forgotten which Unix converted EFAULT to SIGSEGV in the system
call exit code - I'm sure one of the ones I've used did.

David

> 
> The scheduler has two cases too, although one of them is admittedly
> for another error case.
> 
> So yes, saying "if you pass bogus arguments, you get what you get" is
> a valid model. It's perhaps not the *preferred* model, but it's not
> wrong.
> 
> It *would* be wrong to take code that already has error handling and
> remove the error handling, though.
> 
>                   Linus
> 


