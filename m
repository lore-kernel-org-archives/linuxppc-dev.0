Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53992C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:47:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC8C20879
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="I5JSTUMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC8C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kHVX2zCbzDqMh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:47:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kHPs3whQzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 16:42:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="I5JSTUMN"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43kHPs0s94z9s7T; Tue, 22 Jan 2019 16:42:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548135777; bh=gZMu+NfylDzzW+RSKGTA4tAO39Gye9VkVXQklu5M/8E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I5JSTUMNZh1hxndBFSjZ+rNwxwv5OCEwVEXgGjrrhlCP3zYW95C/T2rY/OQQlgFFK
 d+nukoAC7lsyaJkIQjep85AnSLgTEEVay34K7YcyE8zZ5lXWgTjwvxy8ch8BZo4DfP
 Jd60rqWz089PokjCahTJSrb6KuYICzd4Cm41yO1rG3SavZaGcOjehIlN8iX9nNIIwb
 mEZHjHnhavXMfCwxEoxO8T/FSzfJIW2luXykFMaauPWmFgqlBhN2wRFdImLpEi2hEB
 udVvEm7X0ZvJIrYTp4p5K4IUf0proAvZZlpPuwOxjyhc0pe5qXaJZzjOgm0+4Mgiu9
 ERoRuOwPCYnJw==
Date: Tue, 22 Jan 2019 16:26:57 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
Message-ID: <20190122052657.GG15124@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107191006.10648-2-clg@kaod.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 07, 2019 at 08:10:05PM +0100, Cédric Le Goater wrote:
> Clear the ESB pages from the VMA of the IRQ being pass through to the
> guest and let the fault handler repopulate the VMA when the ESB pages
> are accessed for an EOI or for a trigger.

Why do we want to do this?

I don't see any possible advantage to removing the PTEs from the
userspace mapping.  You'll need to explain further.

Paul.
