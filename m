Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C97C282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07FA21B18
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDFzanuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07FA21B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yr3r6Y6qzDqXq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 02:55:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yr0p0gWXzDqVk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 02:53:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RDFzanuT"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43yr0n5Q6lz8wHc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 02:53:13 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43yr0n4hdYz9sMr; Tue, 12 Feb 2019 02:53:13 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=acme@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RDFzanuT"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43yr0n1WkHz9sML
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2019 02:53:13 +1100 (AEDT)
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 253AA21855;
 Mon, 11 Feb 2019 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549900391;
 bh=lsvBGqne0jJBcAN651CWc+0g/0g8Ws2zq9S61GO5sss=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=RDFzanuTkcknjtWvhhJSkF8nJV15SyVeSsxLwOd6UG24gmVYn5iNWnmvPDMdGMNo2
 e4f0fbrMcvogEu2oNDPwc+s/a+QyVlWoHR3rDx91NU2IRjtSc1jCLFOHPQjb0AtfqN
 4h7HB8e8xaPT7iuvo7s56yUivxcZC7CYC1yyDq5Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id 0457E410D5; Mon, 11 Feb 2019 12:53:09 -0300 (-03)
Date: Mon, 11 Feb 2019 12:53:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH v2 0/4] [powerpc] perf vendor events: Add JSON metrics
 for POWER9
Message-ID: <20190211155308.GE3269@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209181429.23950-1-pc@us.ibm.com>
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
Cc: maddy@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Namhyung Kim <namhyung@kernel.org>, naveen.n.rao@linux.vnet.ibm.com,
 sukadev@linux.ibm.com, Jiri Olsa <jolsa@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, cel@us.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Sat, Feb 09, 2019 at 01:14:25PM -0500, Paul Clarke escreveu:
> [Note this is for POWER*9* and is different content than a
> previous patchset for POWER*8*.]
> 
> The patches define metrics and metric groups for computation by "perf"
> for POWER9 processors.

Applied, thanks.

- Arnaldo
