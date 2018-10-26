Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF33ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 20:38:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B149720856
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 20:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B149720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hbSC241mzF3JC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 07:38:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hbQ40160zF3J1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 07:36:59 +1100 (AEDT)
Received: by mail-ot1-f66.google.com with SMTP id k9so2266523otl.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 13:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o1J+Vua8+v3VyCFKW1e5R0do6+wn43nklh3RHSZ8CoI=;
 b=KhBEBB/qovHRGqF/87007Xg2A0TJrD1Ow4BrC30MM4fbcUCjMk/Y/PUgGgxnFbP5kZ
 wg/ktVP+ncHVzazpOEO2lXHjYF80HNX6aVwB9T28l4yoe4dyUWy5QhYyY7X0dHbgzcgh
 vpwNKRHgD8qBGJlf4B5mHu4mNeoJ0/ggZ7Hv3oGrg1fPAVeVtM3RKcZSrGKH+sD7o3qn
 xDVSyFq+8leJX1PBW79BBrCQQ5hfTzs/DlIGq79jaYExoDhw8NfLBxzbeiEu96Fyrkry
 lUsycNseZo/QoSwPz0jHrJspZOPoSmRYH/S2ax/PxEwpBAufJhPo6tm7abNZfcDvq/rO
 BJdg==
X-Gm-Message-State: AGRZ1gJcP7qE23f8/FK+1Og+3EzxDGfZL2dSiU++VgsBUtvk3wNk6Y2d
 YHDOt3/DZCKZARWMZngOQcRqWw/JgCU=
X-Google-Smtp-Source: AJdET5f5Vtjitq6pBxDT4KJzOyDKdgWNaJ9HLXWxjawRBzbta0OdPJXK/2ggBQlZ0vllMazMOKrJ3Q==
X-Received: by 2002:a9d:d61:: with SMTP id 88mr3203200oti.245.1540586217158;
 Fri, 26 Oct 2018 13:36:57 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com.
 [209.85.210.47])
 by smtp.gmail.com with ESMTPSA id b3-v6sm5777702oih.0.2018.10.26.13.36.57
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Oct 2018 13:36:57 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id c23so2268165otl.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 13:36:57 -0700 (PDT)
X-Received: by 2002:a9d:3cd0:: with SMTP id t16mr3143200otf.158.1540585724826; 
 Fri, 26 Oct 2018 13:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com>
 <20181025215246.GA14861@bogus>
 <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com>
 <HE1PR04MB14972C9176E68EEDBD3AD64BF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR04MB14972C9176E68EEDBD3AD64BF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 26 Oct 2018 15:28:33 -0500
X-Gmail-Original-Message-ID: <CADRPPNRP5RORVr0O59=O-PhRRerirFkPeOmAcKq3pNumf4Mriw@mail.gmail.com>
Message-ID: <CADRPPNRP5RORVr0O59=O-PhRRerirFkPeOmAcKq3pNumf4Mriw@mail.gmail.com>
Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support
To: xiaowei.bao@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 lorenzo.pieralisi@arm.com, Arnd Bergmann <arnd@arndb.de>,
 Roy Zang <roy.zang@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, niklas.cassel@axis.com,
 linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, kishon@ti.com,
 Minghuan Lian <minghuan.lian@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, cyrille.pitchen@free-electrons.com,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Shawn Guo <shawnguo@kernel.org>,
 shawn.lin@rock-chips.com, Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 26, 2018 at 2:43 AM Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
>
>
>
> -----Original Message-----
> From: arndbergmann@gmail.com <arndbergmann@gmail.com> On Behalf Of Arnd B=
ergmann
> Sent: 2018=E5=B9=B410=E6=9C=8826=E6=97=A5 15:01
> To: Xiaowei Bao <xiaowei.bao@nxp.com>
> Cc: Rob Herring <robh@kernel.org>; bhelgaas@google.com; mark.rutland@arm.=
com; shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; kishon@ti.com; loren=
zo.pieralisi@arm.com; gregkh@linuxfoundation.org; M.h. Lian <minghuan.lian@=
nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; kst=
ewart@linuxfoundation.org; cyrille.pitchen@free-electrons.com; pombredanne@=
nexb.com; shawn.lin@rock-chips.com; niklas.cassel@axis.com; linux-pci@vger.=
kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux=
-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support
>
> On 10/26/18, Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
> > From: Rob Herring <robh@kernel.org>
> >> On Thu, Oct 25, 2018 at 07:08:58PM +0800, Xiaowei Bao wrote:
> >>>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
> >>>          "fsl,ls2088a-pcie"
> >>>          "fsl,ls1088a-pcie"
> >>>          "fsl,ls1046a-pcie"
> >>>          "fsl,ls1012a-pcie
> >>> +  EP mode:
> >>> +        "fsl,ls-pcie-ep"
> >>
> > > You need SoC specific compatibles for the same reasons as the RC.
> >
> > [Xiaowei Bao] I want to contains all layerscape platform use one
> > compatible if the PCIe controller work in EP mode.
>
> Do you mean only one of the SoCs that support RC mode has EP mode?
> I think you still need a SoC specific compatible as Rob explained, in cas=
e there will be a second one in the future.
>
> If you want to ensure that you don't have to update the device driver for=
 each new chip that comes in when the EP mode is compatible, the way this i=
s handled is to list multiple values in the compatible property, listing th=
e first SoC that introduced the specific version of that IP block as the mo=
st generic type, e.g.
>
>   copatible =3D "fsl,ls2088a-pcie-ep", "fsl,ls1012a-pcie-ep", "snps,dw-pc=
ie-ep";
>
> For consistency, it probably is best to match each RC mode value with the=
 corresponding EP mode string for each device that can support both (if the=
re is more than one).
>
>       Arnd
> [Xiaowei Bao] My mean is that the ls-pcie-ep compatibles will contain all=
 layerscape SOCs of NXP, e.g: ls1046a-pcie-ep, fsl,ls2088a-pcie-ep, ls2088a=
-pcie-ep and so on, other layerscape SOCs have not test except the ls1046a,=
 I think it is compatible if the new chip or other SOCs use the DW core, OK=
, I will discuss this issue internally, and reply to you later.

You can define a generic compatible string for the EP mode of all
these platforms.  But like Rob and Arnd mentioned, it is good to also
define the SoC specific compatible strings just in case that we need
special treatment for certain SoCs in the future.

Regards,
Leo
