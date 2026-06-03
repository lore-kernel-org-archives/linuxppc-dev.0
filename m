Return-Path: <linuxppc-dev+bounces-21948-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F34CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:27:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVd5y3Bf9z2yNn;
	Wed, 03 Jun 2026 16:27:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780468038;
	cv=none; b=fGl24hhnRJxUrD+hkOCBHvvg4/6Yf+5zd+AQbIrRW4v6qRC9/hOUFv1EITs+KyQ+7JjMmEa+SgApdbOQe9qhCKVQB7WgxvpfwCEfHr+2K5A4+zcDgIqwq/WNxjk6ew7G6wwP2jTDL6gtcPWU/Zaah5eUiDqeEFgpFkPEMl3hUAghTgm+2AHUZWOgtYFfi8+YCj92p/cgvhDPR0kfMSJEtWLz0u3cje7jpOElUeK43ShfPyz+raHduOKstRfJ4ZPdW3JiCIqfu50UNpZu9/xHdT2CFRqDovJ4qDfLvrv53EKLp5NwMkMubOJeEBbcN5KD1kNej4WLVq5EHYwk7g+nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780468038; c=relaxed/relaxed;
	bh=FsWw+BRaEfTe2BSzSpq066D0ULR8rb3630HXbbNfz04=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nfIQFWV3OvyffdZXk0aofn8vWPBRRJjvdoyVOe8s1R/iPH93JQUrIXJz7tp0FbosKF4XloPVujhrYy1nWdbzQcaKe5XgdVzWzVHZsxcY2raxnHqOdYuPoVK1C3WRqBWgpzm4I0trXBSBUt3VLoqk5oHUuPZGt//oAhoJzLVoLm6/IS5yYv/xaSULXGfgy+0vH3xAo/Y/Kgtl4H7UR9WN1Z8azb7BkZmoj0IyCid/ZhEo+rrO0b0hHArYH0wRxmGsLgcceA4VwjgB1jxVN2aFSVM+ovcO/NRW05Au3ezViqhUo4QNb4hV0rYQCyPUXI/zudj00MuqZxLGRDvaiT1hfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sqr2Socz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sqr2Socz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVd5x1Hmtz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:27:16 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2bf114b0cf9so35203585ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 23:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780468033; x=1781072833; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FsWw+BRaEfTe2BSzSpq066D0ULR8rb3630HXbbNfz04=;
        b=sqr2SoczUyiEFW3S2pZH+J7ncBIlZT7rvJLmstfczbgLFVk7CBy1Nn84ZjOFEfHVA/
         ofNN+V16m36hTLo0M7rZbGC1Ejv1dlPFTasRMpnUZZE2biuSqgpj9N+h31nOIwgM1YOO
         mFnkYEfDcdggMYu26EGko5ADb+aH4ejYQfvAJwyU/F8kQGOoALKh3d1MvqreZNEWjR7m
         vVyWlLNaUjOPcUfS9rY4SCjhrWenIcWyJld4Rp0+AkND+6nT1bnlNR4XepeCqpo5lCjo
         vlXyRrDmj90Q9ARq1i8gCE9RNYpzzrvePEz6C6ocVuZMra7u6fklZlEXIkpD0LMqYa14
         xBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780468033; x=1781072833;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsWw+BRaEfTe2BSzSpq066D0ULR8rb3630HXbbNfz04=;
        b=r9SGvNR76svlQbHtJVtjeAQsm+9fG3+e5oGeceaMbPYCkyWxiDIkOAGpl9UyY8Rtj8
         fux8IDrbxwHN2wiGgRiJnIYawdaXGnWWb9x2rJYlX1TsETh446ywlVZbqlEg/QAzJ+aN
         +E3f1jSlUyyGTMANH2oX0Rltqze8M1IhjSPXY7+OQNiAczAVy6wX/wsPv+Mj1riAuOJQ
         i/YhWm4l2rbBjuJuzSfUOMrpzvCGzdDooqqDTy2e+FzAxP/S/aXGY1WxedJiy0JS2Kc4
         OHbJZlxZlVllar1+Gi8tlUJu6Uj8RAGC0LNUQARQoTELTJvqp2NxZ8cDfybNcU2ChSoP
         Ry7A==
