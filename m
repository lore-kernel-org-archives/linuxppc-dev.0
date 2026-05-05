Return-Path: <linuxppc-dev+bounces-20472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280F4CD3430
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:44:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8trM31XPz2xfB;
	Tue, 05 May 2026 19:44:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777974243;
	cv=none; b=h07K6DTBHVBPFJCxdoryfr5YZ5wLCOrWDSQCyDl/hpO13/GxQ8jKi5Aoa1jHSFKo7kLrj9OW45OhUKxmuDiuPjCQD9EvaLEXNYarPLL8fBPx6zN3YV7jkBbwjvQziXsmuP5aKXhc96WVko3oUNsZAowKuSOhDKqjZ1PGA1xVsCW6RXpjpnZTmKLzpibj51HP4lGSTDe2xDYw8QStC4UoxON3KOBwiyMv55Pg/9mULFlK4+Y3Q3gNUsmTz/tf3OJvu7I7lCYVsxOie/4ZAo09D5dW+cJPo1Bx6aD4HNv+EuedMykUdWkcW9q7nie1O7Pns6LWBy7oCXsh8kqpxoER5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777974243; c=relaxed/relaxed;
	bh=kmyJRtAdai9pCgAp5lRpf5bBAJMr8C8LzYPKP+rHxUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktdGlejiPMk/lRDRQGp0cCE++5/W/CRYxgpOik4AaJTHZZpMYnPQngE95aGan4WH5e73ndHBUz70vdtPPwgxFAvP9OhCcRuR2pcUmAxzLXu8KtpoaaO3btKnpIH8lIsD9GavFWd76KCAayWuz7iyTFK3D5QXcCGTW/smQSvsadMdNKIpR/VMQC84xoMkROhlPU9CBEhzEVDMzYP4Mys1CULEAT2cW48WBrOT0GMwHY5vIrXjfSdCHaqNkzc8RQ6XNJv9ssEeA7EKoOsCl4szsayT5gQaGtv+ueYnXtSQMhY+fgKIqTsUXf3gHXZy2ytMoKFgKoANX3cKT+PL9JEzSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmaJ5jtd; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmaJ5jtd; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmaJ5jtd;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmaJ5jtd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8trL1HrHz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:44:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777974237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmyJRtAdai9pCgAp5lRpf5bBAJMr8C8LzYPKP+rHxUU=;
	b=dmaJ5jtdLJSdH9PZjrm+u5GTvfAiIM5WnJ5pZV7AxMxDAp13oCSR8MJ4clZAMBaG11nIxF
	V8XMZmIbxNu7zOPnMlIOHDZK7ycUwLxFzLNaCnf7FSzL37NXYkdnocz5I9Li2F5gCgDaou
	iKWnxA73AGYgd16jh6XY0Wxns1UJyno=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777974237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmyJRtAdai9pCgAp5lRpf5bBAJMr8C8LzYPKP+rHxUU=;
	b=dmaJ5jtdLJSdH9PZjrm+u5GTvfAiIM5WnJ5pZV7AxMxDAp13oCSR8MJ4clZAMBaG11nIxF
	V8XMZmIbxNu7zOPnMlIOHDZK7ycUwLxFzLNaCnf7FSzL37NXYkdnocz5I9Li2F5gCgDaou
	iKWnxA73AGYgd16jh6XY0Wxns1UJyno=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-xZP-YLZ8Pc21kvK_zQu_rw-1; Tue, 05 May 2026 05:43:55 -0400
X-MC-Unique: xZP-YLZ8Pc21kvK_zQu_rw-1
X-Mimecast-MFC-AGG-ID: xZP-YLZ8Pc21kvK_zQu_rw_1777974235
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d035e8593so13286235e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 02:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777974235; x=1778579035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmyJRtAdai9pCgAp5lRpf5bBAJMr8C8LzYPKP+rHxUU=;
        b=Q2+aLscUEnILrXWGn+Ay8fS6WcRR9Jw8Sg+JNtAxCiwRAfwY9rM0OYHthfK6kF/2xR
         BbRnJ2KjDrBY2a2szxp+cvsWodJT7KaRta81LKOjnH/z4HNA8GoYuivehHJM2hLM7jfd
         4PKeR+i8ESX7VpzB2uTdnydwsS4lDfgjtHDJl91bKqQW03xVwItfYXMYCQkV7+p5ctfr
         qCfoaQYMb1RkCvzbAQPj77Cvaissewxkso1MnaYhddSM3iPmIf7B8Tp92y5Y5w6f0THz
         Pfcd98tCK4hLvsidvEPcWIj0XzEIZJn4D+dIIBux2s+tvLMzHP3SrVFHWzPpSl52p9kp
         BT4A==
