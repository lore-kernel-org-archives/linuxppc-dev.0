Return-Path: <SRS0=fdF7=ZG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AF1C432C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 10:35:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFB520675
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 10:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFB520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DHtJ6x64zF6Pn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 21:35:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DFyQ2TS1zF5g2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2019 20:08:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 47DFyP197gz9sSn; Thu, 14 Nov 2019 20:08:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47DFyN5mFCz9sSm; Thu, 14 Nov 2019 20:08:28 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9155e2341aa8b5df057dc1c77633b33d1a4f17d2
In-Reply-To: <1573441836-3632-2-git-send-email-nayna@linux.ibm.com>
To: Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v9 1/4] powerpc/powernv: Add OPAL API interface to access
 secure variable
Message-Id: <47DFyN5mFCz9sSm@ozlabs.org>
Date: Thu, 14 Nov 2019 20:08:28 +1100 (AEDT)
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nayna Jain <nayna@linux.ibm.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, Elaine Palmer <erpalmer@us.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-11-11 at 03:10:33 UTC, Nayna Jain wrote:
> The X.509 certificates trusted by the platform and required to secure boot
> the OS kernel are wrapped in secure variables, which are controlled by
> OPAL.
> 
> This patch adds firmware/kernel interface to read and write OPAL secure
> variables based on the unique key.
> 
> This support can be enabled using CONFIG_OPAL_SECVAR.
> 
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Eric Richter <erichte@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9155e2341aa8b5df057dc1c77633b33d1a4f17d2

cheers
