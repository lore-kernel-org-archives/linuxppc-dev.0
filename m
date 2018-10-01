Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8718C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:32:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB0420645
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB0420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PH8S15KdzF3Cf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 08:32:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PH6F4yMFzF37p
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 08:30:13 +1000 (AEST)
Received: by mail-ot1-f65.google.com with SMTP id e21-v6so14825838otk.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 15:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EBMuyxcw3gTNEnsYJL9HAsaFTeTTjjUiMjGbPctuLCE=;
 b=JiRc7biFIsaYNN3BHQxtDYK+0j/wJiVlw893cp//IzFlMd8s9wCkSmC+AzyEMW+EmG
 mlF159qYikz9TQHqOmvPszfKO5Yx4lUokpoIINdsqZHP/F4UDO57p352LiNJ1CSQi4KK
 bhXKMqc6HpvkEhR2xvp+UceAsZ0+DiqW2YRo/9zwn4rVjq336/fjoAgGRiVraKI0P7Jt
 MDp86m8oNbCpXA7GuQ8KQJpk1cA9i+3wjnktL/uJREPEc44u6tHjWophFnrksK/Rx8CD
 CKsvIXR0SSXOmLQoUlli5ynFCVSM9VzqTHyGz4/q0V//JFHUloaT5vFTk6zWJ0FdPULZ
 UCow==
X-Gm-Message-State: ABuFfoh9UNTbW+z0IfwZkzT5bxLDFQIgCdTOMOaVaBKpEKXxUzxF54jT
 pu9wd3AodA7l5dKjWAAjhNPPcu/r1Fo=
X-Google-Smtp-Source: ACcGV61IjCElcJrrgjfzGZINHz3hrkskW5EULUTUEDdus8pShZZ2npKNQslzopdShToVMsR0ADgwyw==
X-Received: by 2002:a9d:841:: with SMTP id 59-v6mr7902563oty.335.1538433011313; 
 Mon, 01 Oct 2018 15:30:11 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com.
 [209.85.167.174])
 by smtp.gmail.com with ESMTPSA id s65-v6sm4657206oia.46.2018.10.01.15.30.10
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Oct 2018 15:30:11 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id s69-v6so12608910oie.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 15:30:10 -0700 (PDT)
X-Received: by 2002:aca:e310:: with SMTP id
 a16-v6mr1108411oih.79.1538433010858; 
 Mon, 01 Oct 2018 15:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 1 Oct 2018 17:29:59 -0500
X-Gmail-Original-Message-ID: <CADRPPNTn99q=6fungYr-xcwY6vFiw9KTUp8UCEQ2u0+sv7vd4Q@mail.gmail.com>
Message-ID: <CADRPPNTn99q=6fungYr-xcwY6vFiw9KTUp8UCEQ2u0+sv7vd4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
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
 claudiu.manoil@nxp.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 28, 2018 at 3:44 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>

Applied 1-4 to for-next while waiting for clarification on 5/5.   And
updated the prefix to "soc: fsl:" style to be aligned with arm-soc
convention.  Please try to use that style in the future for soc/fsl
patches.

> This patch set brings a number of fixes and the option to control
> the QMan portal interrupt coalescing.
>
> Changes from v1:
>  - change CPU 0 with any online CPU to allow CPU 0 to be taken offline
>  - move common code in a function
>  - address all places in the code where the portal interrupt was affined
>    to CPU 0
>  - remove unrelated change from patch adding 64 bit DMA addressing
>    requirement
>
> Madalin Bucur (2):
>   soc/fsl/qbman: replace CPU 0 with any online CPU in hotplug handlers
>   soc/fsl_qbman: export coalesce change API
>
> Roy Pledge (3):
>   soc/fsl/qbman: Check if CPU is offline when initializing portals
>   soc/fsl/qbman: Add 64 bit DMA addressing requirement to QBMan
>   soc/fsl/qbman: Use last response to determine valid bit
>
>  drivers/soc/fsl/qbman/Kconfig       |  2 +-
>  drivers/soc/fsl/qbman/bman.c        |  6 ++---
>  drivers/soc/fsl/qbman/bman_portal.c |  4 ++-
>  drivers/soc/fsl/qbman/dpaa_sys.h    | 20 ++++++++++++++
>  drivers/soc/fsl/qbman/qman.c        | 53 ++++++++++++++++++++++++++++++++-----
>  drivers/soc/fsl/qbman/qman_portal.c |  6 +++--
>  include/soc/fsl/qman.h              | 27 +++++++++++++++++++
>  7 files changed, 104 insertions(+), 14 deletions(-)
>
> --
> 2.1.0
>
