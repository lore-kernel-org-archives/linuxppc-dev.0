Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2931C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 05:35:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EEE20870
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 05:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOtw4gAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EEE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bWly4x04zDr3G
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 16:35:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=5qap=pt=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="vOtw4gAI"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bWkD6ts0zDqrm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 16:33:40 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 025F820870;
 Fri, 11 Jan 2019 05:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547184818;
 bh=87y3t+Sr7bcxLc3Qv5o6z5HgzHBecJvvmq1YVGwbsYY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vOtw4gAIwpAlsLW3stVrHc9EHM6wS0abSXux3mfxi3I1dCJWi5AOC0p5UYhJg225f
 XOce66PyaLKsZdccn3ms/HPOtdwm9raRO/rTY8V2gVgs0C4Q+FWURzYob9n12X+Lk6
 iKaT5pH80lyPI9/cotLUDzFnE3vmbGoAuPtNyps0=
Date: Fri, 11 Jan 2019 06:33:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: Patch series for 4.19 to compile powerpc with Clang
Message-ID: <20190111053334.GA24945@kroah.com>
References: <20190110171738.GA15747@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110171738.GA15747@flashbox>
User-Agent: Mutt/1.11.2 (2019-01-07)
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
Cc: Sasha Levin <sashal@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 10:17:38AM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Attached is an mbox with a series of patches to allow building the
> powerpc kernel with Clang. We have been running continuous integration
> that builds and boots the kernel in QEMU for almost two months now with
> no regressions. This is on top of 4.19.14, there should be no conflicts
> but let me know if I messed something up.
> 
> I will send a series for 4.14 in a little bit as well.

All now queued up for 4.19 as well.

thanks,

greg k-h
