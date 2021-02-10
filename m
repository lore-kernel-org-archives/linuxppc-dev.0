Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF62CC433E6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:19:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155A064E7D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155A064E7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbL2r5qzGzDrBg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 00:19:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKY40xv3zDrfK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:28 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKY26GsFz9sW3; Wed, 10 Feb 2021 23:57:26 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <ad782af87a222efc79cfb06079b0fd23d4224eaf.1612515180.git.christophe.leroy@csgroup.eu>
References: <ad782af87a222efc79cfb06079b0fd23d4224eaf.1612515180.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Fix software emulation interrupt
Message-Id: <161296172333.3178259.7272491290910741468.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:26 +1100 (AEDT)
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

On Fri, 5 Feb 2021 08:56:13 +0000 (UTC), Christophe Leroy wrote:
> For unimplemented instructions or unimplemented SPRs, the 8xx triggers
> a "Software Emulation Exception" (0x1000). That interrupt doesn't set
> reason bits in SRR1 as the "Program Check Exception" does.
> 
> Go through emulation_assist_interrupt() to set REASON_ILLEGAL.

Applied to powerpc/next.

[1/1] powerpc/8xx: Fix software emulation interrupt
      https://git.kernel.org/powerpc/c/903178d0ce6bb30ef80a3604ab9ee2b57869fbc9

cheers
