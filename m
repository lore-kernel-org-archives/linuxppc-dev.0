Return-Path: <linuxppc-dev+bounces-24405-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CE5C4451B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jul 2026 16:32:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2XPX484vz2xd2;
	Sun, 19 Jul 2026 02:32:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.166 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784392352;
	cv=pass; b=BXVKec1ZsrAn0PH2daaOpYl4mBEVEkpjVCsvwOwevLLxtr2YSh3qPlDwcje41GVzqTceyVTYIz7UwzFwPQQAuSnVlw+RN9yKfzhKiAD56Wh1Wj88g5n09caMD49y+lexHN0Lwa4DO+EgcXz5HcAAzockBsX2Ow+swn9LNf4/odCeRgS5zrn0bfebuIJ08tl7/XUxDmzcmdDNSh9wwcbQ9HtotDaLN15vWn5u+OvtnW7X/tNmLqaJVHyuK37XHCbho9wYwPiznBI+Qua9bjw980qvp9BQNfhs2g4rG4GHUdEvs5RTVK/tvJ2BrQyNEilC3UPOZnfu0Vpsnj4rTiMzew==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784392352; c=relaxed/relaxed;
	bh=XJsv2P9n0pK03mBXRMW07qFn9aQZWfbQWQlxHw2cwG8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Zk8nQC762f4f5tqPp+fiCC1vcUtOn6RBYtHYo4BaFfE00ej7UpQGtDByHqDI8g158pq5g47Qo/2iZQEZKl1O46Vz5WY6fNuV4cCL7bog69jSKqjvFjNnsxSRzpA3Z7Pl6WH2u2m6oiw06z3imRpDBQBGbAFtw/yHpNtLXjMzJiuLudygZMBPMpWcJN0BWkuiNU4BuTv9JKV7S9n2rqMbVlWsZjpbhzXV+kwRDI7USQpGw0wsuSoht4hVm/+/dSRIUoEMn4HgfLZ3QmuLOVHTXppJT33ckZgFDsdGMPHypWsEK3vzXP4EmArdVAzAEP40wF+zf5Sbe+OolQbW7FlKYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=b7Za5CoO; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0CZl5LDW; dkim-atps=neutral; spf=pass (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=b7Za5CoO;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0CZl5LDW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2XPR4rqmz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 02:32:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1784392303; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GtPXH4RLt1dtgoAiml5oZGk2m8cWUmpKsmfaGjNmOknLcetPSt8OqbNrmqbkit+nKk
    7jZv5F+IDuWzjUT/zS8n/uBgPKS6UIbjHOeP2b9JkKsvCDEVhwEnn5ZHPOFJOE98OUgH
    /iKJ/W6NgUxK3ycHrb9pI4z9m71TDCFgrQTCvYdeJrm2uOtkl9zc4hbHnwVzuPHy/KEl
    S8evPjovmrqjD0p8q0IURQozCQN253cwwQVDmBeqULQMum6jtqP9SDzq1fRoz5dmT5Lf
    2iQdAPw9x7dqTfTgC0Qah+z2nRiqWiz1CB2cffy+aa/FkHDm51NxWPtAWvay2+VfaLwr
    Cd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784392303;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XJsv2P9n0pK03mBXRMW07qFn9aQZWfbQWQlxHw2cwG8=;
    b=Qcwl2lqqsRNkdVO6dMdo5Vgv+hW5aflnfRcr4wDDLXt8ffKEwrp2pAc+TSWNWCSh5s
    ouBp14ziQsKa8eoQp0CyKGFxgebj9zH5CM1v3beJwuFGSAoAYqNwN6suqpVPuSB+cqm9
    j+PrHpL4V586XgvWxh8I24yjhAhkfQzr+nG51O0E9fwcB8EIe7RYdqDGfAKummV5Qgvt
    LUcdt2JKRimUhRgZ0kbwfnftt8xeBe/mPspUPsO3DIr7cznp70EhvQuHpCr62v2MXm5h
    jIk0cDJoH7ZIQXGbDOA46SI1pkFCVdBU7w2P1ot7xeMyMIpcKvHPtrAIm66WF/RQeu6S
    LVMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784392303;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XJsv2P9n0pK03mBXRMW07qFn9aQZWfbQWQlxHw2cwG8=;
    b=b7Za5CoOD9aQ/AICxbCFD7nNKsYuYchU5Lofml3IEk5lP6oMd/FpZLcc7jrVjGA2pR
    dMOBR9+RgE4UrYG+X7YUSALWDIHGAsdSVU8n5Q8m9sTZIDUSmiJrjStXtWF3nGiH9xjn
    T7UcYe0tO7vLwgm0MfwSlCv5QNv1uoTEwtT2POFniexfVjj93MWP9HgtyMXPE5FAiUsG
    c5BTGGvtxlVFp5U4J2gQQ96HiGzn+nAbySwsGZbs0XYEfQLj679DYB8NQW/Q31mAVQb5
    xtjS7WCm3+hoofn5AD/jt7cUt4g4H5Y+l57+uYu9PwIifQatAiqGWxX7C5olu51VF1ll
    Hv5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784392303;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XJsv2P9n0pK03mBXRMW07qFn9aQZWfbQWQlxHw2cwG8=;
    b=0CZl5LDWmvJ3tvthO2sJA5bsYkTMTxWtAmiPwJB2CUbNyd7k6Lav50aJhRbNW0mfaa
    Cn7IOGzcGwRGt1iL+fCQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+m7hLg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id eed0ee26IGVf2BR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 18 Jul 2026 18:31:41 +0200 (CEST)
Subject: Re: [PATCH net v3] net: dpaa: fix mode setting
To: Sean Anderson <sean.anderson@linux.dev>, Michael Walle
 <mwalle@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christian Zigotzky <info@xenosoft.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 mad skateman <madskateman@gmail.com>, Damien Stewart <hypexed@yahoo.com.au>
References: <20260717132401.2653252-1-mwalle@kernel.org>
 <4f7497cf-83ed-47cd-2e7b-d06ebe319b61@linux.dev>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <095e561e-1e36-9ea1-b0c6-958c825851cb@xenosoft.de>
Date: Sat, 18 Jul 2026 18:31:40 +0200
X-Mailer: BrassMonkey/34.2.2
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
In-Reply-To: <4f7497cf-83ed-47cd-2e7b-d06ebe319b61@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/07/26 23:10, Sean Anderson wrote:
> On 7/17/26 09:20, Michael Walle wrote:
>> Before converting to the phylink interface, the init function would have
>> set a non-reserved I/F mode in the maccfg2 register. After converting to
>> phylink, 0 is written as mode, which is a reserved value (although it's
>> the hardware default). Without a valid mode, a SGMII link is never
>> established between the MAC and the PHY and thus .link_up() is never
>> called which could set the correct mode according to the actual speed.
>>
>> Fix it by setting the maximum speed of the phy_interface_t in use in
>> .mac_config() - just like the driver did before the phylink conversion.
>>
>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>> I didn't grab Sean's Rb tag as this is somewhat different.
>>
>> Changes in v3:
>>   - keep the mode setting also in .adjust_link().
>>   - reword the commit message, to be (hopefully) more precise
>>   - Link to v2: 
>> https://lore.kernel.org/r/20260710143430.2276141-1-mwalle@kernel.org/
>>
>> Changes in v2:
>>   - the setting is/was based on the maximum speed, not the current
>>     speed. thus, move the setting into mac_config().
>>   - Link to v1: 
>> https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/
>>
>>   .../net/ethernet/freescale/fman/fman_dtsec.c    | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c 
>> b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> index fe35703c509e..b8d70c0ecb6c 100644
>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct 
>> phylink_config *config, unsigned int mode,
>>   {
>>       struct mac_device *mac_dev = fman_config_to_mac(config);
>>       struct dtsec_regs __iomem *regs = mac_dev->fman_mac->regs;
>> -    u32 tmp;
>> +    u32 ecntrl, maccfg2;
>> +
>> +    maccfg2 = ioread32be(&regs->maccfg2);
>> +    maccfg2 &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>>         switch (state->interface) {
>>       case PHY_INTERFACE_MODE_RMII:
>> -        tmp = DTSEC_ECNTRL_RMM;
>> +        ecntrl = DTSEC_ECNTRL_RMM;
>> +        maccfg2 |= MACCFG2_NIBBLE_MODE;
>>           break;
>>       case PHY_INTERFACE_MODE_RGMII:
>>       case PHY_INTERFACE_MODE_RGMII_ID:
>>       case PHY_INTERFACE_MODE_RGMII_RXID:
>>       case PHY_INTERFACE_MODE_RGMII_TXID:
>> -        tmp = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>> +        ecntrl = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>> +        maccfg2 |= MACCFG2_BYTE_MODE;
>>           break;
>>       case PHY_INTERFACE_MODE_SGMII:
>>       case PHY_INTERFACE_MODE_1000BASEX:
>>       case PHY_INTERFACE_MODE_2500BASEX:
>> -        tmp = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>> +        ecntrl = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>> +        maccfg2 |= MACCFG2_BYTE_MODE;
>>           break;
>>       default:
>>           dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
>> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct 
>> phylink_config *config, unsigned int mode,
>>           return;
>>       }
>>   -    iowrite32be(tmp, &regs->ecntrl);
>> +    iowrite32be(ecntrl, &regs->ecntrl);
>> +    iowrite32be(maccfg2, &regs->maccfg2);
>>   }
>>     static void dtsec_link_up(struct phylink_config *config, struct 
>> phy_device *phy,
>
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
>
> Christian, can you test this patch with ethernet at 100/1G speed if 
> you still have
> access to those P5020/P5040 boards?
>
> https://lore.kernel.org/all/0bfc8f3d-cb62-25f4-2590-ff424adbe48a@xenosoft.de/ 
>
I tested the patch today. I don't see any differences.

Further information: 
https://github.com/chzigotzky/kernels/releases/tag/v7.2.0-rc3-fman-dtsec-patch

Christian

-- 
Sent with BrassMonkey 34.2.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.2.2)


