Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A781C6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 07:03:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7026F20824
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 07:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew9UJZX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7026F20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hFMj2MTDzF3G7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 18:03:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ew9UJZX+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ew9UJZX+"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hFK31V2wzF38H
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 18:01:23 +1100 (AEDT)
Received: by mail-qk1-x741.google.com with SMTP id p3-v6so69033qkb.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:sender:in-reply-to:references:from:date:message-id
 :subject:to:cc;
 bh=ygtCwwNpN9rX8xntHSLNe3Y94i+g9J6A4JU6Fak5aok=;
 b=Ew9UJZX+o7hzahXLJ/Qxd829ksNmWDMrBzMXCfWaW1qOgxP2HDNsJMH9ok+FMthYBz
 AtQtOscM4B4nymGyfUVa/uhTM7C488pdrptULDJuqLh1LUXrk2zsq/7Xn1SzrNbWF5eO
 xbL5GAmV/kJOWghSVRMWwLld3E7pcjIoQ8WCXxsTYNYGFzpwZIkxJJybjAn0vvtT3kav
 BwmX3h+Pi89O5q2jTEY/bA04IC5+n8hyhn9YgCm3jurn9O908EGhfTRcpaUeK0EqwhZZ
 cKk2GPPHmddvDtE8eFotr59fZqXdSw7OuuPWFeuMKqD9jkDr0TzBtL+B3uazWvwdcyJg
 L0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
 :date:message-id:subject:to:cc;
 bh=ygtCwwNpN9rX8xntHSLNe3Y94i+g9J6A4JU6Fak5aok=;
 b=RqS6t8ooJVdr7HZebKN8qdUPb3kr6kyXj2e2tk/AnOJTwtdzImvasa72ddjJTzMsy6
 EkQJ4ei7jxNLjlYP0Ij9H+V/JWbh+WT1bPK9SWUnD95rwbMOLob/7U8Tcw4KV4PvvYoQ
 zvaYku/quzZXpfA2vHo2+AlW76i42K9fpwRe2sYmRIVjNsvMaZ8VB0OA2z6KXt1LqTkX
 wfFyZu6r2MnioYlbPSHPSj9tpa5k/pczqcDbmDuGf/C7p5IkcNVo2k17YNvEzRstlbty
 2v7gm2jTyJoa/mWVmGMCfHbdF2SVk1Y1J8fhhGgwWrHVtVOXOZQvGd1UUZ80bvOSY6fL
 59ZQ==
X-Gm-Message-State: AGRZ1gLhzkFtHqmyS35ZZSzSU0MGS6eZ826qJNtIMHp8BNMGmmVHOXzm
 +akjOsmyMEeo6tLDPTM1VHPxO4O8BQMiVTxY1PE=
X-Google-Smtp-Source: AJdET5cJM9iepXUIUSudaP/W2MSSmSgmT2lmwUjeVpNFoerI4E3MkgdT3IUA4SXKfAW6xwoXCf13ce7ckh/ast9vFK8=
X-Received: by 2002:a37:4116:: with SMTP id
 o22-v6mr1907286qka.107.1540537279997; 
 Fri, 26 Oct 2018 00:01:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 00:01:19
 -0700 (PDT)
In-Reply-To: <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com>
 <20181025215246.GA14861@bogus>
 <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 Oct 2018 09:01:19 +0200
X-Google-Sender-Auth: 13NSssZsIICiZBH18QZjyKXH8-I
Message-ID: <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Rob Herring <robh@kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Roy Zang <roy.zang@nxp.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kishon@ti.com" <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 Mingkai Hu <mingkai.hu@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/26/18, Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
> From: Rob Herring <robh@kernel.org>
>> On Thu, Oct 25, 2018 at 07:08:58PM +0800, Xiaowei Bao wrote:
>>>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
>>>          "fsl,ls2088a-pcie"
>>>          "fsl,ls1088a-pcie"
>>>          "fsl,ls1046a-pcie"
>>>          "fsl,ls1012a-pcie"
>>> +  EP mode:
>>> +        "fsl,ls-pcie-ep"
>>
> > You need SoC specific compatibles for the same reasons as the RC.
>
> [Xiaowei Bao] I want to contains all layerscape platform use one compatible
> if the PCIe controller work in EP mode.

Do you mean only one of the SoCs that support RC mode has EP mode?
I think you still need a SoC specific compatible as Rob explained, in case
there will be a second one in the future.

If you want to ensure that you don't have to update the device driver
for each new chip that comes in when the EP mode is compatible,
the way this is handled is to list multiple values in the compatible
property, listing the first SoC that introduced the specific version of
that IP block as the most generic type, e.g.

  copatible = "fsl,ls2088a-pcie-ep", "fsl,ls1012a-pcie-ep", "snps,dw-pcie-ep";

For consistency, it probably is best to match each RC mode value with
the corresponding EP mode string for each device that can support both
(if there is more than one).

      Arnd
