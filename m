Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C8606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGrEuIKD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YeRmKD15;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGrEuIKD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPbQF52G6z2xWR;
	Wed, 11 Nov 2026 18:54:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794383669;
	cv=none; b=QfJrDKmbizvAyvm7wCBqixP/YNAFHXyVj0QUdv62NKsXymdQoUqseNo27r8tV/dZuZf9LURqpsUh5wyPZd3z0EzuKqP4u3MEosBrOY9XMOq0iHsst/wmF9q0SAaSxuE4nQms2T3UH0Dg+A9Coh2+ALcWKNeZepZpWhylPzsslBsrObrpj7IVsmUTfa/jgA/j+cTSPULbyHcwHyQdaAWgM4fZ9vyUBxbXyiPeLfWmm1AePnXWDsKJCNPCAlXGJsAj4jK6hvVS9gzuqHITMxslbj/fDKDHCLUNkdbwILHeqzh3bmqb8a79i5WDbVZAPVuEgwQum0dTDmaxQcK51l1YPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794383669; c=relaxed/relaxed;
	bh=rMmIOYVl64Nfr02Tf6vKaYBHgvMLGqEBK3OO7jbaHrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y615pLe34HoW/Pmg/Cs0FffTeIyyAVpxtKeo9uTZXHCgYwlxwnIPTuXUGOW9hYUOTT7paT9qErWg2vZNKcVb3U4atnhj4RbfM1a0x2Kk5FjZsJUxUIk3peOqJg40BQIbj28Ym0hKUTPpfd4m8Zw2InVBpqvNXlUCCTBS3g53JnN/dBNC72LAbZEUMdAiEtpWDGGyfdLgVgailuwUfGMMRXwLMhyYJ5nnK81rVVQGMcser3P2dEoiLWa6w5VRtxCp1U1hyYohVohfOH1gserBPN9T/iJaRe34NXZKg7Fo6z2bJUAPflyVmrHsBoh+choPcC14LgzkbFHJQUg6tQOjbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGrEuIKD; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YeRmKD15; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGrEuIKD; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGrEuIKD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YeRmKD15;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGrEuIKD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPbQD0jZ8z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 18:54:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794383662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rMmIOYVl64Nfr02Tf6vKaYBHgvMLGqEBK3OO7jbaHrs=;
	b=KGrEuIKD/hFyC68kL5L/Zdh9PDGrGhgfMDmCoJdSVwLauTAGKEBLXFlm34Y5QCuYlGGqbO
	IiyTHttMAf5gWsgM+szorTRgn2y8iBIrK+93HXwxK5l9HNru/l9uThx9LbOXiaVSgn4EhF
	zUcl+W/zvvU6CMh3Zt6nrH/dyhGYTf8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794383663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rMmIOYVl64Nfr02Tf6vKaYBHgvMLGqEBK3OO7jbaHrs=;
	b=YeRmKD15jWFUDh3OW4FPBhOfoC/T83Aq3k1OeAs82zXbnD0cArk6IJ+ENncqDYpd2+z5ys
	pcIkzHwchIu5hdwKv7I2w3wGrvod0W/YOf0xSN9Wu8DJs/8FHUb6uQWmsbWWY909BZUG85
	3fgRiHZ2P9310C27Ja1LomxCm9BwpwY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794383662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rMmIOYVl64Nfr02Tf6vKaYBHgvMLGqEBK3OO7jbaHrs=;
	b=KGrEuIKD/hFyC68kL5L/Zdh9PDGrGhgfMDmCoJdSVwLauTAGKEBLXFlm34Y5QCuYlGGqbO
	IiyTHttMAf5gWsgM+szorTRgn2y8iBIrK+93HXwxK5l9HNru/l9uThx9LbOXiaVSgn4EhF
	zUcl+W/zvvU6CMh3Zt6nrH/dyhGYTf8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-WxS0qgpdMe-7Qa9ijpUtUw-1; Wed, 11 Nov 2026 02:54:20 -0500
