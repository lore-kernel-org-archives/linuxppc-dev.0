Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD25C433E9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:37:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF8E64E79
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF8E64E79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbLRG65jhzDsmb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 00:37:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKY54Hy4zDrBq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKY44w7Yz9sVw; Wed, 10 Feb 2021 23:57:27 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <c72f014730823b413528e90ab6c4d3bcb79f8497.1612692067.git.christophe.leroy@csgroup.eu>
References: <c72f014730823b413528e90ab6c4d3bcb79f8497.1612692067.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/uaccess: Perform barrier_nospec() in KUAP
 allowance helpers
Message-Id: <161296172412.3178259.4318567757525360600.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:27 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 7 Feb 2021 10:08:11 +0000 (UTC), Christophe Leroy wrote:
> barrier_nospec() in uaccess helpers is there to protect against
> speculative accesses around access_ok().
> 
> When using user_access_begin() sequences together with
> unsafe_get_user() like macros, barrier_nospec() is called for
> every single read although we know the access_ok() is done
> onece.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/uaccess: Perform barrier_nospec() in KUAP allowance helpers
      https://git.kernel.org/powerpc/c/8524e2e76441fc615a3b5c1415823e051cc79eae

cheers
