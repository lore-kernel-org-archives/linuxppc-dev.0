Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8CFC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 01:08:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA2E214C6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 01:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="qU22kILk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA2E214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Jfz26rHfzDqVV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 12:08:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="qU22kILk";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Jfs20lvlzDqfN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 12:03:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="qU22kILk"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43Jfs147N3z9s7W; Tue, 18 Dec 2018 12:03:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1545094981; bh=XhohdHKKbKkb/2eKVljolsNzOjbM67+ahwmW5UFd0LY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qU22kILkLDoh10MHgAygbsBwUiO0Bpdkn6Gole4szSdHSxPYoT3XdANwS+ja3Ph3/
 pwG0IUtW7psnsFcd+Rbp8XgbpJF9J30fWwYGAtoOi9fCu7mOH4UH25J7mBxyNsrZCk
 uniCKm3VI635v+e/2lomZ1JCtcaqzwxVv0+TAbLzucTlNizKq7D8vtAOofh9O9toYt
 s+p6K1EDq/ThHdAS2DIMT5FgBMzU+eMAhPJsrgdJ9X64Hn35NKSVPHsedczbz3RW3V
 5Ri+sB6ig33eqgLSDTjDNanl0p0QkXlv39pGUbc5ZVcqcdBAZLx1tD0bKDppxVfShg
 H20vJJ6vvs/6A==
Date: Tue, 18 Dec 2018 12:00:14 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
Message-ID: <20181218010014.GB25748@blackberry>
References: <20181105144717.6233-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105144717.6233-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 05, 2018 at 09:47:17AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
