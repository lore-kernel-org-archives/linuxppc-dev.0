Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F6C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:26:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7A0213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="TOFJPqMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7A0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447nNb3WpHzDqPN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 16:26:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447nLS2xpxzDqL7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 16:24:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="TOFJPqMI"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 447nLR5fWVz9s70; Tue, 26 Feb 2019 16:24:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1551158671; bh=bQeeNTJw27VkDhH/LWV2uWrg7lzj55pNQxQ51JW24t4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TOFJPqMIJGcrHQjJxZaGlafb1OpIT07T+eZPBM7MgF0vcrw9Zz5L8H39MnykpxwYm
 8guNRFJSmWRj4IA6s7zdPePJCPwZfoHJs/6o7mxS8W0ztwweswGZ+EFd+whtbQHLlX
 XR0lJDic7RbSvXT6EkC59wrpyyBlUjkfVkmFxgoXP064hEDy7xi1gQKEQbUGXni1oG
 +qPbTgroOZRXMZg9LRGoXUm0wlrbWdRS3Mce9HMq/tPXhihZRBunfRNhNb2Uf8w0FR
 0USfc3Eodp5Qj8xt2Y7jA+Z+zd8LYFuY9ZRkOo2atsd9ISypRCgABsni0b5VKBYpbo
 kDxY/HzU1lCtQ==
Date: Tue, 26 Feb 2019 15:25:15 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 04/16] KVM: PPC: Book3S HV: XIVE: add a control to
 initialize a source
Message-ID: <20190226042515.GB28015@blackberry>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-5-clg@kaod.org>
 <20190225021012.GH7668@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190225021012.GH7668@umbus.fritz.box>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 25, 2019 at 01:10:12PM +1100, David Gibson wrote:
> On Fri, Feb 22, 2019 at 12:28:28PM +0100, Cédric Le Goater wrote:
> > +	/*
> > +	 * If the source doesn't already have an IPI, allocate
> > +	 * one and get the corresponding data
> > +	 */
> > +	if (!state->ipi_number) {
> > +		state->ipi_number = xive_native_alloc_irq();
> > +		if (state->ipi_number == 0) {
> > +			pr_err("Failed to allocate IRQ !\n");
> > +			return -ENXIO;
> > +		}
> > +		xive_native_populate_irq_data(state->ipi_number,
> > +					      &state->ipi_data);
> > +		pr_debug("%s allocated hw_irq=0x%x for irq=0x%lx\n", __func__,
> > +			 state->ipi_number, irq);
> > +	}
> > +
> > +	arch_spin_lock(&sb->lock);
> 
> Why the direct call to arch_spin_lock() rather than just spin_lock()?

He's sharing data structures with the xics-on-xive code, and that code
has a real-mode variant, and in real mode we don't want to risk
invoking lockdep code.  Hence sb->lock is an arch_spinlock_t, and he
has to use arch_spin_lock() on it.

Paul.
