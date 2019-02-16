Return-Path: <SRS0=Luu/=QX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A9CC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 13:26:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60461218AC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 13:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60461218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441rW21wgnzDqDK
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 00:26:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441rSk4GHKzDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 00:24:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 441rSj2RYXz8sxp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 00:24:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 441rSh5xxHz9s9G; Sun, 17 Feb 2019 00:24:20 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nefkom.net
 (client-ip=212.18.0.9; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
X-Greylist: delayed 533 seconds by postgrey-1.36 at bilbo;
 Sun, 17 Feb 2019 00:24:19 AEDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 441rSh0j88z9s3l
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2019 00:24:19 +1100 (AEDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 441rGJ38jnz1r01b;
 Sat, 16 Feb 2019 14:15:20 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 441rGJ29m3z1qqkS;
 Sat, 16 Feb 2019 14:15:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id 8E9i_dOXwDyq; Sat, 16 Feb 2019 14:15:19 +0100 (CET)
X-Auth-Info: WAZZ1lxIpLiJaGUL7WPeQCu95RDgYXrEcAgkoSQ4XdXOKg7aXAfiS1bzR4aClOM1
Received: from igel.home (ppp-188-174-150-184.dynamic.mnet-online.de
 [188.174.150.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sat, 16 Feb 2019 14:15:19 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
 id A50CE2C202B; Sat, 16 Feb 2019 14:15:18 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to
 pgd/pud_present()
References: <20190214062339.7139-1-mpe@ellerman.id.au>
X-Yow: I'll take ROAST BEEF if you're out of LAMB!!
Date: Sat, 16 Feb 2019 14:15:18 +0100
In-Reply-To: <20190214062339.7139-1-mpe@ellerman.id.au> (Michael Ellerman's
 message of "Thu, 14 Feb 2019 17:23:39 +1100")
Message-ID: <87pnrran89.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
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
Cc: erhard_f@mailbox.org, jack@suse.cz, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Feb 14 2019, Michael Ellerman <mpe@ellerman.id.au> wrote:

> The fix is simple, we need to convert the result of the bitwise && to
> an int before returning it.

Alternatively, the return type could be changed to bool, so that the
compiler does the right thing by itself.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
