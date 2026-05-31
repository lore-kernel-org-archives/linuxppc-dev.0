Return-Path: <linuxppc-dev+bounces-21772-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6A9CD6E56
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2026 21:05:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gT8k620x9z2y7r;
	Mon, 01 Jun 2026 07:05:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780236151;
	cv=none; b=dzpGvnvlaYp1wIhhid65CwvHEmTLnXhZJJ9xsb1PKlLJKGqUF6jacWVHZ2ywvBDW8q5ViBEmzTRQby1CPCgP7PNcZg/NmTQ6TwbfdqLKroG8LOYPPw7WJynJjqz9PW8TIYUNA71Fk2cPGRKDzMzQo0OzjGtQE8zwx7bahntWcE/8WRAu1glyeSMMNUd52oFbc1KXaqUu6tAm8v6rAUlytvyhtWyAt/glxrUUJpsewCb5rjqO/Uf2n/pcWcrGxXhZ1kPI+gFMwdioP6lTI6Y72W4Ws/9RFvejV2JmcBBuCU7t6NexjWyyLoeN2SnQCvzp5cdKm8d9nMff/5BfoKhY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780236151; c=relaxed/relaxed;
	bh=AgnkOucJ4lynEbyGWzUWoBKHmcQTYyOypcyzzzs1xrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmqjo2HiMK9W+13I/O/nBFTlEeSmeAqH/Z2ugEeJiKF/abKiuf0sXP8MXff8/NMYttatRdizyhAFW5nvjgQLCd+Nd6k462aBGa4Sk4x2DCZIvVumSLRnn/sElADmCd7UrBGnKMlhqCyE6ZuLE+XgMiMnauolMIB0Uiwc5kkdy+oPfaoj83D71YSP3PYTYTlb3du/OqMFa/aI5LDTQmd4c5qQsMs1jrNlQn6kLcyeDzNus9Mskuj+fgg/t2v4D8CcT8jREQQDzXiVL0gsVZwz+Up0xZhT5JXsPN+MDPxRgeWfhnpqGYpYFGDtAijNfBGZg71IPAJd78sL4aj36mnECA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LFHMm0r+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=isyanfei.xu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LFHMm0r+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=isyanfei.xu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSzLZ1JnRz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 00:02:29 +1000 (AEST)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-304e83724bfso3045218eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780236146; x=1780840946; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgnkOucJ4lynEbyGWzUWoBKHmcQTYyOypcyzzzs1xrc=;
        b=LFHMm0r+XkjHgE4WAe3kSEjpe83Na0cU5WnjAxx9IVxSbRW1X/2hzSntlUDpjE0lE1
         Z+Z+hEpolidpVDWkMRcNCwxPdcBPlcNdjcSPgbMMJTDkUV/YVITDP2TvfBcsD/6AsC5n
         VApf8mAZbaGQqfezWcnImv+EoQSEh6d6tFOyD2anEzKuzIFkaDGMImUxFvKEBssOzpXC
         XcqHJOcpMPBBzP5R46WouZmPrAZ99wWOKM1x0aSGOZfCWy9SFAvuWHv+GA3aG9imPKh6
         kOFMAbk64EMiNay5YRw9SMmGx5KOC0ul+4yO50rL9cRJa8sGdaEkRMS9R3EoAOFWXS7M
         aCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780236146; x=1780840946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgnkOucJ4lynEbyGWzUWoBKHmcQTYyOypcyzzzs1xrc=;
        b=Ltm1ms3/tklUwLd/9RPB40qN1fg0I73ooseuOdU2H8ZxCWHxpgSvQ4HcULSnlFo+qM
         hoh5+R7vt+xfN13X1o/c42Y458DvNIKPMmMIcf+i355L9vjpx8ZXk7UhA35R00Z1HlXM
         XewRlBgvIIWtjeLtHbgyuWYShXJpqhFeLs9krccWhjg58jB5rp0HoyDdI2J8Gbd1dzeZ
         oZ4ZAvg4+lCa3fN77avGCwDZOlwY9ElloMAQHhOaqbQ624k9AxrmR55B/6w6lpMtKjNA
         FtHyUnznolvQfRNB5lfKTzP4LREl758tFD+N998NAniSih7XUyyimQFrRB4Lqg3BJxOz
         i3/A==
X-Forwarded-Encrypted: i=1; AFNElJ+lqoa/SL46VEL4kcQ08iwY2iuzPwX3gEaNaGzqekfaJBXFCwBMxOMfAxl4fFujb79ytx1YIHC9iAjkKjk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8OqTbUsSg/VDjo85R+zvcmSnr845lkftovbcvNR28RrtnMRYD
	1PdtTKLo8X1eKXpWWTdbO4LkoIwrkamd6JbDGBy2i8ZzyIKTck+6Y5FC
X-Gm-Gg: Acq92OEmOQ+/O7usvKWyRQtGQ4mNyLwLRXPFyUDV4OG2MxYzY7z8RhRu1gldB9B1+zf
	4UVRPY4lNY3qblmU7MFRXXx9IUQg6J06EhmR4FhTfvZbDAWJZd7ghkaGfMZEea0ns/NmJph8cHl
	Pbb0y7gQmFlY3PFYUG7v58SQcwefSrVT7m04ilBqbC3SK7H8oMIzcBEjcIvyOb4Q46aUh1HZET2
	id0sYQoPskt5ECJCBLSGliMa/zBNF8Km0uAhaTdvdCbXwVWrrfxMr3DyEHea9TsOJbHVAbAnH9l
	s/LRWngpCLnC8tofBgzbfYcib+3drYGRB12WcV+Hm03Pin4zYq9i3PSAlE0sWW2frfbVGZrtRPe
	Y/2AlpalnO8ll82QLXfqriPWADjM3T2xPjU0WhAJ2y6Czk3h9udrCG9lrDRmVSOS8o/cr/6TBz0
	oF9K19yRkOINKe9t4ApgkLY74XBC/2KDwLw1fJDmboLI1+22OLazz9Zpvgvg==
X-Received: by 2002:a05:7300:3246:b0:304:6448:dfd7 with SMTP id 5a478bee46e88-304fa5e85demr3452313eec.18.1780236146056;
        Sun, 31 May 2026 07:02:26 -0700 (PDT)
Received: from [10.4.72.5] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53d14fsm6449412eec.17.2026.05.31.07.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 07:02:25 -0700 (PDT)
Message-ID: <10054db1-413b-42f7-b38f-f562b8de432f@gmail.com>
Date: Sun, 31 May 2026 22:02:19 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Validate irqchip index for LoongArch and PowerPC
To: Sean Christopherson <seanjc@google.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org,
 maddy@linux.ibm.com, npiggin@gmail.com, sashiko-reviews@lists.linux.dev,
 pbonzini@redhat.com, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com,
 fangying.tommy@bytedance.com, Sashiko <sashiko-bot@kernel.org>
References: <20260525070154.495455-1-yanfei.xu@bytedance.com>
 <ahoYdrs9dVzp6Ps6@google.com>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <ahoYdrs9dVzp6Ps6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026/5/30 06:51, Sean Christopherson wrote:
> Can you split this into two patches, and send a v2?  I suspect the reason no one
> has picked this up is because it straddles two completely different (sub)subsystems.

That makes sense. Done :)

Thanks,
Yanfei

>
> That would also make it easier to get the fixes backported to stable trees.  PPC
> has been around a lot longer than LoongArch, so I assume the PPC fix will need to
> go further back in time.
>
> Thanks!

