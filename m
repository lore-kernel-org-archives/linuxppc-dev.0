Return-Path: <SRS0=OkvJ=76=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A1C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 02:09:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239A22098B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 02:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239A22098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49mpRF3SXPzDr2J
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 12:09:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 49mpPK0WgJzDq9R
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2020 12:07:48 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 08FB82787E;
 Tue, 16 Jun 2020 22:07:38 -0400 (EDT)
Date: Wed, 17 Jun 2020 12:07:40 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] scsi: target/sbp: remove firewire SBP target driver
In-Reply-To: <8cbab988-fba7-8e27-7faf-9f7aa36ca235@acm.org>
Message-ID: <alpine.LNX.2.22.394.2006171104540.11@nippy.intranet>
References: <01020172acd3d10f-3964f076-a820-43fc-9494-3f3946e9b7b5-000000@eu-west-1.amazonses.com>
 <alpine.LNX.2.22.394.2006140934520.15@nippy.intranet>
 <7ad14946-5c25-fc49-1e48-72d37a607832@boo.tc>
 <alpine.LNX.2.22.394.2006150919110.8@nippy.intranet>
 <8da0c285-d707-a3d2-063e-472af5cc560f@boo.tc>
 <alpine.LNX.2.22.394.2006161929380.8@nippy.intranet>
 <8cbab988-fba7-8e27-7faf-9f7aa36ca235@acm.org>
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
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
 linux-kernel@vger.kernel.org, Nicholas Bellinger <nab@linux-iscsi.org>,
 target-devel@vger.kernel.org, Chris Boot <bootc@boo.tc>,
 linux1394-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 16 Jun 2020, Bart Van Assche wrote:

> 
> As far as I know the sbp driver only has had one user ever and that user 
> is no longer user the sbp driver.

So, you estimate the userbase at zero. Can you give a confidence level? 
Actual measurement is hard because when end users encounter breakage, they 
look for quick workarounds before they undertake post mortem, log 
collection, bug reporting, mailing list discussions, analysis etc.

> So why to keep it in the kernel tree?

Answer: for the same reason it was added to the tree.

Here's a different question: "Why remove it from the kernel tree?"

If maintaining this code is a burden, is it not the kind of tax that all 
developers/users pay to all developers/users? Does this driver impose an 
unreasonably high burden for some reason?

The growth of a maintenance burden in general has lead to the invention of 
design patterns and tooling to minize it. So a good argument for removal 
would describe the nature of the problem, because some driver deficiencies 
can be fixed automatically, and some tooling deficiencies can compound an 
otherwise insignificant or common driver deficiency.

There are spin-off benefits from legacy code besides process improvements. 
Building and testing this sort of code has regularly revealed erroneous 
corner cases in commits elsewhere like API changes and refactoring.

Also, legacy code is used by new developers get experience in code 
modernization. And it provides more training material for neural networks 
that need to be taught to recognize patches that raise quality.

Ten or twenty years ago, I doubt that anyone predicted these (and other) 
spin-off benefits. If we can't predict the benefit, how will we project 
the cost, and use that to justify deletion?

Please see also,
http://www.mac.linux-m68k.org/docs/obsolete.php
