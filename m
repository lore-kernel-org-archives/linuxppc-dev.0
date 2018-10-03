Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FB5C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 11:21:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4AA2098A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 11:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4AA2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QD9L1CNnzF39Y
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 21:21:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=nefkom.net
 (client-ip=212.18.0.10; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QD6y1Z0FzDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 21:19:05 +1000 (AEST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 42QD6r4B9mz1qww0;
 Wed,  3 Oct 2018 13:19:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 42QD6r2hdGz1qr2b;
 Wed,  3 Oct 2018 13:19:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id t37ftDVoAwRL; Wed,  3 Oct 2018 13:18:58 +0200 (CEST)
X-Auth-Info: +vMFtp+hNuJSLqU6+IKnC4iMh+Nq2qLu/KrAtYOYtOO/idFxJFr8jcRkDNdx+qd4
Received: from igel.home (ppp-188-174-144-109.dynamic.mnet-online.de
 [188.174.144.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Wed,  3 Oct 2018 13:18:58 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id F2BB62C2044; Wed,  3 Oct 2018 13:18:56 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc: use PTRRELOC during early init
References: <20180914011411.3184-1-mikey__14553.8904158913$1536887645$gmane$org@neuling.org>
 <871s98av6p.fsf__4781.35763337395$1538516654$gmane$org@igel.home>
 <87wor09dww.fsf_-_@igel.home>
 <acfeead1-90f9-d13c-41f2-e4bdd38e3702@c-s.fr>
X-Yow: If elected, Zippy pledges to each and every American
 a 55-year-old houseboy...
Date: Wed, 03 Oct 2018 13:18:56 +0200
In-Reply-To: <acfeead1-90f9-d13c-41f2-e4bdd38e3702@c-s.fr> (Christophe LEROY's
 message of "Wed, 3 Oct 2018 08:22:08 +0200")
Message-ID: <87woqzcm73.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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
Cc: Michael Neuling <mikey@neuling.org>,
 Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Okt 03 2018, Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Did you try my proposed fix https://patchwork.ozlabs.org/patch/977195/ ?

That works as well.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
