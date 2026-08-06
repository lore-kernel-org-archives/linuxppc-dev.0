Return-Path: <linuxppc-dev+bounces-25460-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E1EC55174
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 01:20:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFqGY5vjDz2yh4;
	Thu, 06 Aug 2026 11:20:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785979237;
	cv=none; b=EVKBIJ1HaNAyzzJzDCLPn2KPRYJO9l8BYF+YJNrDttb9SYaSs1nQVKy+LYzEL5tAV1N5G3U2oxj5+xZTKWNI3uLBfAeBjxt/qoaS0JOImbWCs7gL92/2ZeOiYN3F005KJBkNCuiY+h0Vr3VWm3C6wSrtK0/7SYxUAjZqyefFZhmd4Pvk+EtsRsekg0MmytJKrHoD1f/KJV+ICF0sP/xkemVWzrgpaWeMgrjC6iEnNc86jhqWC+wqaV4WMphKYat1OpJBeeL6bubQ+dTb/oMEFvdc8mfzuPme2rhyQE7UEe3lLYxppB8RcBYWsMY0yb2ffMPa/hvI0O8vZ2otC6/feQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785979237; c=relaxed/relaxed;
	bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Inp0gRHO68oaSi9X/i2e5eBJqodhjmeQ7nN3wy+oNJ/E1z+GvuZHZhqhFWzLgrn1gdwb42PkXdJUqaIj254paOEz4GnfdiNagVuXm3r3zjI0j1z++Y0wv5LjmEHho3m70xmcrwlz22qm0dC79n18W8hux8mx3ZakkKVLCfBj+0j7Obu8z22ty+Sm/ahYhlm5mTaGiZGXeaki8CO5Dhpwt3a2BMz2vke2zjbBnsDZFF+Q7rAo++Dcqd6LTv73E+BIviFVDG2iYbmQwhaii6G7NwhCZzw/d/hvRCHmPcwYVJkAVVnzI75tT0SQWTCDfDeWRBjYOluCCFLho8LK5dauxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Grcgrbqm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Grcgrbqm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFqGX68Ylz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 11:20:36 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c9aea40d799so943726a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 18:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785979234; x=1786584034; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
        b=GrcgrbqmFN9Si15PWmHSlMx1jzCNGWCn36uU2bI3JKMt6IVNs0wyybDEL0tcBPIy2+
         2OFYV3l/366eqsEIGz4b8b9uQAU6yFz5WcDEs/haMjih+kSRLsOezIxq1nYOuDiFcVBc
         PPEXF5qQvvxtNeq72G0NWfLTWJp9oSv4QhC+qSQhJIZrA22fcbwE+1xRjKGQkpf8nXAH
         GOH3MQUgnG4LazrNrSex7EQzd9f3zLaHxH9fGf5iMUMnQa8QgMgeliDN4dRU+a26DgrN
         9+q4evoXntjHEeFFQP+WB9utfPVlLUXanAgNtlZnx0jVmLtHNELwK3weQVbVpnvHQm8u
         0Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785979234; x=1786584034;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
        b=QVxdfFz5F/ryi8kqUNDGqKNs4URK4MJ8dB2qTkOpiQMseUSuMBkxWYpTs92v5vPj08
         zqEdzqDM2Q+ij9ePMpfxjOcaTk9IGiiOc9bZLuMwqLWCouqApn/VC7d6dvGUySe3mRvr
         14GPnq4oZQZaSh/bTC4DMr9Gi3DwLH8DkzfbC0leXCKjuaiRPaEdTDricCp+r5VKAgNd
         c2zpYjSmzxR95ly1L8BDnwBI8f0CeKnXmqI07wnXjqZ12AUvBxHo5shGk/xNMDoro1OJ
         m0XiHBatU3uO2h4DpI6YLOQfq6IBr5ydhfAcFh18L/Kc1NZBH0KYOrsy4dixa2TWllIZ
         xpPg==
X-Forwarded-Encrypted: i=1; AHgh+RounkVmwtfOyVPJW6rXIO+kFv97xWsEG3W74m6kbyZkphWKk4IS4+Ft2YMEmpQwfLL9cG038Ro47+TJJRE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwmZkxWniKMQ32MekD4ZTpsjLLkoFGv0VhYQ1rnM9SSYlTlecF3
	3jGg2cQDNE0J4MrTDGNxW9VdxiXSXah5B6l4nMEmfNGOx2VYYbzSQs/5
X-Gm-Gg: AR+sD12n0qZLUi4Q3YOFmlR0Tk1f+7b+XXGgiHc+AMaPWhkv8ii2nyZUxuYhGa/MHbr
	RVc01wRTc2gO0B8vd+X85I7mEaC3Z9iVNb7zpP4pVjwttwW6u1Z6rOdgwaJ54V8x6T4ECQnppJR
	5Kc0D9S59KHoqYFCTdC01CvjIcBhIIlcgb0QQNN+VbEssuU5uJ9Tt+4n6z4pKfDSVd7iIexu1cE
	gYJvqyLQXU+pOnwx44eO8935i8aEC5IYUKnu9oTdwOho7wTgQTu85PnC0BZy1p7QNcl7atux7Jt
	qW7rNfMrBnY420DoP+3jT5g3BrK5Pg0t+0SEtHjxbc1W59T4Wx6yAJZF19E2JCOCRrIrFaPLUDn
	5pi6nTfTmaX/F2a3fEo5KI7A2oEqX7EaMyl+Mook/me22fRiDrmI5LI9uy+T6QCSS2uWyoOpGZ3
	iXJ5xP2vq5pt65pEg00cHNs546cK+SdVAsKm+vCXIoZrv0vzpxa1DhJ10vO14=
X-Received: by 2002:a05:6a20:4307:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3cb85dee55emr11951526637.1.1785979233570;
        Wed, 05 Aug 2026 18:20:33 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586162e80sm23448029eec.0.2026.08.05.18.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 18:20:32 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: PPC: Use min() in kvm_vm_ioctl_check_extension()
In-Reply-To: <20260804112011.59416-4-thorsten.blum@linux.dev>
Date: Thu, 06 Aug 2026 06:50:11 +0530
Message-ID: <qzkckptg.ritesh.list@gmail.com>
References: <20260804112011.59416-3-thorsten.blum@linux.dev> <20260804112011.59416-4-thorsten.blum@linux.dev>
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

