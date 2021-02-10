Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C52C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 01:31:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EBB64E02
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 01:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EBB64E02
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Db2Kp3SrZzDvZ5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 12:31:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Db2Gf6zcHzDspZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 12:28:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=jmtx5CCE; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4Db2Gd4pBGz9sVJ; Wed, 10 Feb 2021 12:28:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1612920537; bh=BnOJb4ZECVpQ0/TDZLWFgS+PJkwVFMihslRyuD73OY4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jmtx5CCELjX9ivmdhCV6xHy1KOsfFoVuol8Std0nWY4Q+EbqOS3AWf/lPU7osn5Et
 5iyGTrVI7hRGzIlEc1YNdwn/K39dDy/BqkmS/Iss6zlWCK7eJUKTyg7CLmphq/ci+q
 JGJ/Pwy0cf3too90aD0A0TeiR6mWL5XhezPCPwnRcKtyI/AkYdv7h7r23J+AMJW7sa
 MEPTzpHZV9whA1txzax1Md0PgiBOkyWciTOkcN5+OspQvnpCa3isiejs+BFHpIb1GA
 /SpLZiEIx09QQ2RjvcC22IRBAmudiJw8K/A1rqk97yFv3ZAR+tEcshmiO8MXVjt6NR
 WTXyuDZnLhxmw==
Date: Wed, 10 Feb 2021 12:28:52 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/4] KVM: PPC: Book3S HV: Fix radix guest SLB side channel
Message-ID: <20210210012852.GD2854001@thinks.paulus.ozlabs.org>
References: <20210118062809.1430920-1-npiggin@gmail.com>
 <20210118062809.1430920-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118062809.1430920-3-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 18, 2021 at 04:28:07PM +1000, Nicholas Piggin wrote:
> The slbmte instruction is legal in radix mode, including radix guest
> mode. This means radix guests can load the SLB with arbitrary data.
> 
> KVM host does not clear the SLB when exiting a guest if it was a
> radix guest, which would allow a rogue radix guest to use the SLB as
> a side channel to communicate with other guests.

No, because the code currently clears the SLB when entering a radix
guest, which you remove in the next patch.  I'm OK with moving the SLB
clearing from guest entry to guest exit, I guess, but I don't see that
you are in fact fixing anything by doing so.

Paul.
