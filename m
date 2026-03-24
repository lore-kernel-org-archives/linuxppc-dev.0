Return-Path: <linuxppc-dev+bounces-18712-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8600FF532ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 08:13:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg2qb04yfz2yvK;
	Tue, 24 Mar 2026 19:13:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774340026;
	cv=none; b=IO4DWOEQApFG43KoSvblFn0FpjinKi+5PVyDKKRiDKh4iY5BJ3e9XldhrWw30K0rV2q0+oKV2vtHZwz6ZG5VwDFhZNDpC/zvrrWOI67w+xLNIi/FPf9qPk73edkQe2jPh99AuWwIUos4Yn73EdHA5BpnZSoPK3Qxa97SEnyAAQJY2Bm3QB7F9j9QCorZlD3aPsifi8Mr/ueO5rhwy/LWK5Y1Wb7L0Z2TQJhydDMVHapPlMKoaec3pvac0Nflcjpoaa6xbnCB9NRAUUK68JTxhgpEkMP3pczPRyGQWc9Fo0MyXlvJ113cb2YQxvRnEm5OjM49sBHBsdURRj6sHRuf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774340026; c=relaxed/relaxed;
	bh=ts8QTgurhQrOhcbvZk0taNObr5EoxTyEYtshId05lwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeH5rP0A08godmNmrhEuzhad4AzSSTyGp7mBUpjhuPc/++mUKRG0jVq9fryWG1/9VKFrLI27/R/8oPtLjdOiwKkfXma+KXRGbsRPPRcXx+nwVEa0s/xYCA54+3ALGS67R4OJGslYoWnVEiSYWgstW1m1fbSK53HQ0rg6CO7oDKYfLX+VbxhVZfmCQhoKZM1llrELzZ5A8Gmm1H2b/gJnFQ5fILhmF+KBfCeXrIDUMGYt4ihta7bqC9F+w1j3S+/5th44wgHWmfw8Q0k2Y+zKSM3ToJUFpu+mCAwGxL6MGuvxRq9niS63OzBDmwy7ZBdVwAL4H5khmRPpCcEMSesbfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KRybWXvQ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KRybWXvQ; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KRybWXvQ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KRybWXvQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg2qY39qcz2yrX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 19:13:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774340020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts8QTgurhQrOhcbvZk0taNObr5EoxTyEYtshId05lwo=;
	b=KRybWXvQ80gGXgYv1c23dydsU7Z0wrtbN0JrcX49LukfczCW43bl9iQm0GCHsmKKGI7S2O
	9pubgsOj86lY6d6Y9xooLCJzZ7buJ3mYcaASpSfqLUALjgBLUXD4iJ/gBEJZteiMJSWLBg
	1z5lLWu6BPHf2qMZX+qOH2KRDGaPDhA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774340020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts8QTgurhQrOhcbvZk0taNObr5EoxTyEYtshId05lwo=;
	b=KRybWXvQ80gGXgYv1c23dydsU7Z0wrtbN0JrcX49LukfczCW43bl9iQm0GCHsmKKGI7S2O
	9pubgsOj86lY6d6Y9xooLCJzZ7buJ3mYcaASpSfqLUALjgBLUXD4iJ/gBEJZteiMJSWLBg
	1z5lLWu6BPHf2qMZX+qOH2KRDGaPDhA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-Vo-YqJa6OP6V5g2Sta8pVg-1; Tue, 24 Mar 2026 04:13:37 -0400
X-MC-Unique: Vo-YqJa6OP6V5g2Sta8pVg-1
X-Mimecast-MFC-AGG-ID: Vo-YqJa6OP6V5g2Sta8pVg_1774340016
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b53023d60so3369754f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 01:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774340016; x=1774944816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ts8QTgurhQrOhcbvZk0taNObr5EoxTyEYtshId05lwo=;
        b=HgfVnV042OW/4omJ8OCOof9vzjnv9lq4PVFMqR8aTAnlweL+3F1DYDpiWDbnhomJlc
         VvU5by1YWBJWZlCVIPe5Lea5y8tRFb0KIQHSdMeoyTwFib0Fgny375oSiw+XZOgyGPXl
         LLMrvNd0tFQ50Bqwk/pz0Da1LiFhSfFVNDryOFwE1RteYSFLBpcGyR/PrauBFJc5z0Ub
         uUSnZm91j1o0RRxXmMOEKB3pmdx7De1tnOa4CyFOzvnzwqRz9SfuBfongZiEt0soRT+f
         bhtflEp3VJH8K1T4yqQhP7Jh8mIllRv/pY9SBaR9SexnIljMle2ZQsSay0tClhHy4reY
         5N1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB6aPN2e1b9wTCIq+hqLnKW/+1vlRQpFfDKQbVfQhOF3yq9eenHdNK6grzrSthXxxuS167JTRivceuGfs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwuGtzVE5GUkal8yNbBGY1vOvQusVUTub/6M2aRy9MOI4C5AmvP
	2CPHrhH76o5WRueTUKfyqOtrAablDikFqV+v06KzNqghItmkebkoEmBe4KP9d75bbhve7ok9/wc
	IDnQhn5oJmf1VtEVN2ZN48gSC7GO75g2YpaIL0jYZakZTS3JCbujWIEXonM6v+TKwDEo=