X-Forwarded-Encrypted: i=1; AFNElJ9CW1JYfOHJT9RoNxxJ6A7zNZV5BL05WxSYy/dYYPhf5j2mxneXdNLUv8puL3ZRo69rZAHM+1YvggFhRWY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxDR2pu7IZllbPhxrzPeT8feQuGBRekwpbyXmQM10NOJQ+dYh1K
	e8KkPv2DPeN67pHwYYMW3JCo/I8VHhH7TNMf+cIELhW/U050hLE0rxXNS0LX+5xyDAV60rAXB5A
	HEk6oVcyyUvgq3xtJz1WnnNKQOKYj2cyH1Q9U/01erkAg3FZxmq8/0Oue/dwhLMipnhs=
X-Gm-Gg: AeBDiesOfQor1AFdydlJoiwJsadW0+HdN0JKju6L+GtDXeHjGxBVOF3iLFdgZvnujGy
	RxZzRBQNmwuzIAQHM5WQluS5ryu9wLa+pwzTUqIZaOw3+GhkiroGMUXkIlVOgtaKyswHozqqEZC
	5EVlUovJHHd6uJH+rEqs/9empuixmPn0XRdjWM9lS5e9jGgC+w9Tu7cJTCDFzL7SWN5lcREa6Gb
	O53J8d9RAL2lm2RvLIrfB0k6GcuXskt4ajZzdbouFtnGXJTEPv/CghevQPsyw7edXYSTC5yE0M1
	7zfRKyU78b2uVSCnKkHkGQZ0Otg5SZqVAR79M9CCGwBc3If9h1+opJTlWRHwcLZagEdz8xdMnY8
	xb12hHvlkbp+JuXB3Bgu+iOAxvtPBWyhvmMU7DQs1a6+dRUPzFWCtF6l3EWIuJq+YjCo=
X-Received: by 2002:a05:600c:46d1:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48a988ca441mr218126915e9.29.1777974234582;
        Tue, 05 May 2026 02:43:54 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48a988ca441mr218126385e9.29.1777974234170;
        Tue, 05 May 2026 02:43:54 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm603894855e9.1.2026.05.05.02.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:43:53 -0700 (PDT)
