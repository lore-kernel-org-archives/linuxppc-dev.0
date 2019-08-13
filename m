Return-Path: <SRS0=6DYt=WJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2812C32750
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Aug 2019 05:03:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD50206C2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Aug 2019 05:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="pfdf0Qqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD50206C2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4670wC0kW2zDqRr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Aug 2019 15:03:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4670qf0XD3zDqRb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2019 14:59:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="pfdf0Qqu"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4670qd41HZz9sPH; Tue, 13 Aug 2019 14:59:09 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4670qd37Ttz9sNF; Tue, 13 Aug 2019 14:59:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1565672349; bh=zEBhVZ6IpXDU4PYZ9P+PigemVld0vncVI7JH/weoHsQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pfdf0QquNKcWiP9FC0OfWcm5hNPpORqt+0lxo3RUcH+SaRi76xamqMtyqHdKIQBNz
 QfZa70VSnv5bAMZJD38VWzA7Yt2lMzts+TbsO4ftSoT3Lz0AqunsRCQNNpRkWlLyBo
 06jnKnzdAy3NBe8ftweSiWlGm8BFlvvR5s8iLrGyWfWf8n0pfhXKikSCOq4xn5X1ah
 ++klMjYhH4FNsq9P007EzLPHCdF+++6qmbkq82X0FYM/p7s0ZSkih+FzXdywu2DuaI
 8zpvR5nrgqLXX6QpAXIhX6/zrg8rVUDl+7rm1Wy1kTEAzOZtbOk95HYG3QTzbZ3QOb
 5Z/k0KQiXu3qw==
Date: Tue, 13 Aug 2019 14:59:05 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: Fix race in re-enabling XIVE
 escalation interrupts
Message-ID: <20190813045905.nsoi7u2ke3mz4qkq@oak.ozlabs.ibm.com>
References: <20190812050623.ltla46gh5futsqv4@oak.ozlabs.ibm.com>
 <20190812050705.mlszjkatxa635pzh@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812050705.mlszjkatxa635pzh@oak.ozlabs.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 12, 2019 at 03:07:05PM +1000, Paul Mackerras wrote:

>  	lbz	r5, VCPU_XIVE_ESC_ON(r9)
>  	cmpwi	r5, 0
> -	beq	1f
> +	beq	4f
>  	li	r0, 0
>  	stb	r0, VCPU_CEDED(r9)
> +	li	r6, XIVE_ESB_SET_PQ_10
> +	b	1f
> +4:	li	r0, 1
> +	stb	r0, VCPU_XIVE_ESC_ON(r9)

This ends up setting vcpu->arch.xive_esc_on even on platforms without
XIVE, which is wrong.  I'll send a v2.

Paul.
