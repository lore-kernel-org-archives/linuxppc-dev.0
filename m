Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79670C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 17:06:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233F620883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 17:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqTYsk69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233F620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YzFG1XwPzDqXg
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 04:06:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=acme@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="nqTYsk69"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YzC25pQ3zDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 04:04:46 +1100 (AEDT)
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6829220883;
 Tue,  8 Jan 2019 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546967084;
 bh=iAGMvqEh4T3VJnjlbLL9BrMT+cRwthIvVtFtPI0f43Y=;
 h=Date:From:To:Cc:Subject:From;
 b=nqTYsk69X0nMq+/7XJp7hBIggKvqMfXDUpfm5Q5e8kTmkRIeTXiTKVF8YLPrZzFTf
 7IPYUBqr6iAQ/FT0GTDn7p6CW3S/ALuHExucKt+MmVLD0Q/TTKiogy9WS51o1aRy00
 k46mwN/5BawrQXcvn2l6Y4Xr7OiehsQPGFiKnq0M=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id A940140355; Tue,  8 Jan 2019 14:04:40 -0300 (-03)
Date: Tue, 8 Jan 2019 14:04:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: perf trace syscall table generation for powerpc with syscall.tbl
Message-ID: <20190108170440.GF28965@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Ravi,

	I noticed that in:

  commit ab66dcc76d6ab8fae9d69d149ae38c42605e7fc5
  Author: Firoz Khan <firoz.khan@linaro.org>
  Date:   Mon Dec 17 16:10:36 2018 +0530

    powerpc: generate uapi header and system call table files

powerpc now generates its syscall tables headers from a syscall.tbl just
like x86 and s390, could you please switch to using it, taking the x86
and s390 scripts as a starting point, then test on your systems
everything works?

Thanks,

- Arnaldo