X-Gm-Gg: ATEYQzxze+M7EFCntPt5emC5aLp9ZbcmHGb7EtO9R+mtCJWI77YY4IGDfVSHGn/Fhaf
	dhp0A96adZ/n/SbPgy47zWZdPfrDbLXqcHaFRM+QGfJUvHO0SViDV/9zGQXq57KBMxFPhfxD0DE
	cAq/dpaQn3NynASNzVHXM4aiCOYgcDY0C+/+SH5HzuYDFqb4a3/o8AngrxQuQvqsrBbAWQZCB18
	fgHiifdtiQ46XPgPd0qzJra7YEpFzEahZeeiJJKynYVg7Fkdqjc7MKZxnSeaeVa2SpTeb3Yl+rT
	Qh81x9BBzKV0oX5u5Y9k7dKSYWhx03p7SOk7jjHfN0s0tiLFZ4+GtZyOKuONc498V7m5xqCd/W7
	+4yukFcDeIYkplJW7nm/hA2taZY1Lf6LhkFdUef5KznmvfXJp9rtT/qvo
X-Received: by 2002:a05:6000:4382:b0:43b:3e40:222d with SMTP id ffacd0b85a97d-43b64244451mr22895147f8f.19.1774340015837;
        Tue, 24 Mar 2026 01:13:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4382:b0:43b:3e40:222d with SMTP id ffacd0b85a97d-43b64244451mr22895104f8f.19.1774340015382;
        Tue, 24 Mar 2026 01:13:35 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae048sm35875560f8f.1.2026.03.24.01.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 01:13:34 -0700 (PDT)
Message-ID: <c4e3c49e-ecc0-4702-9d2c-88ff420c4647@redhat.com>
Date: Tue, 24 Mar 2026 09:13:32 +0100
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
Subject: Re: [PATCH v2 net-next 11/14] net: dsa: netc: add phylink MAC
 operations
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, frank.li@nxp.com, chleroy@kernel.org,
 horms@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, Wei Fang <wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
 <20260323060752.1157031-12-wei.fang@nxp.com>
 <acEIQqI-_oyCym8O@shell.armlinux.org.uk>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <acEIQqI-_oyCym8O@shell.armlinux.org.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LiSZHoZbPIaqz_cSLGflghORFx_K9kyWgNv4OgwOomU_1774340016
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/26 10:30 AM, Russell King (Oracle) wrote:
> On Mon, Mar 23, 2026 at 02:07:49PM +0800, Wei Fang wrote:
>> +static void netc_port_set_mac_mode(struct netc_port *np,
>> +				   unsigned int mode,
>> +				   phy_interface_t phy_mode)
>> +{
>> +	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII | PM_IF_MODE_ENA;
>> +	u32 val = 0;
>> +
>> +	switch (phy_mode) {
>> +	case PHY_INTERFACE_MODE_RGMII:
>> +	case PHY_INTERFACE_MODE_RGMII_ID:
>> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>> +		val |= IFMODE_RGMII;
>> +		/* Enable auto-negotiation for the MAC if its
>> +		 * RGMII interface supports In-Band status.
>> +		 */
>> +		if (phylink_autoneg_inband(mode))
>> +			val |= PM_IF_MODE_ENA;
> 
> I would prefer newer drivers not to use phylink_autoneg_inband()
> anymore. Note that there is no need to support RGMII inband in the
> kernel (nor is there any proper support without a "phylink_pcs"
> being present to provide the inband status.)
Would you mind sharing a patch adding a comment nearby
phylink_autoneg_inband(), explaining the above for future memory?

Thanks,

Paolo


