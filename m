Return-Path: <linuxppc-dev+bounces-20820-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86172CD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:57:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFfnJ6v9jz2xlV;
	Wed, 13 May 2026 13:57:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778644676;
	cv=none; b=KPxIOQ3lNS/sRKRPMcjw2u+eHd/vBxteXIgcDXB2NbiEjuT5q9nLG4nE6HVZ1FZQtmqKFGcEmbbHRbBWbEGiecPALBZaHBsl7BW0Xnx8rNx2U3HfOR2naE+hrIV/+ADCKs9+n5i9g49Lr75l6u+uh4r2vR9zxKi7P2+ouycyxAv4HmfO+dKnhxJr98hY+G5obz8zNj8RxBQelJC+gccBWu61ZxSPOJWa7vZBdHmQ0pEnXeSy3xTVfPs/Tj1rE8fBEypLBlgU/iWr8gtxPDJ6G6+xXe6ws4Y4a7U+KxOABbQX1wrJ6EHhZ6cUM5eWf+TmWvCIq7iBbSrcA2urezRyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778644676; c=relaxed/relaxed;
	bh=4KA02clBr2THgONP7amZfI1GsHfy0Il6SChMfUIqYZ8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=a/CP7+OWEkzvVZk4+O8Z8na6cpDMoDSHK/IkHlIJpSH6IT0vrV8k75lbyqWLruH1taSiknQI3JxoZfaQGhHjSc5Yenh33ie6h1X8c3EW8A87g0zkGDsS+riwn2r3NGVnEI2hd87KsJB8tljCNUO7RSidgoVpFPxNhgTM5b/3rToz6GsXADojjEv/xUnBdr3UKvayW1c8RqvirnbzmJ2z1ds6VDGOjWvNE6itEJJnRTjda6vk67pwQh14jPEQ2W3psUWwzhe00ovcJSBD7w4LmbNbGAebq0Hxrv6jIMIy/Cl7EYOky3/3idJ4NKArbCeXFcaRgpNTY4RrauKLujVF/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K6v1gGli; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K6v1gGli;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFfnH6FzFz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:57:54 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2bcd730e090so21440915ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 20:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778644673; x=1779249473; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4KA02clBr2THgONP7amZfI1GsHfy0Il6SChMfUIqYZ8=;
        b=K6v1gGli8i4rou5RNiAVVAbWW5dvE3FyrhuW0sJxUV8k4aw8yD5Dez3PFfX3bOwIH3
         wmINyJG1wDuw2BygMg5IwEbH6nnxkgIE3G5VKZTmxKNKaBxkZoAuTYSdVpfd8xC1qYC0
         btHMwCq5J3HrCEQUezs434wvOMjflIMMx4NuHnOW6MwuhPdCe7nrfYLocX9Hm8dPwxRf
         uSp14J4I3gtYi+kLEf9jOLicQBi5PqaYAThgvQS4yD2CZ/LKTRLtCRWRlZfIwerBPDMr
         Hcrxuq4HPY5nXulQNvUseI9iBgyVzseihQ9i+xZc6Bo/sfzuNEkSnLGW6CEk5eVRSMob
         BOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778644673; x=1779249473;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KA02clBr2THgONP7amZfI1GsHfy0Il6SChMfUIqYZ8=;
        b=m1sBWgn9+Kpnmrn0cO/YcclzDUAcB1SrR7pyhkPeVoc/IpamUuPGMqbB7O1QzVeZio
         WAQj8L7qpfJXnD9mfvjNZvGWe2Qxw6hmLdvdQHMj7Uw53/wYwEtZmYRfBrlLuZ9lFY7W
         HcdOSJSxkR9tuLwBXzREgCTdmi1eUVEwuM0Xf3kjrA2MztUxCi5KLxhA3UUQYhyroPz6
         O14/IF04BpA2YWNjcn6WvFgPTkMhP9h304FC+xZyzwVitttewuPUg1vTWPOjQbP0TzWs
         ZePxQu6bylmSzIJNAVoKSBPKsSiVXPGZK/ATwR2M5I7+lcWkWoysojkVxN9wJ/ENZbh8
         +Vhw==
X-Gm-Message-State: AOJu0Yz7HFGWJ9L79OYk91UKd6QW4Svp+qQeF2r7Qxr+k114uo1gYwP6
	HO2CtM8JL344I0/zRX7MEEaBgxrUYv4ir4c/fsafcLL5/Ibg0yYjbk1M
X-Gm-Gg: Acq92OF8Y5E8zeO+/vGMw2sLSBHHZvVA7dR6EJZcBBvRnEqKCnTy9jAbuakPv1rE4xa
	R8z/15DSSIB8VNt7wrGRyAvTBNKBs91rFDBA3ctRRZs3MRehkG+pPtyG1Sm03OGofwa7iCJZxDx
	6y2IFqLkuM8+I/A/G5VsbO0qsOukHI7H8NrBvxfjxdtNlMEOa86mEQMuwjmzRo+VeewPRTPE9kW
	Id4DIaLcO0PpjwJdckkemJuaCE6f/pMS6GWHGq0LOe/l4VFgIfi3gpYHBpmXMXfMTY3Kx74R3K5
	c9RKDHSrAZrR3KnrgiAQAeKISypnCBJCN7B6Dxl+032HVg4CfLOT4/NyYN/sHHuOTfNceLHBoDk
	uIZ1/Hq2MdEihvF/278dEPnmLO/aLTH9eWVqntwPttqwBlxOUBmMtlnuvuAbUUnBM43FxskImH9
	athOwlT9o+NKWTU7JnSRlSw4rVoslO6E2v
X-Received: by 2002:a17:902:ea12:b0:2ba:6ca2:bca with SMTP id d9443c01a7336-2bd302267e1mr11964095ad.26.1778644672563;
        Tue, 12 May 2026 20:57:52 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eac6bcsm143075685ad.70.2026.05.12.20.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 20:57:51 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, "Vaibhav Jain (IBM)" <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v3]  KVM: PPC: Book3S HV: Add missing mappings for tracing exits
In-Reply-To: <20260512115724.59299-1-gautam@linux.ibm.com>
Date: Wed, 13 May 2026 09:22:26 +0530
Message-ID: <tsscq83p.ritesh.list@gmail.com>
References: <20260512115724.59299-1-gautam@linux.ibm.com>
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

Gautam Menghani <gautam@linux.ibm.com> writes:

> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mappings for H_FAC_UNAVAIL and
> RETURN_TO_HOST so that trap reasons are displayed as string instead of
> vector numbers when using the kvm_guest_exit tracepoint.
>

LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Minor nit: It's generally simpler for everyone to keep the related
patches belonging to a common maintainer tree in one series. For
example, we could have grouped patch [1] with the current patch into one
series to keep them together.

[1]: https://lore.kernel.org/linuxppc-dev/20260511080412.50722-1-Gautam.Menghani@ibm.com/

-ritesh

