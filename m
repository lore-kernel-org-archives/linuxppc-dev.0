Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D5606A31E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW94E4Kt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW94E4Kt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW94E4Kt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbVtw67ybz2yMK;
	Fri, 27 Nov 2026 22:05:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795777512;
	cv=none; b=C37WEMntZBlfhuQiZAyaxVgQJ76xWUjQ0SlK+IGipV/10JJFhCuIbIehzZB0W7wVj4Sx7QjNjFXjX/b02z5fhA4e3favK1vBDS3Tgh6//gnMTUAJq/kutzGBODvWB8bpj0JY5ml1fZDQeCx0gB91GAoiGKaLfIOW9cI7g17S27135y/eCfLLRURnkMbQ0gOAqo7z5J4PVKmDej7DwUPzwdhq43mkOZVFCxAxvL+vRoQZmFnbdLwt+9L5VjEf+VA/bvGE+YtM98h/71ipuJRxy6iDeuPpWtrYek6enVPE0G/ypEcc0P7H7ACIcgVLcUuf1f3Io8gx4EO6L6C0fcoYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795777512; c=relaxed/relaxed;
	bh=qcpX6YwnHTFKfGu87lTd7oqauZWlHU08Aks6/ht/Glk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgrTq/Zb6H/LOBuuh/RWVVBKVr9PYhf8OOp2IQlN877+X+FSuPiFyQzctJMVg4umER+LYXMmmbBNTJO7nORwD5NFzlmLm0w1d7FhjfmIyW1Y2IzkuMZGQ9BZmmH4UQIF4PpLzXYjH1RSc3x8gdtEU4Wdj3nc0xnqfWO3dJz58eXEkRSmqhKZmlVrLux3Y0J1xbsk9Cm7rGKy8rOh4cLxpHpxz/I4iWw1TvOd69ubPstj5kiAGsVqLVmW9qnrfuIR5YFLB7nCh7NwBlnNJXZN/b2Kpz49D+QI+TgFYaXS77v/xoQ/32ahkJfhQBg4sDPZtyTPnSGqLzTRJJhIoGPQ1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW94E4Kt; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW94E4Kt; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW94E4Kt; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW94E4Kt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW94E4Kt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UW94E4Kt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbVtv2j2jz2yLH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 22:05:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795777505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcpX6YwnHTFKfGu87lTd7oqauZWlHU08Aks6/ht/Glk=;
	b=UW94E4KtLweMjW3Kvkg1ZV8Umk0tb6oTMro84Xjdp90wzjyBJUYxIdWPT+hA3xmlRvXytn
	R/8THkF1hwMc5YmzN7+khlHUKejFMN35xJIf50EFWZBUZGYqXHcJmZVxbSKKBnK6F7legV
	/2xFPtyFoq2JzUjSolGJypKXDb+NEz8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795777505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcpX6YwnHTFKfGu87lTd7oqauZWlHU08Aks6/ht/Glk=;
	b=UW94E4KtLweMjW3Kvkg1ZV8Umk0tb6oTMro84Xjdp90wzjyBJUYxIdWPT+hA3xmlRvXytn
	R/8THkF1hwMc5YmzN7+khlHUKejFMN35xJIf50EFWZBUZGYqXHcJmZVxbSKKBnK6F7legV
	/2xFPtyFoq2JzUjSolGJypKXDb+NEz8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795777505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcpX6YwnHTFKfGu87lTd7oqauZWlHU08Aks6/ht/Glk=;
	b=UW94E4KtLweMjW3Kvkg1ZV8Umk0tb6oTMro84Xjdp90wzjyBJUYxIdWPT+hA3xmlRvXytn
	R/8THkF1hwMc5YmzN7+khlHUKejFMN35xJIf50EFWZBUZGYqXHcJmZVxbSKKBnK6F7legV
	/2xFPtyFoq2JzUjSolGJypKXDb+NEz8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-XamtFFCiPMytoRg1iydt4A-1; Fri, 27 Nov 2026 11:05:02 +0000
X-MC-Unique: XamtFFCiPMytoRg1iydt4A-1
X-Mimecast-MFC-AGG-ID: XamtFFCiPMytoRg1iydt4A_1795777501
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a82fb7e71eso4497336f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 03:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795777501; x=1796382301;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qcpX6YwnHTFKfGu87lTd7oqauZWlHU08Aks6/ht/Glk=;
        b=Tg12MKoLMGy8tIhMmk8rB9M2Okel5JEDi56tXdCwRgSM/asu5bRLazB79U6ThVsIcj
         C/TYXSY63UsxpXWCfYFH5YUs1H+nIgY5waVRDAuyBhZAA5l0fMz3b4ZdxCJh/thrxh4G
         XTPO+MBB9AevvO9Gpe5q1GJT6AFBP6aZ1D4Wt1amd1klXhH5ctlc/O+ZoWmi5NEC0euZ
         vdJ5/djnJrw4btaqpR3mq5RkfdLb8gAmv7py2nsksvYluh9Jzy3FixXzQt0PPWWS3IRi
         lGncvqGbFyYIU90+hhJ4/3xw/SWDmD2mH9tj6gpOoi8x97BtSe/KtxH2vQPKWry/JcLZ
         NgvA==
