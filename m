Return-Path: <SRS0=Sivu=TH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF96C004C9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 16:02:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0478205ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 16:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0478205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44z4Bk6jFwzDqN0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 May 2019 02:02:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44z48l0z0SzDqDl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2019 02:01:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44z48k5G9Nz8sjs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2019 02:01:10 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44z48k4yFFz9sBp; Wed,  8 May 2019 02:01:10 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44z48k0llrz9sBV
 for <linuxppc-dev@ozlabs.org>; Wed,  8 May 2019 02:01:08 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x47G0uU5027947;
 Tue, 7 May 2019 11:00:56 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x47G0t7a027944;
 Tue, 7 May 2019 11:00:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 7 May 2019 11:00:55 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 09/16] powernv/fadump: process architected register
 state data provided by firmware
Message-ID: <20190507160055.GG8599@gate.crashing.org>
References: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
 <155541089317.812.14447001298006010972.stgit@hbathini.in.ibm.com>
 <20190507141356.saug5kjhntwozu76@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507141356.saug5kjhntwozu76@in.ibm.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>,
 Stewart Smith <stewart@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 07, 2019 at 07:43:56PM +0530, Mahesh J Salgaonkar wrote:
> Can we use SPRN_* #defines which are already present in asm/reg.h instead of
> hard coding numbers for switch cases ? You may want to add new #defines
> for NIP, MSR and CCR.

But none of those three are SPRs.  Please don't pollute that namespace.
Put such defines into some fadump header, instead?


Segher
