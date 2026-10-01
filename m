Return-Path: <linuxppc-dev+bounces-28700-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912C1CA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 21:26:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwlNZ0K9Qz30DY;
	Fri, 02 Oct 2026 07:26:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:31::e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790890013;
	cv=pass; b=Ac9pqjkJgLD0UHkKLjdaMfh+hBnySH5aWiEvnF70lPGhBUq1JcF/hqplLgX2Jx3+Hs/Tbi1KtoouirEWTlCgR5oG8VxcTEOabkkKflLvXZW53UoTolYMrgBcfmJMVH9m4Opc1EkQRNSuCWLb+Czxnv3tZCVKjSdeF8D+7VgsmEaAoQKoOdXokQGmG4qU1Q/BA5LBkRj//+bbejo8TUDsqO1Sw7bp/do4lnVol/O7q2V6LZPtob8na7pOZAFScbsMkuchmHiScTvlPh24RrTggg1KuDW8T5weDzzu41PEKorwDpnHpX3cUy1TLzNgDG2yGPlT9kIW/c2e9LNPVx7jdg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790890013; c=relaxed/relaxed;
	bh=EEJI5AmWq9kvDrvN7+gLxoAcIdEGS6uwkzuVRjJJ5qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Smd9prO6+SXKmTUTqqcGkGS9eWAelhKJTgr3a5e8aN8C3k+lm6UIU9z4PdH4SPJGETHahJTMKZrps7ufVNmxesINBkW6wb+t2OFtYdbqt6W4b+/sIgdFpa5g2UCiCqwg7DTcq6ACu10poN6UZKF9s8W8temqO7acYGT84zCC+afziiFarCOWgOFNvDXAKpH8N95Hswn/fTGSuiBweoh1RGIULD67qf9nGyEwPgVMMVjKao5u8gRGtQ9gtmpuOnodmbOgXTA1hVmjtfDULCQbdZZz8pjNLRN9Lqt0ni5buXr4Yx3lPmQ7UY8lDlm5oYnnV3ULvp6ZGJUt+dWrzUf/Vw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=J3844TOm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:31::e; helo=mail-oo2-x0e.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=J3844TOm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:31::e; helo=mail-oo2-x0e.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org)
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com [IPv6:2607:f8b0:4864:31::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwlNX2t79z308H
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 07:26:51 +1000 (AEST)
Received: by mail-oo2-x0e.google.com with SMTP id 46e09a7af769-81be5042c51so5415657a34.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 14:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790890008; cv=none;
        d=google.com; s=arc-20260327;
        b=q4sjtDhzyFYN+WinpioW4x5KkboUFQCpcNNKWbIK4wyoa0FxJ8TOp7emivShDh4h1F
         uWdusxJSfdm9cQpoKbE6szF6uUoESDIXcYS5lBi+vl9wEtXs+e5p1neB+TgFysqruxrR
         8KTFk2yRRFejY1nI9cc/FpNO0c9bo7aZX/MPutDwh5Vtdilz5S4yFxD1ezUHUJe8fex2
         sWuC1iWTWNKV9nBW37pni4ZO4c6p9pHxGNUnM6/eiRb8G56HU87Z8zYoF8NrPzYsyl4U
         ne/DZEYgRkFpxSuxyKA8qgr+eavtr7NBdlKqIzPfWV/uVlr2WBfqx0Fwd3kBwNIJc+nj
         L34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EEJI5AmWq9kvDrvN7+gLxoAcIdEGS6uwkzuVRjJJ5qI=;
        fh=VjbSsP/rEFEXZSzjBBC31FZxuQ4T6c8NWGpGh6m/GlQ=;
        b=BHBnOZtfwGQHmdlAEH/bYxA+MGqMl7bjxu7ypbWPPVIFQgUWDBZKO7+4GLfcAMqM2v
         PWpErAae3ShaswCTl8R29A7obnGwaTSTckOiIzvdp4FT/MVtGuKCd9QHYBMCXZFe5D/4
         6BnBllex19bKAhtAHyVhZemlpWw+KqFn9YaM7VdM93gMvKpzUf9Zj9PsXaGlqbyLGb1X
         +UrmAsjxMMZy7t28bPeFuMAjHWAOMmlWBHx1TCJm92E+wxnGXqgwBEhyAY0rGNzR2S80
         w1SawWJdTVMVjQ7BTw9ijLanetqr4kWWnaDNSa1msWH89jvjWy0G8mfdvs2WlCC9dmmL
         ZRQA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790890008; x=1791494808; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EEJI5AmWq9kvDrvN7+gLxoAcIdEGS6uwkzuVRjJJ5qI=;
        b=J3844TOmwGP5X0UA8oXwnpSyGtIMzqTLlBgf1mmSi8lSNTLlSmipiHgooq8TpOREfj
         sfmjDEe1fHhxDBBnLNPFI6kYFi2YpKboLLwqMCt4V8ZgHn6Ek7HrGumEk175BJWPDnjA
         +EpAYRp90L3lXnwEE/nZk0kehxQXyvsSxOVeqMK11kmMjlU+wSJU2pGZTwd03OtQaY79
         /IhbYavoVvgvG98Jftm3qqnG/+6xDjDU5WOWAZS6Y9df/NauNmGCkPMZyd3rm75Pn0rv
         kuY685G8mzl3n5ox/e7HUnvMDdC3TsxB/ZJdNaAbjK+rc5QigtsTFyGstIHShLpeCGm0
         yvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890008; x=1791494808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EEJI5AmWq9kvDrvN7+gLxoAcIdEGS6uwkzuVRjJJ5qI=;
        b=RxDPsceru53KFaRTw1Qu6E/Im2Z6BLmA7e6doBWkX+WHQbNem4OARyRqYR+PBn/zuI
         2BLoDNSMyy2hyHuQ1FfN2Pf6CPcdvT+YtsIDDqC+9m8LuMopWGWMjPVXa0+DM7+Fhhni
         Kvl7f5KJ1vMlwn+f65N0/AOPIe56/G3wg0qD1l+FYeUJrnDwzoQK4JaBDXRgo7DTzDRn
         pFO8n5DY/JM6snUBqWhKJUCfHFeM0jPr0KePlaeJ54e7XXNVk026sHlW0T2MEJmNN0pe
         9olY22B35JNRjBM/cheRUBrRitxVcWNy94/1rbQKG7TkHU1hUglgxusOeh5ZaVfuA3sH
         BZKw==
X-Forwarded-Encrypted: i=1; AKwUvBy3vyXQ1S9HNeFqJXBjqqPPxq+Yz7KnE83suaHUDXDf4CahM17NgQ1pqS4bRaQG5X46WqHZ3q5s25mEjv4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ms1233jBXrwfVGi2ajdeWgi7RNeedtY8bARoQdcjOlxZhA0m22
	LDhajizZL6g3NkOw/sU/klKpr69ay98SQ/TLo3MxOjluLriRqZazolE1HBOJIph/EbfQecAYDqU
	RZ5bk5qOXucWDngCp4BsWuAaPM/auomnEIVyrMD2n
X-Gm-Gg: AYBFou1r0OlRtYHrBQQVanObA+phmAuKr2LztDkXiQYCSgU9dEQjycOoqlIgZKiMeTO
	8OMnYQH8QNwLgiF00OpUusIwFlHUs/jVdmASi65LXFSQMFLUvdHNBmRWS6heiHCAheKIQuFlubF
	gazZ+Ia+yb37hjtO+sQsjiGY2CGBVUzQrdv/yWodWV+SvUZ57gog9/11BEw9oMo7AVQtWnUex+E
	6JOH7SIR+oTqdC8AB/gGCq62hSYSA66EufWjlVGxm3gs1tWRV7IGVUN4s4AbiRgmif6FAb8+GZH
	vyVlT2kmuuMf+VUqcweAnqdTLwaFF/2K8gFmMErgZ696EZpa26MCCU1f424eQlJgw/yqsZkKU7j
	07y9wI7vXnHt41W7FZ3fXIF7Lzcv0owhwVRoWlbanR6RCHOPQUlapjOG/dUFv+GxZ5eP8xkAJj5
	VDZQ6xtU7EkOCqiYr2XkTIYas=
X-Received: by 2002:a05:6808:f0a:b0:4d6:93c3:1aef with SMTP id
 5614622812f47-4f52b1b8219mr550043b6e.58.1790890007278; Thu, 01 Oct 2026
 14:26:47 -0700 (PDT)
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
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-4-seanjc@google.com>
In-Reply-To: <20261001202234.3794060-4-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 1 Oct 2026 14:26:08 -0700
X-Gm-Features: AclHuK_jD8_Az1NWQmBSP6uJu5bELGSPzh6zWF2qzLw4EN-s4elX5ThB-3dDs8g
Message-ID: <CADrL8HUeOETayLAeutN+8UHq+2eg_nBWf-PPMMsfoLei0HY04A@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] KVM: x86: Unmap VMAs for KVM-internal memslots
 when the memslot is freed
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:26=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Unmap KVM-created VMAs for KVM-internal memslots when the associated
> memslot is freed instead of unmapping via x86's internal API.  This will
> allow deleting/freeing all memslots before kvm_arch_destroy_vm() without
> leaking VMAs, and in general is a net positive as it makes it far less
> likely that KVM will leak VMAs, e.g. in the unlikely scenario some other
> flow deletes KVM-internal memslots without going through
> __x86_set_memory_region().
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

LGTM; this code is so much better. Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

