Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC516C64EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 20:09:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BEA2082A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 20:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BEA2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PqxR6w3kzDqkL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:09:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PqvQ3yhBzF39y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 06:07:46 +1000 (AEST)
Received: by mail-oi1-f193.google.com with SMTP id j68-v6so2603942oib.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 13:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qd8fzAmrC/jqxriN94pkjCNMaBeuTJeXX6kZurrzyCg=;
 b=uZ/uIul0BLTgvmFg1CNYbYhgTUBGnnUE0uTGiIDFR9cAzSZTY6Nd7/YYom2Gs0Swvp
 L301mQM9UtIlfcdZEonNiKkV0jUur7Lm6pcN5uX79U48Gk0fWI5vLxajj2oBkE8M+7lU
 kwyWamheXADcuT+CGC2NXF0N0oImSEVFGzIOCQHgCNYj4lPdMQ3V4Yf/0X4OEDWMIses
 xSMljBYG1XFqoocyXx8fWF+BZifW5o5Bm/01VoW1uuLe20vlVVFwOtZ4+/HqiG8GjY6E
 vMGSUJmCt7CKTJmvIE1EiZMpHsh34+fa2Z2uEsC3c/NvarCHqMU81m8Mk0+Kj80BcXva
 WL2w==
X-Gm-Message-State: ABuFfogFHul8Gp6lA9V5EDfbqZsKqnRkmbNBtmdnrXVeE/ZPTMeM8Kn9
 dS1rvTQo2BLDKAvgGlI2041tqWGGY1A=
X-Google-Smtp-Source: ACcGV62TUOw/mrf6Xj1VHP66RFYuOJzIikwF9A6NvixJuR6+S03DLs0TFihF77oEknAbNiaJW5k0xQ==
X-Received: by 2002:aca:4fcd:: with SMTP id
 d196-v6mr8668252oib.142.1538510863910; 
 Tue, 02 Oct 2018 13:07:43 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com.
 [209.85.210.42])
 by smtp.gmail.com with ESMTPSA id l60-v6sm5835251otl.52.2018.10.02.13.07.42
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 13:07:42 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id i12-v6so3240807otl.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 13:07:42 -0700 (PDT)
X-Received: by 2002:a9d:186:: with SMTP id e6mr967421ote.68.1538510861803;
 Tue, 02 Oct 2018 13:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
 <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
 <AM6PR04MB400877EC0C140A7D919AEF41ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB400877EC0C140A7D919AEF41ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 2 Oct 2018 15:07:30 -0500
X-Gmail-Original-Message-ID: <CADRPPNSNc50K8EcJUuQ-cnBs4NhHnNnhEDwdTSXgxm0j1FMCTw@mail.gmail.com>
Message-ID: <CADRPPNSNc50K8EcJUuQ-cnBs4NhHnNnhEDwdTSXgxm0j1FMCTw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
To: madalin.bucur@nxp.com
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Roy Pledge <roy.pledge@nxp.com>,
 lkml <linux-kernel@vger.kernel.org>, Scott Wood <oss@buserror.net>,
 claudiu.manoil@nxp.com, Netdev <netdev@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 2, 2018 at 1:08 AM Madalin-cristian Bucur
<madalin.bucur@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Li Yang [mailto:leoyang.li@nxp.com]
> > Sent: Tuesday, October 2, 2018 12:50 AM
> > To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> > Cc: Roy Pledge <roy.pledge@nxp.com>; Claudiu Manoil
> > <claudiu.manoil@nxp.com>; Catalin Marinas <catalin.marinas@arm.com>; Scott
> > Wood <oss@buserror.net>; moderated list:ARM/FREESCALE IMX / MXC ARM
> > ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linuxppc-dev
> > <linuxppc-dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
> >
> > On Fri, Sep 28, 2018 at 3:45 AM Madalin Bucur <madalin.bucur@nxp.com>
> > wrote:
> > >
> > > Export the API required to control the QMan portal interrupt coalescing
> > > settings.
> >
> > These are new APIs not just old APIs being exported.  What is the user
> > of these APIs?  Is the user being submitted?  We cannot have APIs in
> > kernel that has no users.
>
> Hi,
>
> These are new APIs that will be used in the DPAA Ethernet driver.
> Changes for the DPAA QBMan and DPAA Ethernet follow different paths upstream
> so the Ethernet driver patch that makes use of these APIs will be sent when
> these changes reach the net-next/master tree.

Applied for next after changing from "export API" to "add API" in the
introduction and updated the subsystem prefix.

Regards,
Leo