Message-ID: <37382811-ba47-4432-9911-6c39acea4f86@redhat.com>
Date: Tue, 5 May 2026 11:43:51 +0200
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
Subject: Re: [PATCH v5 net-next 15/15] net: dsa: netc: add support for ethtool
 private statistics
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
 frank.li@nxp.com, chleroy@kernel.org, horms@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-16-wei.fang@nxp.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430024945.3413973-16-wei.fang@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8U9SEyiJ0wu7_Dm1y3ZCaSlyn3wK0LwqM3b0srj0ukY_1777974235
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 4:49 AM, Wei Fang wrote:
> Implement the ethtool private statistics interface to expose additional
> port-level and MAC-level counters that are not covered by the standard
> IEEE 802.3 statistics. The pMAC counters are only reported when the port
> supports Frame Preemption (802.1Qbu/802.3br).
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/dsa/netc/netc_ethtool.c   | 107 ++++++++++++++++++++++++++
>  drivers/net/dsa/netc/netc_main.c      |   3 +
>  drivers/net/dsa/netc/netc_switch.h    |   9 +++
>  drivers/net/dsa/netc/netc_switch_hw.h |  58 ++++++++++++++
>  4 files changed, 177 insertions(+)
> 
> diff --git a/drivers/net/dsa/netc/netc_ethtool.c b/drivers/net/dsa/netc/netc_ethtool.c
> index ac8940b5a85c..8d04db534347 100644
> --- a/drivers/net/dsa/netc/netc_ethtool.c
> +++ b/drivers/net/dsa/netc/netc_ethtool.c
> @@ -19,6 +19,56 @@ static const struct ethtool_rmon_hist_range netc_rmon_ranges[] = {
>  	{ }
>  };
>  
> +static const struct netc_port_stat netc_port_counters[] = {
> +	{ NETC_PTGSLACR,	"port gate late arrival frames" },
> +	{ NETC_PSDFTCR,	"port SDF transmit frames" },
> +	{ NETC_PSDFDDCR,	"port SDF drop duplicate frames" },
> +	{ NETC_PRXDCR,		"port rx discard frames" },
> +	{ NETC_PRXDCRRR,	"port rx discard read-reset" },
> +	{ NETC_PRXDCRR0,	"port rx discard reason 0" },
> +	{ NETC_PRXDCRR1,	"port rx discard reason 1" },
> +	{ NETC_PTXDCR,		"port tx discard frames" },
> +	{ NETC_PTXDCRRR,	"port tx discard read-reset" },
> +	{ NETC_PTXDCRR0,	"port tx discard reason 0" },
> +	{ NETC_PTXDCRR1,	"port tx discard reason 1" },
> +	{ NETC_BPDCR,		"bridge port discard frames" },
> +	{ NETC_BPDCRRR,	"bridge port discard read-reset" },
> +	{ NETC_BPDCRR0,	"bridge port discard reason 0" },
> +	{ NETC_BPDCRR1,	"bridge port discard reason 1" },
> +};
> +
> +static const struct netc_port_stat netc_emac_counters[] = {
> +	{ NETC_PM_ROCT(0),	"eMAC rx octets" },
> +	{ NETC_PM_RVLAN(0),	"eMAC rx VLAN frames" },
> +	{ NETC_PM_RERR(0),	"eMAC rx frame errors" },
> +	{ NETC_PM_RUCA(0),	"eMAC rx unicast frames" },
> +	{ NETC_PM_RDRP(0),	"eMAC rx dropped packets" },
> +	{ NETC_PM_RPKT(0),	"eMAC rx packets" },
> +	{ NETC_PM_TOCT(0),	"eMAC tx octets" },
> +	{ NETC_PM_TVLAN(0),	"eMAC tx VLAN frames" },
> +	{ NETC_PM_TFCS(0),	"eMAC tx FCS errors" },
> +	{ NETC_PM_TUCA(0),	"eMAC tx unicast frames" },
> +	{ NETC_PM_TPKT(0),	"eMAC tx packets" },
> +	{ NETC_PM_TUND(0),	"eMAC tx undersized packets" },
> +	{ NETC_PM_TIOCT(0),	"eMAC tx invalid octets" },
> +};
> +
> +static const struct netc_port_stat netc_pmac_counters[] = {
> +	{ NETC_PM_ROCT(1),	"pMAC rx octets" },
> +	{ NETC_PM_RVLAN(1),	"pMAC rx VLAN frames" },
> +	{ NETC_PM_RERR(1),	"pMAC rx frame errors" },
> +	{ NETC_PM_RUCA(1),	"pMAC rx unicast frames" },
> +	{ NETC_PM_RDRP(1),	"pMAC rx dropped packets" },
> +	{ NETC_PM_RPKT(1),	"pMAC rx packets" },
> +	{ NETC_PM_TOCT(1),	"pMAC tx octets" },
> +	{ NETC_PM_TVLAN(1),	"pMAC tx VLAN frames" },
> +	{ NETC_PM_TFCS(1),	"pMAC tx FCS errors" },
> +	{ NETC_PM_TUCA(1),	"pMAC tx unicast frames" },
> +	{ NETC_PM_TPKT(1),	"pMAC tx packets" },
> +	{ NETC_PM_TUND(1),	"pMAC tx undersized packets" },
> +	{ NETC_PM_TIOCT(1),	"pMAC tx invalid octets" },
> +};

Sashiko says:

Are these standard MAC and interface statistics being duplicated in the
driver-private ethtool strings?
The networking subsystem guidelines indicate that statistics which have
a standard uAPI must not be duplicated in ethtool -S. Standard
interfaces like struct rtnl_link_stats64 or struct ethtool_eth_mac_stats
already exist for counters such as rx octets, rx packets, dropped
packets, and FCS errors.
Could these metrics be exposed through the standardized interfaces
rather than adding them to the private string sets?

Other comments are AFAICS false positives.

/P


