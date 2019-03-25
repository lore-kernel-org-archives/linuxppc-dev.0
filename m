Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F1AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 20:14:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B5E20854
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 20:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B5E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Slpn5nRdzDqHS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 07:14:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nefkom.net
 (client-ip=212.18.0.10; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Slmr5VdFzDqLB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 07:12:42 +1100 (AEDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 44Slmg6Xmvz1rFtC;
 Mon, 25 Mar 2019 21:12:35 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 44Slmg1XwQz1qr5R;
 Mon, 25 Mar 2019 21:12:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id afvt7Yvs8gfC; Mon, 25 Mar 2019 21:12:34 +0100 (CET)
X-Auth-Info: WCX8Im/gVjTCyk70+ITBVCwkNuFPM1y/YC6ASCZCniynrrdKzQFViV0n8GSa+KAK
Received: from igel.home (ppp-46-244-174-3.dynamic.mnet-online.de
 [46.244.174.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Mon, 25 Mar 2019 21:12:34 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
 id 9B25B2C162C; Mon, 25 Mar 2019 21:12:33 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
References: <20190317011756.abjylw3nzfnc6gnh@decadent.org.uk>
 <44QjSh4zGhz9sV2__48832.6491251186$1553257542$gmane$org@ozlabs.org>
 <87k1gnq5lp.fsf@igel.home>
 <eb21be1ac183dd206da3a389b426707c535c463c.camel@decadent.org.uk>
 <87ftrbq0qe.fsf@igel.home>
 <cf9154f1812e0e9a328a1e21ef13d80a46e5feb6.camel@decadent.org.uk>
 <87a7hjp4oi.fsf@concordia.ellerman.id.au>
X-Yow: You must be a CUB SCOUT!!  Have you made your MONEY-DROP today??
Date: Mon, 25 Mar 2019 21:12:33 +0100
In-Reply-To: <87a7hjp4oi.fsf@concordia.ellerman.id.au> (Michael Ellerman's
 message of "Mon, 25 Mar 2019 22:35:41 +1100")
Message-ID: <877ecm1zny.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
Cc: Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mär 25 2019, Michael Ellerman <mpe@ellerman.id.au> wrote:

> So I'm inclined to just switch to always using SPARSEMEM on 64-bit
> Book3S, because that's what's well tested and we hardly need more code
> paths to test. Unless anyone has a strong objection, I haven't actually
> benchmarked FLATMEM vs SPARSEMEM on a G5.

Configuring with SPARSEMEM saves about 32Mb of memory.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
