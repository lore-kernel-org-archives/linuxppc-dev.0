Return-Path: <SRS0=NP7W=3L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BA5C32771
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jan 2020 07:34:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37D12253D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jan 2020 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDzeQxeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37D12253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 482cbs5q7XzDqQH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jan 2020 18:34:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::341;
 helo=mail-wm1-x341.google.com; envelope-from=hkallweit1@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VDzeQxeE; dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 482cZ05xJjzDqPS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2020 18:32:38 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id a5so5713520wmb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2020 23:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fm/bzorqFXGRjSleITF9pD+r1ENd6CB0azL8igPUALM=;
 b=VDzeQxeEhDd8ZKku1Vsa6Rm+0dEX0MsSrnfFkdfeGLwJy/mHgwEerx7eS8/YGXEbxr
 fyEL+uolSK2w7xtim5NpnRib0fMpIpzzD4fTzsPKUkHpTmHE2AJMShtmpCJAYDJkeJfi
 V9M2aHfVdu8ai4eNZ8fDRxLyX+uaMPI3rK/B5Dv5n6RV0aIWB2x6tFbIRGtF93S+yJD7
 P4Km/plRniTRmu24NArSI3NaiO9WS4KR483rANpvgUlGIQ/eFZh9G5TaKcRj/x4m86MZ
 yWIy330NA0EvuDPtSQ2KQbJIFWWKPn32Q6b3HiCm6rvGSriyBRD4L3WquLLdMYnW+ei2
 hV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fm/bzorqFXGRjSleITF9pD+r1ENd6CB0azL8igPUALM=;
 b=MLYigwNfn9EG/9jlHCVvrYCQM5L5g7PRtfLAlZ9cktibELPKhnFzmv7pU+ecIyFdPa
 MYNskHBjUQe+nLGZWY+/qi8y0xk7YmGZMQvbLK5gIQeT1MG+xPCylI0Gx47jw1lnRerM
 OdZ/B8/L1nqmltI6jprnZkGS/+kug0ge3jOs5E2CsKRe3XZ3on5aOeKmYThaCejeX4mi
 WTzsuclLOpLTGBm3wOJhS7XmHjEKG+uL4OXy9QcrQqtvLk0W2qWzlufgqKmsfZLedPUk
 l0K2kd4/QHxoLrZLWUAsFrgJ8En3pICFpCp6WFQksiYNwreO+zLMiBrIMgWmQmeS6mVi
 Pj9g==
X-Gm-Message-State: APjAAAUpo5/MIkoOfsReF3BzCFtv/FfVaylWe1nnRM2zI2PwHyIWY3KI
 4qxtwHjr2r+yLPhfgNu4f54=
X-Google-Smtp-Source: APXvYqxsj7I9WlzOG+WOoPFUiCwN4qWOvJotIYRZmaWyfy5/ihC4mSOyzoLZoK6R3hu9TVPC7u6gzA==
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr1458811wmg.13.1579678354144; 
 Tue, 21 Jan 2020 23:32:34 -0800 (PST)
Received: from ?IPv6:2003:ea:8f36:6800:9425:8dfb:676f:4467?
 (p200300EA8F36680094258DFB676F4467.dip0.t-ipconnect.de.
 [2003:ea:8f36:6800:9425:8dfb:676f:4467])
 by smtp.googlemail.com with ESMTPSA id a132sm2495983wme.3.2020.01.21.23.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 23:32:33 -0800 (PST)
Subject: Re: [PATCH v2 net-next] net: convert suitable drivers to use
 phy_do_ioctl_running
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 David Miller <davem@davemloft.net>, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Doug Berger <opendmb@gmail.com>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, Timur Tabi <timur@kernel.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Steve Glendinning <steve.glendinning@shawell.net>,
 Michal Simek <michal.simek@xilinx.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
References: <2db5d899-a550-456d-a725-f7cf009f53a3@gmail.com>
 <9d2dbcc0-7e22-601a-35f6-135f2a9e6f99@gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <ec2a401d-e504-da38-8bc7-1826f5de7941@gmail.com>
Date: Wed, 22 Jan 2020 08:28:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9d2dbcc0-7e22-601a-35f6-135f2a9e6f99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux USB Mailing List <linux-usb@vger.kernel.org>,
 linux-renesas-soc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 22.01.2020 05:04, Florian Fainelli wrote:
> 
> 
> On 1/21/2020 1:09 PM, Heiner Kallweit wrote:
>> Convert suitable drivers to use new helper phy_do_ioctl_running.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> The vast majority of drivers that you are converting use the following
> convention:
> 
> - !netif_running -> return -EINVAL
> - !dev->phydev -> return -ENODEV
> 
> so it may make sense to change the helper to accommodate the majority
> here, not that I believe this is going to make much practical
> difference, but if there were test cases that were specifically looking
> for such an error code, they could be failing after this changeset.
> 
Right, I also stumbled across the different error codes, mainly as you
say -EINVAL. However there is no "wrong value", if netdev isn't running,
then typically the PHY is not attached, and from a netdev point of view
it's not there. So ENODEV seems to be best suited.
In kernel code the changed return code doesn't make a difference,
but yes, in theory there could be userspace programs checking for
-EINVAL. However such userspace programs should check for ENODEV too
anyway to cover the second check that already returns -ENODEV.

> For bgmac.c, bcmgenet.c and cpmac.c:
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Whether you decide to spin another version or not.
> 
Heiner
