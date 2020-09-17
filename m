Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7705C43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 14:37:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEA82223D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 14:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEA82223D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsfgV4689zDqfD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 00:37:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nefkom.net (client-ip=212.18.0.9; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsfcG3dM1zDqWW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2020 00:34:17 +1000 (AEST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4Bsfc51bKlz1qrfr;
 Thu, 17 Sep 2020 16:34:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4Bsfc50dRNz1qxpD;
 Thu, 17 Sep 2020 16:34:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id 5BBP84tpYrRa; Thu, 17 Sep 2020 16:34:12 +0200 (CEST)
X-Auth-Info: 9jeFQNW3jEEEH5nEGLwfVfPMZp09Oa4fJ4yvtcjDHLxUxZpFdLTFXHuxHVOi8s+j
Received: from igel.home (ppp-46-244-188-79.dynamic.mnet-online.de
 [46.244.188.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Thu, 17 Sep 2020 16:34:11 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id 0E03B2C2894; Thu, 17 Sep 2020 16:34:11 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] powerpc: fix EDEADLOCK redefinition error in
 uapi/asm/errno.h
References: <20200916074214.995128-1-Tony.Ambardar@gmail.com>
 <20200917000757.1232850-1-Tony.Ambardar@gmail.com>
 <87363gpqhz.fsf@mpe.ellerman.id.au>
 <CAK8P3a3FVoDzNb1TOA6cRQDdEc+st7KkBL70t0FeStEziQG4+A__37056.5000850306$1600351707$gmane$org@mail.gmail.com>
X-Yow: Yow!  Am I cleansed yet?!
Date: Thu, 17 Sep 2020 16:34:11 +0200
In-Reply-To: <CAK8P3a3FVoDzNb1TOA6cRQDdEc+st7KkBL70t0FeStEziQG4+A__37056.5000850306$1600351707$gmane$org@mail.gmail.com>
 (Arnd Bergmann's message of "Thu, 17 Sep 2020 16:01:27 +0200")
Message-ID: <87h7rw321o.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Tony Ambardar <tony.ambardar@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rosen Penev <rosenp@gmail.com>, Paul Mackerras <paulus@samba.org>,
 bpf <bpf@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sep 17 2020, Arnd Bergmann wrote:

> The errno man page says they are supposed to be synonyms,
> and glibc defines it that way, while musl uses the numbers
> from the kernel.

glibc also uses whatever the kernel defines.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