X-Forwarded-Encrypted: i=1; AL+hErH99QOoG7DR3NhkgrkMe1v73YdDb+KYQZZ8B+xqd1Aq/JKScribEb2GCOfamq8+UfilKaGelOvV7fgG1P4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/h0mHrzlX01QJ1ZpZ7CikYoTTv7t0gTzkkjq1E3pk3gwGnHekt
	b85EvEnK5omi1kDCANQx7Gu+n7SbKVxAiI3vW8sX/ifM6ygKFlSO1UWb08AOUK/s2asQh6dJniv
	v0PjLo5uS4jYwejKOnmPatJ38jwUIanssZAshZo5uy8N1kQgIrGVLsY17foFYBaqWji4=
X-Gm-Gg: AZFdTZeXx0yiPMStPfcp88LlmyvWP1BHl6yGv5AKdQ2+4YRvSClehz2xkSIe65g9a/e
	LY1rGQcKp8rtfAbckBz8IYthzMqLNXgVSdq2LHMGtst4lTpS3w1VCBo8wHTKmgxJLVf2Rrp9kKR
	E7NoCiPp4olPvrM+cn7jU0wtqQW4kPtNSUoGuZE/HTP/UmXZ2OAfvN1y3lyWvcJRUBvjDpjJzp2
	N8uumWI6KDab4F9SCvQRGrg5MY3xoUKD+ZofWqntE7UF04RU33vcQeslxJIv4fMciqCzda8sZ0p
	SUqC6rha5BBQfu9GHgtS7WRkJhRCaXbviu0J4INGR2j43TuGQyrPiSfjZ1SqboIxcX9VOOJnLy2
	W7OHve1eQ9ZhU1Cx+OV+5TejqItlZn8WF/hENkcrlm/UBz8DP740wzfj5rzvXcGhO25iXGEQzCc
	OVxZTYvcLDu+fdbqSzQK8yHC5vRxkBfN2a+GHPXREWNucP
X-Received: by 2002:a05:6000:4812:b0:4aa:8da8:4bbc with SMTP id ffacd0b85a97d-4abb5702827mr43599204f8f.36.1795777500984;
        Fri, 27 Nov 2026 03:05:00 -0800 (PST)
X-Received: by 2002:a05:6000:4812:b0:4aa:8da8:4bbc with SMTP id ffacd0b85a97d-4abb5702827mr43599159f8f.36.1795777500541;
        Fri, 27 Nov 2026 03:05:00 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989b3sm46514173f8f.51.2026.11.27.03.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 03:05:00 -0800 (PST)
Message-ID: <fa61e083-d6c0-40d2-b25a-f83cad368397@redhat.com>
Date: Fri, 27 Nov 2026 12:04:58 +0100
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
Subject: Re: [PATCH v8 net-next 8/9] net: dsa: netc: add PTP two-step
 timestamping support
To: wei.fang@oss.nxp.com, xiaoning.wang@nxp.com, andrew@lunn.ch,
 olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, linux@armlinux.org.uk
Cc: wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
 <20261119030534.1892935-9-wei.fang@oss.nxp.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261119030534.1892935-9-wei.fang@oss.nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -laK0cK1E8m-Io8nfwm9Vcxgy6jG7U5wqOFKZyiUQLk_1795777501
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

On 11/19/26 04:05, wei.fang@oss.nxp.com wrote:
> +static void netc_port_tstamp_timeout_work(struct work_struct *work)
> +{
> +	struct netc_port *np = container_of(work, struct netc_port,
> +					    tstamp_timeout_work.work);
> +	struct sk_buff_head free_list;
> +	struct sk_buff *skb, *skb_tmp;
> +
> +	__skb_queue_head_init(&free_list);
> +
> +	spin_lock_bh(&np->tstamp_lock);
> +	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
> +		if (time_is_after_jiffies64(NETC_SKB_CB(skb)->ptp_tx_time +
> +					    NETC_TSTAMP_TIMEOUT))
> +			continue;

Not a blocker, but I think that starting from the tail would be better:
the loop can be stop as soon as non expired skb is seen.

In the hopefully common scenario of no timeouts, the worker will peek
a single skb, instead of traversing a possibly long list.

Can be a follow-up.

/P