X-MC-Unique: WxS0qgpdMe-7Qa9ijpUtUw-1
X-Mimecast-MFC-AGG-ID: WxS0qgpdMe-7Qa9ijpUtUw_1794383660
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so29131555e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 23:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383659; x=1794988459;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rMmIOYVl64Nfr02Tf6vKaYBHgvMLGqEBK3OO7jbaHrs=;
        b=wgWLYB5gtglTzGKtpcLNhkKFDtoK1flpni56Mn2bklvuSMSaevbgXmxrpL6u8USYBD
         0Pt7z41hisi26TEpeTcdRT6uEM8ERUchVEAQeLDZ3dqFcEeDChGNOb+JdvdaYpiTb1XT
         cVR/E+b4o1bw+MNMXbp22fieeAN1I9ts9+EZD0TpnfGBFnwOPRXpmWVlZDHMMLDSK7xo
         WbGirAS7ftNjw+OqQJ8qHXndZtBatkYlO/KpPTruvYvp8iaROsb57XSAbz3PUmq7HefC
         B5k3YaC/+9v0AM5p/01/wLmZhDaPm7d/iQm619+BCWkMUUM7pIkVXr5B35YGqOhEFDuj
         5xYg==
X-Gm-Message-State: APuU4Z/zzXAkcUcgHSq9mlx8BpuymhFsksaqpD2gzRfYS+IebIx0d8q7
	KzXlrzSC1pdNeHZl+EmjhMBRzBFpS/bzMwS9buFuSnlM76lKDHQpXR4ymCyGYar+IeWdmCsIEVb
	Z9Iwvk1cwqyolJU2TFCga2mBwtDFCcxDUzKM5jchvW2MfQbdgMPsu/hzYdKYjbGx4L+s=
X-Gm-Gg: AYBFou33EFWqrghU7kopzBHTfBhqwIWDtauqi+776UnYQid8AXonD2SRBWht6oHi63q
	ri2ve3K49YSeAqEtZdjHocCEmL94vLY2EFCWyDQ3fMnM6LBt8ZT1/xzaanSc6kkbLiGUdKWIZxW
	VK5yXgl8P2f89Kjr4pgaNqvZyZEvDejqHGsWNLzXhTOYJh7zBiHpoxK4fDCp8Au3twDLXuLZ9uW
	8i3AMy/VG1axxAQjRhDJ46+9BQpUkt8pkDn5svlyHG5lg1ODS47rSiBel+/GxO6I1kf7vG2imFT
	oAJNRNs5TQt66t2IQWT3Pfkc8lfFmNxRnVejbdPx/VAceL+C9Vzqyk2xy3lHb67OYr4DaOd5Ut5
	+yDWJfESHy9y/pg+Uxxdo8qHBKWsvXjlBPWq5WzmFVv9/
X-Received: by 2002:a05:600c:34d4:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba09376eb2mr27495335e9.14.1794383659670;
        Tue, 10 Nov 2026 23:54:19 -0800 (PST)
X-Received: by 2002:a05:600c:34d4:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba09376eb2mr27495005e9.14.1794383659316;
        Tue, 10 Nov 2026 23:54:19 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01d9df5csm144516265e9.0.2026.11.10.23.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 23:54:18 -0800 (PST)
Message-ID: <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
Date: Wed, 11 Nov 2026 08:54:17 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Link with -z notext
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261110154415.46220-1-amachhiw@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V-YGknUykAIhBbw_RVwMaD0b021n4MdUGiFwTDRpbSk_1794383660
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
> Building the powerpc tests with GNU ld 2.46.1 fails when linking the
> test binaries:
> 
>    /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
  Hi!

This does not happen for me (using GNU ld version 2.46.1-1.fc44 from Fedora 
44) ... which compiler and distro are you using?

  Thomas


