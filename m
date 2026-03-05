Return-Path: <linuxppc-dev+bounces-17783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A3FF3D337
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:09:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRbcQ08kgz3c5y;
	Fri, 06 Mar 2026 04:09:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::64a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772730565;
	cv=none; b=AlNEaROVMp6+i8XUxdOSUtG37VuBgFLGEGLAPxoWX00mMkRIDQrK3eDJ+Hq3nIN/CFhJKofxOWxTtJiIUGnChvLU5vcFM1HUpXSxVBNA5Orl/Ho8aHEs2Use1slOQtJxiY9vODXXBvYwzt0in/xipDSEvMb+plk9iyPlr39wVVhnDRLSXlbHtVoUEoBVWeOA5ayPg8OQSv/go56VkC9cD1x4lHcG+jm1JWiZB7rGX5e4ma333sck90G88fMqDWxG58Xq8tV51iX4WX7t1OMTGLQzgYzG6qu5t+W6vCSDcXlQm359jyI1Zx7Z9OchwM73noFB+WW6bQrXiB2Zvqdhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772730565; c=relaxed/relaxed;
	bh=mXHR39iK88pUvmfbC1CZBCR/+Uyn5F0o8E7v0BeMRFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AQNHlgii77TlDIZ/Qarw6vsaXbzEX6eL7XYZmnkmfqWx3RXP0QLQCTKSqY1iF52K6PaBU7SQqBdf2eY40qqWsuhWIMyua2ak4SWGM0HqitCG6HYvu7PL6KwBLODf3QAgr+AeQ/czzP7jQop4cH2tZCj6Hj3RsPDG/+yP8vluDgLmsX+qUpCFZkYbxLqUQUe5YXN/lvP2lBrSIbdK487OObvWmjl95YPw3umDzsGkSFN4xCGpdmaeHsmCDcae4IAy+Xxz9xukRmBnFiPAzQw8Qt0RBs8htHCLbgZBcffjxG1S7MTpN0cLXBb3Za6QORqMP4Biqv3/PZT/TzjbYItRDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=bAWopvIQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3wlipaqykdc0bnjwslpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=bAWopvIQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3wlipaqykdc0bnjwslpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRbcN4zcbz3c5f
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 04:09:23 +1100 (AEDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2ae467f128fso48041835ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730561; x=1773335361; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXHR39iK88pUvmfbC1CZBCR/+Uyn5F0o8E7v0BeMRFQ=;
        b=bAWopvIQBwC+ao4mjlbRQmtT+T6n3Z9iK6oxQDjTxuR8QTxb0zdWiyv+oxhseO3JbG
         RezL8Oa5qe25daGwsxKnJ7ztwklP2DVB0a8TGPnQnmmtuecguehIQIYplO2npHYJbZkH
         z99oOGxnxN/LppdLElhbfySzjQOp6ETRv98WShjF1gtM3AO6DgUiXa+btIFZWizCmUnC
         yP1oJhYcyop9yQUXYXgttBZpbL4CkswUkZTDJJwx8rPEau0dxprWO5BwQQT/OG/7baDZ
         Dqnm+VZD6KuxqAbSvqLjqqQZQfW3/NOy1/Zhf/qKYYpMPzDDR4H7YXFXww6czZhzNrRX
         w2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730561; x=1773335361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXHR39iK88pUvmfbC1CZBCR/+Uyn5F0o8E7v0BeMRFQ=;
        b=O7scIyVOVks04Mu4ElOkFr5NuUkfEnBXra4Ow0i+fzWhR8t4pVFul7y6FZpc/8bYyT
         V0v4UgoBdRKUO83Ue1K1dmbzCQzlTX1GTspRNJodjDnoarFhAqheXwotqsq7KPyDUTOm
         7AmLH1AD9q2Lt6OI4DwXG5ZLeTrou3YSNM56D+sfKqkh6t0xcrszE8D7GogEraJBjTNq
         YKiVfQNJxvRvbhKgtSu3m9QAFkWG7v6d2VwXrrNTN9zKyfrCwPfWdIhw82uhIUCBaug6
         sQITqshU8qQLYOLuobrI1BQoP/z6E3EOn6eY5vFq6BfoayZKH+RUIHI+PejOy4K42qAG
         Cb8w==
X-Gm-Message-State: AOJu0YxTBODEjB85ThnJcoa4NnXcLP/040CXukVNlRFtFD3DSE4YEmSP
	aF8OcB4CCLBFEdVwlhRzLW57n4OUFgLg7l5sU0p2KgFWNx+D9izgsCmYiiLpU5oqWMoVjGtROF+
	fkbwF2w==
X-Received: from plbz5.prod.google.com ([2002:a17:902:ee05:b0:2ae:4edd:69c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b47:b0:2ae:6d9e:ed5a
 with SMTP id d9443c01a7336-2ae801506c0mr3897215ad.13.1772730560854; Thu, 05
 Mar 2026 09:09:20 -0800 (PST)
Date: Thu,  5 Mar 2026 09:07:39 -0800
In-Reply-To: <20260303190339.974325-1-seanjc@google.com>
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
Mime-Version: 1.0
References: <20260303190339.974325-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <177272543796.1535167.14939828079649935273.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: PPC: e500: Fix build error due to crappy KVM code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 03 Mar 2026 11:03:37 -0800, Sean Christopherson wrote:
> Fix an e500 build error that was introduced by the recent kmalloc_obj()
> conversion, but in reality is due to crappy KVM code that has existed for
> ~13 years.
> 
> I'm taking this through kvm-x86 fixes, because it's breaking my testing setup,
> and obviously no one cares about KVM e500 since PPC_WERROR is default 'y' and
> needs to be explicitly disabled via PPC_DISABLE_WERROR.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/2] KVM: PPC: e500: Fix build error due to using kmalloc_obj() with wrong type
      https://github.com/kvm-x86/linux/commit/a223ccf0af6e
[2/2] KVM: PPC: e500: Rip out "struct tlbe_ref"
      https://github.com/kvm-x86/linux/commit/3271085a7f10

--
https://github.com/kvm-x86/linux/tree/next

