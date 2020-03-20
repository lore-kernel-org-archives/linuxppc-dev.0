Return-Path: <SRS0=DNDs=5F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59813C4332B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D4D20774
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SS2stUyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D4D20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kF7t1CP0zDrbn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 18:02:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+e7fddad6f7a51abe8bfe+6053+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kF5k5jjZzDrbn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 18:00:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=iZ+tfXP9s+9EAQeQf95cP5ovh7AcQ3rFatDjmNA0Hpo=; b=SS2stUyn7rcx2bDE5sgbJPy234
 X9zm/vp1W32VRiUAiag9wc6+PVqSgvIgsex3vU9E84yi9emMqCBjOL8b7qfPZtQkzzDv+ofwjR/c0
 QqIG4wFoyXYG03dKfZLr/ByjjOnzQZgMIsED/UXA3TjGOpdi16UiLfl7+s/pKrebSwQXNd9u4pstl
 +qXtTUiOQHDVZkhWsyHsqIFLLUunbIQgVzbJEP1S4/2sDgk9ikKUV9u7HOeGT3pSs1gwB2yhFrrPK
 c3xR/dV7sjrTgGqDl4NyeXhuFf9XPfBkHa1DsefnsUIiMYD5W+PnILH3G4rhCIrK0mmmME0frAQvb
 yfAFAVTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jFBdD-00080q-N8; Fri, 20 Mar 2020 06:59:47 +0000
Date: Thu, 19 Mar 2020 23:59:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [patch V2 11/15] completion: Use simple wait queues
Message-ID: <20200320065947.GA25206@infradead.org>
References: <20200318204302.693307984@linutronix.de>
 <20200318204408.521507446@linutronix.de>
 <CAGRGNgXAW14=8ntTiB_hJ_nLq7WC_oFR3N9BNjqVEZM=ze85tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRGNgXAW14=8ntTiB_hJ_nLq7WC_oFR3N9BNjqVEZM=ze85tQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-usb <linux-usb@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Kalle Valo <kvalo@codeaurora.org>, Felipe Balbi <balbi@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-wireless@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 20, 2020 at 10:25:41AM +1100, Julian Calaby wrote:
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -1703,7 +1703,7 @@ static void ffs_data_put(struct ffs_data
> >                 pr_info("%s(): freeing\n", __func__);
> >                 ffs_data_clear(ffs);
> >                 BUG_ON(waitqueue_active(&ffs->ev.waitq) ||
> > -                      waitqueue_active(&ffs->ep0req_completion.wait) ||
> > +                      swait_active(&ffs->ep0req_completion.wait) ||
> 
> This looks like some code is reaching deep into the dirty dark corners
> of the completion implementation, should there be some wrapper around
> this to hide that?

Or just remote it entirely..
