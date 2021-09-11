Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF80C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 14:36:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CFE60698
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 14:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72CFE60698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6Fg76xYkz2yPB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Sep 2021 00:36:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uMcyHemG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uMcyHemG; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6FfL5dr5z2xtW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Sep 2021 00:35:54 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6D3A6109F;
 Sat, 11 Sep 2021 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631370951;
 bh=LW2199kttJtBTwAhoKWy75wM87SVN6+UIBjbbND4LYA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uMcyHemGp+1THisLwBmc8sth9JoOxiEj44S11tY69ywFVKEmUkfe7yZcIUVhkAgpG
 rF7SMCIGr8F7KU+zyBAEw5DGe70MThctGMSeBNG1bYBnj7ATTZYmKwiOBY5v+bXz0D
 HaVo6f8Q/G2SQguHdFB9ezWbBjiTMJ8ShDVx7bX6JRauvCYBq+32RXRraq7m10BbQQ
 xHcV9prI5MtKamXcOmLEfBiJ3YaocRFbZLE4OROn4UruO+vlbFtm56dF3QNmbqqFbJ
 4Dq/gnCSnNHLaUzhYV6H/VWfrSEFnD06ye93bUIDVsdoxjtxU5lCYj+k3r5YVbAcEQ
 4uEgyAuabiDrw==
Date: Sat, 11 Sep 2021 10:35:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH AUTOSEL 5.14 38/99] KVM: PPC: Book3S HV: XICS: Fix
 mapping of passthrough interrupts
Message-ID: <YTy+xUtEEpln2Sq4@sashalap>
References: <20210910001558.173296-1-sashal@kernel.org>
 <20210910001558.173296-38-sashal@kernel.org>
 <27739836-bad2-6b3f-7f40-e84663fbbf24@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27739836-bad2-6b3f-7f40-e84663fbbf24@kaod.org>
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
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 10, 2021 at 07:48:18AM +0200, Cédric Le Goater wrote:
>On 9/10/21 2:14 AM, Sasha Levin wrote:
>> From: Cédric Le Goater <clg@kaod.org>
>>
>> [ Upstream commit 1753081f2d445f9157550692fcc4221cd3ff0958 ]
>>
>> PCI MSIs now live in an MSI domain but the underlying calls, which
>> will EOI the interrupt in real mode, need an HW IRQ number mapped in
>> the XICS IRQ domain. Grab it there.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> Link: https://lore.kernel.org/r/20210701132750.1475580-31-clg@kaod.org
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>
>Why are we backporting this patch in stable trees ?
>
>It should be fine but to compile, we need a partial backport of commit
>51be9e51a800 ("KVM: PPC: Book3S HV: XIVE: Fix mapping of passthrough
>interrupts") which exports irq_get_default_host().

Or, I can drop it if it makes no sense?

-- 
Thanks,
Sasha
