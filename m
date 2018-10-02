Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FEAC64EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 19:47:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EA420684
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 19:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EA420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PqSF4ZYpzF3Fc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:47:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PqQ4014XzF1QT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 05:45:47 +1000 (AEST)
Received: by mail-ot1-f67.google.com with SMTP id e18-v6so3147124oti.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 12:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GL99KgLcEp3HA0hAdM86rhDV2Dm+/tGpMMSlb2PNrVc=;
 b=KriEd+gVrCxzCRsZ1Es0tjVhnzI/87umxvytxGMGFZxd51qdV8+ljIrT2izslT0NXn
 cdkT0gbUHxFs+bkizqQbJSM9Y/g0218Xb+sSmIco5IT164mYFP1zd3pQmVKQPcAWI6v3
 RwjwEaMQojlWkcRAT/ghbnQ36QT55tHfjqhHykjc/OrlRBH+juHuN/j09WXDq29rFmKD
 KUaKLUt0Xhu0wth2Py7mTp2d3QhJBXwRhlnMW23/zNba7OtM9ANUkk44zcK3+S3wVPmR
 AwUKnIflLlHiHYXhLeo5uhEFZTUsaRJL7c9jO7aZDZAKPLI6TlW802UmV+lBSbqiVohD
 TWXQ==
X-Gm-Message-State: ABuFfogfgsteWvoITZOA6tUrUkeD2viBKn+kB/T9eb4h+PRCJZmC2Fyf
 IF0cfbyRNFB8cUl2enXdFf287NB04iE=
X-Google-Smtp-Source: ACcGV60nhmsaOz2fEwW7b5/3DtiWfC1eikZGaGkdVmQXhq5TfaEyGfta6CANyjO329V300f7oqtY0A==
X-Received: by 2002:a9d:634d:: with SMTP id
 y13-v6mr9580207otk.86.1538509544961; 
 Tue, 02 Oct 2018 12:45:44 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com.
 [209.85.210.41])
 by smtp.gmail.com with ESMTPSA id k36-v6sm7170031otd.76.2018.10.02.12.45.44
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 12:45:44 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id u22so3108913ota.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 12:45:44 -0700 (PDT)
X-Received: by 2002:a9d:20e1:: with SMTP id
 x88-v6mr10250691ota.338.1538509544105; 
 Tue, 02 Oct 2018 12:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <CADRPPNTn99q=6fungYr-xcwY6vFiw9KTUp8UCEQ2u0+sv7vd4Q@mail.gmail.com>
 <AM6PR04MB40080234BA68140933F6B733ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB40080234BA68140933F6B733ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 2 Oct 2018 14:45:32 -0500
X-Gmail-Original-Message-ID: <CADRPPNQmCXwxP7xJh_md37TofRivU6w2EyX1rTTtZX4LGjj+ng@mail.gmail.com>
Message-ID: <CADRPPNQmCXwxP7xJh_md37TofRivU6w2EyX1rTTtZX4LGjj+ng@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
To: madalin.bucur@nxp.com, Olof Johansson <olof@lixom.net>,
 Arnd Bergmann <arnd@arndb.de>
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
 claudiu.manoil@nxp.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 2, 2018 at 1:29 AM Madalin-cristian Bucur
<madalin.bucur@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Li Yang [mailto:leoyang.li@nxp.com]
> > Sent: Tuesday, October 2, 2018 1:30 AM
> > To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> > Cc: Roy Pledge <roy.pledge@nxp.com>; Claudiu Manoil
> > <claudiu.manoil@nxp.com>; Catalin Marinas <catalin.marinas@arm.com>; Scott
> > Wood <oss@buserror.net>; moderated list:ARM/FREESCALE IMX / MXC ARM
> > ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linuxppc-dev
> > <linuxppc-dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
> >
> > On Fri, Sep 28, 2018 at 3:44 AM Madalin Bucur <madalin.bucur@nxp.com>
> > wrote:
> > >
> >
> > Applied 1-4 to for-next while waiting for clarification on 5/5.   And
> > updated the prefix to "soc: fsl:" style to be aligned with arm-soc
> > convention.  Please try to use that style in the future for soc/fsl
> > patches.
>
> Thank you, I've sent an email about the APIs.
> I'm not sure we need to align the prefix to arm-soc as the soc/fsl does not
> service only ARM but also PPC based SoCs and historically we've been using
> the soc/* format.

There is no kernel wide guideline about the format of subsystem prefix
in the patch subject. Different subsystems have their own
preferrences.  Soc is not considered as a separate subsystem, so we
followed the convention of the architectural subsystem that we merge
patches through.  Since we normally get soc patches through the
arm-soc tree right now, I think it would be better to follow the
convention of arm-soc to make them not looking too different in the
arm-soc pull requests.  Not sure how sensetive ARM-SOC maintainers
feel about this though.

Regards,
Leo
