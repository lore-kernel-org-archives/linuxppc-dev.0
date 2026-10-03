Return-Path: <linuxppc-dev+bounces-28896-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B91ACA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 03:43:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hylc22Mksz2yMD;
	Mon, 05 Oct 2026 14:43:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791171826;
	cv=none; b=BqUgSNRi2ucWiM3/LtYQUQsaDm0n23qYINmSR7ewZOc0XeD1oxj27HnHsPNg7n41FI5f0Q0Q44emnPIgMxCcEVOGDcyhVg0nxRmuh2rVQtZgMsHM6R37UzFtiBExl4OYa4cJG5LdwqUa9DbBngW3JHH5OewDxBlsZplhZiQuQ5EQWcd+cd7F0GnH6Nf/pacjkzVufmAiVYlNBSZxxV1rfBcOblv9ojMHIgkwVKwEZ1z+vMpODIcc9EsCa1lRctWIsE7+NxYbqWAHGZOCMJ1iLFsBYYhBeqPxxawq7DBuCaALUSoGlFYe/CrW5Pqm9NnQZg6wipiLKWWQe7f4Yyx/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791171826; c=relaxed/relaxed;
	bh=M3GmJfAIymRvAtsrt3eqOBHmB18YZ66xoxLnv39f0iU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=WcR0o4Hne1F9vU8T8thU+e4QwRDRl1pioR01Kp01GxSTaVE60fZCcpfZVeCExt1MtHXOzuDzpuYIT96CDrkXG9haroHrR5OHckouj72GqygV6JYAhMRnzVnI8OcJTtoQRPCNHwe8xgAS4EpdDr5X0F01/t72oYv3bNE9PzFWc3w+wU6I6UtPz68MGKtYKym9DE5JVDZEuleNLKDwYaNYk7BvV3AaO4v37fxrF8thPVRGSljmN8ZjAanepgfi26SFWGcSN0UkbgysxxWkljnogJfqqmviCFG7Ys8k9nFxk3u08UH2nCvA9aCTWpTkSvNTm9s7OUaR6bZ1GUOKSbgs3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MgCEASHa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MgCEASHa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0d.google.com (mail-dy2-x0d.google.com [IPv6:2607:f8b0:4864:36::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hylc04TLlz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 14:43:43 +1100 (AEDT)
Received: by mail-dy2-x0d.google.com with SMTP id 5a478bee46e88-34b6f8b8113so387114eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 20:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791171819; x=1791776619; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M3GmJfAIymRvAtsrt3eqOBHmB18YZ66xoxLnv39f0iU=;
        b=MgCEASHazizhpz3OWJKlIVySdyowAH0s5bnNhM8U06S9hwfYXicC/VxtkMX8WI+qI6
         kyzrjjTTkq6Y22U7kN/J2gn99w2KwT+PTZioUz80PaMaTprTCbORhrFcmD93izPD5Qal
         q8UBAvTBseZv5FV9y91JsGIBqZWx8lRc0iWSlB5gQf4xLbPxfv/0wA0A+eZPYV2bl31C
         svxuuZOydXFu38JKwTcmfR62RkCDr0Pt6N9w6Ob58K4WsQXGwjhg5LxHP53ezhn/onKH
         j1o0KVSpSzlY2RBPoNpqQH7y8dCp6Tsi+agwzrBkDC9pCVykAcY7XSHQYzo3vyrC10s0
         /BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791171819; x=1791776619;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3GmJfAIymRvAtsrt3eqOBHmB18YZ66xoxLnv39f0iU=;
        b=qPrqiFrCwkjLgXYBwWv2lL6zypyy71Gf6jjvfukN5JWpvd3At8Yq/Jpe5ejFWCQGCn
         Ck26nlXT1Bg5Rn7rqysYnozCe4fYQD/48zacJSAh0Bg8HAsTy4xsfo6UjWhg4gaU9W2U
         PDd1MaTPIJmr23PYZL6FDQV38SepofMOh7+pFyXSydPQi2+V/r9x6b2djWms4Ub7Y1rO
         W3uj1AvueHcwRynPPqrRlhldsabtBsGcaG35lPKxXem9ycqz0PvJfxunY8G4Rjfpr7IA
         GLN8JcJEzbldtWmVOB024OKcyIXco0vCHZc8E+DZTA+TXMB3+x1SjGZ79Xfgp1J0dera
         D3+g==
X-Forwarded-Encrypted: i=1; AKwUvBxL26EqBFhfuLP7SLdWcA/NuBlcySLA7ZobMVIVt747/g6pkf0ceC/A4T+gFLXS6ZgYoGuei6tt4Jyln5s=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIewrWreYmTuIGpR4jjwHM17swuYDqG5+zoRmaypXosudfY7Rt6
	+kgNlKz68nQlLvzFdpN8EgLqt2SLjP7pE6XDtkWGW0yLjuMrYS1ayksH
X-Gm-Gg: AYBFou3OdXpkvMhfzNgpxzXKazwAaA8dig0R/gUKebW+r00jqp/MVZyn2EZtzeCSSoj
	cv4FpotPV4X6wtDlesZzQjZwviRJ0FkX/fmsxBpmEH+WwpjBP3ObQ3sGt1ZDqUHTn8Z2nHroAD6
	y9lGFB4HNCmCnHTi4EqF0W/hNDC0eSPq0+HoHDf2aryzJK13ed4qt9yFU0K2b0figpAhUmYKD8V
	aojeP+RlkMT+Ot8L19CrlB0Ajkt55g3E/sjRQXxLoEzDRKosrP8SwHpo8yh+T4JG0yb0cGtnJTd
	iSE/8KxKHji2i70pFHzoguUOHBnwO3YKgu3e/oCRuNt24DugAOD0E10DjZeahBtU19birjGSB2W
	s0kM0SVqoeh5Pp61L5jxQjR4stM+5w/mxwuvUas1HgFt1YeAGdShpkZXVfN7gULz0NsqsXIxRVf
	MmiuW7X1xKHm7CSB7q2707psNEMgSt9rKniMfqX9j+MrzmHPpbojKy0kbS6YY/8kLa078mQP1rz
	Tj178rVAW8p71AxTJH44p+hmULAfg8yje625CC+ARQGN9NJUID1tQ==
X-Received: by 2002:a05:693c:65c5:b0:33c:43c:f3dd with SMTP id 5a478bee46e88-34f2196cd67mr10917502eec.11.1791171819348;
        Sun, 04 Oct 2026 20:43:39 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512717cc1esm9601422eec.16.2026.10.04.20.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:43:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 1/9] KVM: PPC: selftests: add support for powerpc
In-Reply-To: <asAsTMn8naXCxhno@google.com>
Date: Sat, 03 Oct 2026 10:07:11 +0530
Message-ID: <ld8fjt6w.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <de328dc973a135a956a148dd83d8353b7157d452.1790101179.git.ritesh.list@gmail.com> <asAsTMn8naXCxhno@google.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
>> ---
>>  MAINTAINERS                                   |   2 +
>>  tools/testing/selftests/kvm/Makefile          |   2 +-
>>  tools/testing/selftests/kvm/Makefile.kvm      |  10 +
>>  .../testing/selftests/kvm/include/kvm_util.h  |   9 +
>>  .../selftests/kvm/include/powerpc/hcall.h     |  17 +
>>  .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
>>  .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
>>  .../selftests/kvm/include/powerpc/processor.h |  39 ++
>>  .../selftests/kvm/include/powerpc/ucall.h     |  21 +
>>  tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
>>  tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
>>  .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
>>  .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
>>  .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
>>  .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
>>  15 files changed, 851 insertions(+), 3 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
>>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
>>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
>>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
>>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fc320b373656..35df0c39e991 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14349,6 +14349,8 @@ F:	arch/powerpc/include/asm/kvm*
>>  F:	arch/powerpc/include/uapi/asm/kvm*
>>  F:	arch/powerpc/kernel/kvm*
>>  F:	arch/powerpc/kvm/
>> +F:	tools/testing/selftests/kvm/*/powerpc/
>> +F:	tools/testing/selftests/kvm/powerpc/
>
> I don't think sending KVM PPC selftests changes through the PPC tree will work.
> It's "fine" for KVM PPC changes because the volume of KVM PPC changes is low and
> rarely modifies anything outside of arch/powerpc.
>
> KVM selftests tend to have a lot more cross-arch and/or common code modifications,
> i.e. I think we'll be setting ourselves up for pain if we don't route all KVM
> selftests changes through Paolo's tree.
>

Sure, since enabling kvm selftests on powerpc has quite a few common
changes in cross-arch, so it make sense to take it via common tree which
it already uses.

BTW - the above file name paths are just so that we can have people cc
linuxppc-dev too, for powerpc kvm selftests changes.

> Does it maybe make sense to have all of KVM PPC route through Paolo?  Punting to
> PPC made sense when KVM PPC was on life support, but it looks like resuscitation
> was successful for at least some flavors of KVM PPC?

Today, I think it is getting managed, as long as the core/UAPI changes
are routed via Paolo and/or via ACK from both maintainers.

However, for PPC kvm selftests - let's do as discussed - to take it via
common kvm tree.


Thanks again Sean, for the review. I will soon post v6 with the
suggested approach.

-ritesh

