Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C678C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 10:48:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8342E2082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 10:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iFgYPtVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8342E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kBC70sK3zDrMl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 21:48:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iFgYPtVn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="iFgYPtVn"; dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kB8Q43zzzDr69
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 21:45:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Ualk9jtkWpjB7bYVqz+vL2mjxb2tON7rk5yFRjsZiY=; b=iFgYPtVn6CfKr9y0zoGZhB96M
 sfibn3qSfl8xZi14MnhfT4+mfYNtMPMn7lS+kZiMYrW0qp7lIh9KKlQJKv1/epan7fdFFOQpc9QCX
 6m7LyWVG8qVtmFyzCz0k6PODEai84MFC4+80F67NZfIyLLECggMuol3vQ9Mhi2smGEqJI=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:47390)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gH52M-00044N-G1; Mon, 29 Oct 2018 10:44:46 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gH52J-00084H-4y; Mon, 29 Oct 2018 10:44:43 +0000
Date: Mon, 29 Oct 2018 10:44:41 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
Message-ID: <20181029104441.GF30658@n2100.armlinux.org.uk>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com>
 <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
 <CAMT6-xj1rjVAy1AWFiMHc5wH36eu=TUSMtdKU=-qRtUbwr9bkg@mail.gmail.com>
 <20181023144815.GP30658@n2100.armlinux.org.uk>
 <CAMT6-xhvqy5PeQmkQ8tsLRiML_pNJTxyq7dizRRvZTEqc7uzgg@mail.gmail.com>
 <20181024090732.GS30658@n2100.armlinux.org.uk>
 <20181029102914.GA14127@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029102914.GA14127@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: linux-mips@linux-mips.org, linux-efi@vger.kernel.org,
 Ruslan Bilovol <rbilovol@cisco.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>,
 Frank Rowand <frowand.list@gmail.com>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 James Hogan <jhogan@kernel.org>, Daniel Walker <danielwa@cisco.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Bordunov <aborduno@cisco.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Maksym Kokhan <maksym.kokhan@globallogic.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 10:29:15AM +0000, Will Deacon wrote:
> On Wed, Oct 24, 2018 at 10:07:32AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Oct 24, 2018 at 11:57:44AM +0300, Maksym Kokhan wrote:
> > > Do you mean, that you haven't seen patch for ARM, which I sent on
> > > September 27 along with cover and patch 1? It is strange, because
> > > you was the one from recipients. If so, you can see this patch here:
> > > https://lore.kernel.org/patchwork/patch/992779/
> > 
> > It seems that I have received patch 5, _but_ it's not threaded with
> > the cover message and patch 1.  With 50k messages in my inbox, and 3k
> > messages since you sent the series, it's virtually impossible to find
> > it (I only found it by looking at my mail server logs from September
> > to find the subject, and then searching my mailbox for that subject.)
> > 
> > This is unnecessarily difficult.
> 
> This comes up surprisingly often, and I think part of the issue is that
> different maintainers have different preferences. I also prefer to receive
> the entire series and cover-letter, but I've seen people object to being
> CC'd on the whole series as well (how they manage to review things in
> isolation is another question...!)

This series has the odd situation where patch 1 is threaded to the
cover letter, but nothing else is - that makes it inconsistent.

Where I've seen people disagree with threading is when sending
follow-up series - whether that should be threaded to the previous
series or not - some people want it others hate it.

However, I haven't seen any disagreement is about having the patches
threaded to the cover.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