X-Gm-Message-State: AOJu0Ywx1ltfHVeDg8fPmM2x+q6VHNvwxSsiySSK9ffYn/3lVH7+W5yU
	Jt5zxYyG0l6+O0uq4lTiHXI0aRPxJ8EyDE1qKbD8kR23Sy7hu4OlO95P
X-Gm-Gg: Acq92OF+jBctWMBl1VRQTKquyaHpGKhPm92W43loaVrIXG9HQwZyh1U1QUGAgqoiZJk
	mpzTbZHHEXT2rwxz3R09UydLP1qB7Mco4sCDOqMaPIV2NknYIorU45r++5FilDScOh+37lHnZaT
	FvDeNNTUJPssoFFvBrDDKwzK8tYk3EB4Fc6C60tgseXLcaMJeNQhtDKHrWmzXQUOwo2mForRbx+
	3G+5Wuus2u/cZ6rtzxrWzjvuGO7kn0kg+YW10fBf1lVAxylp1NGLYEjGywXAcoZ/l0iZP1he5P5
	lSSfLe9XBqAgG+9lXKYtCK0aNSAVgxFLkR3ssmGti6VxWPAv0pxWtA8+Lii8Z7+CcfeiaLJueVt
	KFK3bsJl4GoMJELDc1NbGa0bk3pH97kM9TPqy+QupvsbCPp1DCm7IK9lLykC/DO1uH+38uHq6Eo
	k3gmoURVWtGkL4N6swU8+PW4BfJiVantIN
X-Received: by 2002:a17:903:3c45:b0:2c0:bb2d:a30b with SMTP id d9443c01a7336-2c1644ae17fmr20198585ad.32.1780468033143;
        Tue, 02 Jun 2026 23:27:13 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cfb4sm12978885ad.59.2026.06.02.23.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:27:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <56c84e26-69ed-433b-baaf-7b53acc60391@linux.ibm.com>
Date: Wed, 03 Jun 2026 11:35:55 +0530
Message-ID: <bjdsw43g.ritesh.list@gmail.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com> <20260522152744.55251-2-amachhiw@linux.ibm.com> <pl2g6xbz.ritesh.list@gmail.com> <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com> <cxyewhx8.ritesh.list@gmail.com> <87se74z4a6.fsf@vajain21.in.ibm.com> <72ef4cdb-8d9e-4319-9c94-b9a46a6f6194@linux.ibm.com> <56c84e26-69ed-433b-baaf-7b53acc60391@linux.ibm.com>
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

Harsh Prateek Bora <harshpb@linux.ibm.com> writes:

>> amit, can you just post this alone as a separate patch, so that we could
>> pull it for 7.2 merge?
>> 
>
> FWIW, b4 am -P1 <mbox> should fetch this patch alone (and not the entire 
> series), See b4 am --help for more options to select a subset of patches.
>

I agree, however as an FYI in this case -
I had few review comments on PATCH-1 here [1] - which along with the
commit msg changes, also had a code change involved, so IMO, it's still
a good idea if Amit can test and send an updated patch separately for this -
to be pulled in for 7.2.

[1]: https://lore.kernel.org/linuxppc-dev/pl2g6xbz.ritesh.list@gmail.com/


Replying to Vaibhav comment here so that we can reach to the conclusion
at one place.

> Hence IMHO, this patch can be marked for stable tree and potential
> candidate for 7.2 merge window. But dont see applicability of a 'fixes'
> tag to this patch

I agree, we need not use a fixes tag then. So, we shall mark this
with v6.10 tag then.

Cc: stable@vger.kernel.org # v6.10+

(I calculated this based on when Power11 was added: 
git tag --contains c2ed087ed35ca    | grep -E "^v" |head -1
v6.10
)

-ritesh

