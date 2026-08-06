Return-Path: <linuxppc-dev+bounces-25459-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59747C55ABF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 01:20:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFqG41JzRz2yh4;
	Thu, 06 Aug 2026 11:20:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785979212;
	cv=none; b=fic18HVgs4SOCsUBuEbHzqkoGPFrKdBs3erxBv0DbhgVXmFZStlox8b/NCbcv/dUMKXIAHwCbVnJPnnAVmK8RJnAcPFreShWULAr+MkbsF8A7gWJ7EiV0ErpUo+v3yAwkTq3/OfYUa//WVCtKoavrT8L1xJxKyD5TnACzlXnsEeMr9D18JjcGuiATi3XzH1VbBLyd2gNqfrlWyG2hQ17aid1AW86fRQzQxzlYGr5M3MleQ9mS/YxITLfvya/qqhlCCDd7b592XjX9iOX0nLQaxYALFtMFprOXsa7UojgqNdaN/95S9r4cs5Z1FvOEDi86oX1UTppPZCiHWJO6tdkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785979212; c=relaxed/relaxed;
	bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=keD2+r8knieAdMpzbvPW4O6ySWdQIi0sTEDEYeXglLEgi3V0y2adAD2t3+830Oo/VfJ8y6LbEKwhXY0RFU27PcbQGVY0us/2r+crFPzMvCThzh6wVO4884MB1HDj/Tkxh5rKjbeyQiSBLWNjJHu6WvkEgDQCrNn81qfGTqdKHoSgBmz8N0no002IDiu9R1s7K4kYDRzkQDeJZwlISzaEMF7k1M5MtHNSCrgmer4iO749kdf5Z5c2mZjrLM3LKAmlGvEwxbBzpIlccsp3v98KtErcoFDDrltYa1ttTyoWCGLhPmIrrtJ/CtToyAzofN/9OT0zuLA0N4Vmrmo/51Gkhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nAXFjPxz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nAXFjPxz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFqG21pxzz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 11:20:08 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2cea3004256so20420065ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 18:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785979206; x=1786584006; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
        b=nAXFjPxzohrHjIdopatnsHnJkuYRUULXyqeDHXwCUzDsPKZvoeg0KV5XCrqT8YogIW
         hWB1UHTlJILv/HxcslsA9VyBY16Oe+XIHCnMfOj/ikar1GM8t0Ixq+7UkybQBqxqfX3D
         xy7wKCf8mQSPWPJGhI2zHy8D+kEio70HQ3x0RNuq6M6Cd4yXG/kgwgOoci7/mDRkqjW2
         szALOLH/yvIk7kVm25/2MEY751b0BUqAR8UPC6FY8TfTuqmkrgau5EDC7SNdsFSuj6EE
         93XgYSA/CJCjVlHeF/UBJ7YkIFFvR811bQitLZ9KqLXxD40FmH/Tbs31naBi9J7BvdgY
         QMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785979206; x=1786584006;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
        b=IXeg+Cd0Qv/S1dla0Os4c1mEnjS97TIAXiHw1SFfFq7girddfDzCnAfxHzDT0QM6YQ
         mz22rXHCr72PqrfKt2JkpAKR9YbCrmA8st42z0RtQJEgRMgj2/QsLo/HuwNy1YdjZYfw
         fiagQFmRL/ArvfAYb2kz16Ae/nJGESt0IaMfyZ15Vx82cPLrENq6oPdUiH2TtNIYurpS
         E7IGfEvkzLS2+6yrp97gYzoUli0mNd3Nh1W0Ztciosn16hCGfb9kYGeBUxb6me2B9OzO
         M075BpkcZVzf5aiGiMlYPih3mpGtF1r5TlxR9sbQlEF3oRovzP7mCRljFLmTT/5H37li
         gphg==
X-Forwarded-Encrypted: i=1; AHgh+RpZGa0m3cN5K45+iUrDnY0Q8ERAvJmD5MKqLJxi3kcnFzzTI7n13rKAYxk4h4Myhee8dDKt50tx70ZgP0g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx88WANBbyQFhfCIXejzFKH1t7Uv2e+uJ+SpC7pwkWFjHzJHVgR
	7OI6usc1JJGIM0r0klq+gKoiDdh+sOHP8wbAjB/rycF+GtiJ++WZ15+L
X-Gm-Gg: AR+sD10qmDbccboOOdE/txBNZv4DUUAK8oaO2ScB4gcFre344ysXpA/Vu1/yEJY0rJs
	rpvi5ullj1C/u8bj2mKegMG/4LdIqS/A2F3Uch2nWb/S+3L6T9qUSxBhSmqpD5s6t3zEsMBUzjm
	87pzA2sNkCHVaU845YiwAzXXR3Th2+SbACTrIpdJrgXiJVAaALlYzDjYJZ1G3Kh4/ORkSvuUdc+
	DAtR8KSx9lZv739BajYY8NlFbj1oloaX6N9jLT9pOVrdXTupNsQ/PptiLtaoz3uxmSdlKC+5iJg
	5E9cXOwlIoCFJJx0wG2JvGXPRPj2pHJeWa7Uxx3fPKd+St/Xr/KLI8RoUjXoVFv10dI2bBUPy3s
	AQ4Hx0jKG1C6/f5eNR/H8AT61HbW31s52U4rBbh+YzJpW01JTxzbPrn1lHkqAzCmi23KGGltoDf
	fidaCuXPkYf0WNHNT99VS64P2VPMUPxb7eRAK3OV4a/vceYkC8ObkKjXtRyAo=
X-Received: by 2002:a05:6a20:d4b:b0:3c3:a722:59cc with SMTP id adf61e73a8af0-3cb85ea6f6bmr13948363637.22.1785979206355;
        Wed, 05 Aug 2026 18:20:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d4929sm21821361eec.30.2026.08.05.18.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 18:20:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: PPC: booke: Use min() in watchdog_next_timeout()
In-Reply-To: <20260804112011.59416-3-thorsten.blum@linux.dev>
Date: Thu, 06 Aug 2026 06:49:29 +0530
Message-ID: <se4skpum.ritesh.list@gmail.com>
References: <20260804112011.59416-3-thorsten.blum@linux.dev>
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

Thorsten Blum <thorsten.blum@linux.dev> writes:

> Replace min_t() with the simpler min() macro since the values are
> unsigned and compatible.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


