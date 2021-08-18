Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C1C4320A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:52:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A971A60EFE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A971A60EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqTpy2mblz3fVL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 23:52:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4GqTgy0LRkz3cPY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 23:46:06 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GqTgv4pCQz9sWq; Wed, 18 Aug 2021 23:46:03 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210801073822.12452-1-linkmauve@linkmauve.fr>
References: <20210701225743.14631-1-linkmauve@linkmauve.fr>
 <20210801073822.12452-1-linkmauve@linkmauve.fr>
Subject: Re: [PATCH v4 0/5] nvmem: nintendo-otp: Add new driver for the Wii
 and Wii U OTP
Message-Id: <162929392838.3619265.11174637469348336177.b4-ty@ellerman.id.au>
Date: Wed, 18 Aug 2021 23:38:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Ash Logan <ash@heyquark.com>, Paul Mackerras <paulus@samba.org>, Jonathan Neuschäfer <j.ne@posteo.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 1 Aug 2021 09:38:17 +0200, Emmanuel Gil Peyrot wrote:
> The OTP is a read-only memory area which contains various keys and
> signatures used to decrypt, encrypt or verify various pieces of storage.
> 
> Its size depends on the console, it is 128 bytes on the Wii and
> 1024 bytes on the Wii U (split into eight 128 bytes banks).
> 
> It can be used directly by writing into one register and reading from
> the other one, without any additional synchronisation.
> 
> [...]

Patches 3-5 applied to powerpc/next.

[3/5] powerpc: wii.dts: Reduce the size of the control area
      https://git.kernel.org/powerpc/c/b11748e693166679acc13c8a4328a71efe1d4a89
[4/5] powerpc: wii.dts: Expose the OTP on this platform
      https://git.kernel.org/powerpc/c/562a610b4c5119034aed300f6ae212ec7a20c4b4
[5/5] powerpc: wii_defconfig: Enable OTP by default
      https://git.kernel.org/powerpc/c/140a89b7bfe65e9649c4a3678f74c32556834ec1

cheers
