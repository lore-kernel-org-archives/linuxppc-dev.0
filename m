Return-Path: <SRS0=6wQL=DW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D22BC433E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2020 09:11:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA9A2222E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2020 09:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=st.com header.i=@st.com header.b="0oTWPBOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA9A2222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBk6v5v2pzDqWS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2020 20:11:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=st.com
 (client-ip=185.132.182.106; helo=mx07-00178001.pphosted.com;
 envelope-from=amelie.delaunay@st.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=st.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=st.com header.i=@st.com header.a=rsa-sha256
 header.s=STMicroelectronics header.b=0oTWPBOx; 
 dkim-atps=neutral
X-Greylist: delayed 1853 seconds by postgrey-1.36 at bilbo;
 Thu, 15 Oct 2020 19:37:48 AEDT
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBjMw124BzDqSn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2020 19:37:47 +1100 (AEDT)
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09F810KF022265; Thu, 15 Oct 2020 10:05:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=glhTCKVcnbc8lpjOZBjcwL/WddjOBnrvQMsvFgpIX9U=;
 b=0oTWPBOxS3dHCpvop3Yn8LtnhruTiBArA0yscaywKM5jRBukrtlORwr/OlTPsO/MuqpZ
 NxiXz4Nvydwfc6H86n+++QoVfKWlkVK6RwSl08U860IelLWDFi6VfYxV1c49lArFXN0l
 AFDe3yXM7+VozPw8LXqj2LRtKWO4kRrD6cgMmP7U9tLEM1gC6uz4J1P7UBVkolbWZPMC
 0c23ip1jx4I4AYDVB506N+iPL276OKcmTrJwevYifEHpP48qXDA8TdK71per8cKZVT4H
 PfdxOAWlYV0XFPa9ElhEi0cBzBscOmgtycug9z9NV8KOyMMJP+rSe/YeUgH1QAaLqKx4 LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 34356ekf4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2020 10:05:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0884E100034;
 Thu, 15 Oct 2020 10:05:47 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D2CD20602D;
 Thu, 15 Oct 2020 10:05:47 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 15 Oct
 2020 10:05:44 +0200
Subject: Re: [PATCH 18/20] arch: dts: Fix EHCI/OHCI DT nodes name
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Mathias Nyman
 <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>,
 Vineet Gupta <vgupta@synopsys.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 <bcm-kernel-feedback-list@broadcom.com>, Wei Xu
 <xuwei5@hisilicon.com>, Vladimir Zapolskiy <vz@mleia.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>,
 Paul Cercueil <paul@crapouillou.net>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
References: <20201014101402.18271-1-Sergey.Semin@baikalelectronics.ru>
 <20201014101402.18271-19-Sergey.Semin@baikalelectronics.ru>
From: Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <a68552c5-3284-7196-3873-61711aaf5007@st.com>
Date: Thu, 15 Oct 2020 10:05:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014101402.18271-19-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-15_03:2020-10-14,
 2020-10-15 signatures=0
X-Mailman-Approved-At: Thu, 15 Oct 2020 20:09:47 +1100
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
Cc: devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-mips@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Manu Gautam <mgautam@codeaurora.org>, Andy Gross <agross@kernel.org>,
 linux-mediatek@lists.infradead.org,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 linuxppc-dev@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Serge,

On 10/14/20 12:14 PM, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?"  . Let's fix the DTS files, which have the nodes defined with
> incompatible names.
> 
> Signed-off-by: Serge Semin<Sergey.Semin@baikalelectronics.ru>
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index bfe29023fbd5..576f7da564c5 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1404,7 +1404,7 @@ ethernet0: ethernet@5800a000 {
>   			status = "disabled";
>   		};
>   
> -		usbh_ohci: usbh-ohci@5800c000 {
> +		usbh_ohci: usb@5800c000 {
>   			compatible = "generic-ohci";
>   			reg = <0x5800c000 0x1000>;
>   			clocks = <&rcc USBH>;
> @@ -1413,7 +1413,7 @@ usbh_ohci: usbh-ohci@5800c000 {
>   			status = "disabled";
>   		};
>   
> -		usbh_ehci: usbh-ehci@5800d000 {
> +		usbh_ehci: usb@5800d000 {
>   			compatible = "generic-ehci";
>   			reg = <0x5800d000 0x1000>;
>   			clocks = <&rcc USBH>;

For STM32MP151:

Acked-by: Amelie Delaunay <amelie.delaunay@st.com>

Thanks,
Amelie
