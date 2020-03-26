Return-Path: <SRS0=iuvT=5L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55049C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 22:00:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DAF20714
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 22:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="JMnlHokU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DAF20714
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48pJnx24VWzDqS2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 09:00:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48pJlt44hJzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2020 08:58:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=JMnlHokU; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 48pJls712Wz9sRR; Fri, 27 Mar 2020 08:58:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1585259929; bh=Sf69iWUNrMQgDwyFTyrEPmKhiAksHzMcJ+e9NXva9XM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JMnlHokUFLvdNAUyd3LZd3Bu/BGitZr+URsSji24FWeLJKpN20AGvD98ZM/pZh2wn
 pM23ZJ+sEfSZwPjY1jGmYzm/KRK+Ejotg3ffuSZlU1XICemP4Mb5DjWePlirfNXZkj
 SUcrwRH5JsENXTwMmZ+CDyLdRwUufCNMjIwkpxdbKzhnva9bSS4TtC4y4NTIvpaD1n
 z2+Zzp7g2WQk5Zxxpj9Mq2NCGM7e6ExKfZimRvVOnQ/1L1OsALeqfbNrh7r+KYdyMI
 yIZjZila19w9omhqFebV2SFHjF+LiLMHNWj6fA/7y8t5T4yGWIE6qhjw+9ZN/Ji5cG
 HMteGzZrU/vjQ==
Date: Fri, 27 Mar 2020 08:40:05 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] ppc/smp: Replace unnecessary 'while' by 'if'
Message-ID: <20200326214005.GB9894@blackberry>
References: <20200326203752.497029-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326203752.497029-1-leonardo@linux.ibm.com>
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
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 26, 2020 at 05:37:52PM -0300, Leonardo Bras wrote:
> spin_until_cond() will wait until nmi_ipi_busy == false, and
> nmi_ipi_lock_start() does not seem to change nmi_ipi_busy, so there is
> no way this while will ever repeat.
> 
> Replace this 'while' by an 'if', so it does not look like it can repeat.

Nack, it can repeat.  The scenario is that cpu A is in this code,
inside spin_until_cond(); cpu B has previously set nmi_ipi_busy, and
cpu C is also waiting for nmi_ipi_busy to be cleared, like cpu A.
When cpu B clears nmi_ipi_busy, both cpu A and cpu C will see that and
will race inside nmi_ipi_lock_start().  One of them, say cpu C, will
take the lock and proceed to set nmi_ipi_busy and then call
nmi_ipi_unlock().  Then the other cpu (cpu A) will then take the lock
and return from nmi_ipi_lock_start() and find nmi_ipi_busy == true.
At that point it needs to go through the while loop body once more.

Paul.
