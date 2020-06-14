Return-Path: <SRS0=g/Eh=73=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FB6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2020 00:05:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3322078A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2020 00:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3322078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49kvqR3mF7zDqsM
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2020 10:05:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 49kvnh0XGgzDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2020 10:03:51 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 4C7A927E75;
 Sat, 13 Jun 2020 20:03:43 -0400 (EDT)
Date: Sun, 14 Jun 2020 10:03:31 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Chris Boot <bootc@bootc.net>
Subject: Re: [PATCH] scsi: target/sbp: remove firewire SBP target driver
In-Reply-To: <01020172acd3d10f-3964f076-a820-43fc-9494-3f3946e9b7b5-000000@eu-west-1.amazonses.com>
Message-ID: <alpine.LNX.2.22.394.2006140934520.15@nippy.intranet>
References: <01020172acd3d10f-3964f076-a820-43fc-9494-3f3946e9b7b5-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
 Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org,
 Nicholas Bellinger <nab@linux-iscsi.org>, target-devel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux1394-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 13 Jun 2020, Chris Boot wrote:

> I no longer have the time to maintain this subsystem nor the hardware to
> test patches with. 

Then why not patch MAINTAINERS, and orphan it, as per usual practice?

$ git log --oneline MAINTAINERS | grep -i orphan

> It also doesn't appear to have any active users so I doubt anyone will 
> miss it.
> 

It's not unusual that any Linux driver written more than 5 years ago 
"doesn't appear to have any active users".

If a driver has been orphaned and broken in the past, and no-one stepped 
up to fix it within a reasonable period, removal would make sense. But 
that's not the case here.

I haven't used this driver for a long time, but I still own PowerMacs with 
firewire, and I know I'm not the only one.

> Signed-off-by: Chris Boot <bootc@bootc.net>
> ---
>  MAINTAINERS                     |    9 -
>  drivers/target/Kconfig          |    1 -
>  drivers/target/Makefile         |    1 -
>  drivers/target/sbp/Kconfig      |   12 -
>  drivers/target/sbp/Makefile     |    2 -
>  drivers/target/sbp/sbp_target.c | 2350 -------------------------------
>  drivers/target/sbp/sbp_target.h |  243 ----
>  7 files changed, 2618 deletions(-)
>  delete mode 100644 drivers/target/sbp/Kconfig
>  delete mode 100644 drivers/target/sbp/Makefile
>  delete mode 100644 drivers/target/sbp/sbp_target.c
>  delete mode 100644 drivers/target/sbp/sbp_target.h
> 
