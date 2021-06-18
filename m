Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2640DC48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 12:13:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C53A61057
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 12:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C53A61057
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5yW83CyVz3c5F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 22:13:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=Dh63+Hio;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=paulus@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=Dh63+Hio; dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5yVg3nqZz307T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 22:12:58 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4G5yVT3Rzbz9sT6; Fri, 18 Jun 2021 22:12:49 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4G5yVS6X64z9sVp; Fri, 18 Jun 2021 22:12:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1624018368; bh=MyKOvU2M1w9HCVX5bMBrsh8qmF/WaxXgRIvqbgpLOs8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dh63+HioMBmlnLwhGLum8Zle5TJq8/6JBZXO16/eRHe/vAos3sv5doMh1DWm3waHX
 PPRLsrOQjtm+mTlnmvOgxllw573mKwQDTMzOlPRq0Y1+wMaIcEZ8FZcdj7TgzWNeak
 3Cw/wE7lopDEu9btjY2nxknMzf9NfCBHiPaJWdYnNzamwRURzGxv98EgweRE9Tvr5Z
 VsCebnks2HZGO776wxvyj665vtH7V7MO4BSw7pJ32FkSouRPhvMgUFcCeHSmc8Zl1i
 vsDPXUE3jvxZ4C6ehHxnrQwbB1NCVyG3poC8HG0Wg/i4DPK+CCYKggvdnHsrIiA+gT
 uI5RzuD4Ag/oQ==
Date: Fri, 18 Jun 2021 22:12:20 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 5/9] powerpc/microwatt: Use standard 16550 UART for
 console
Message-ID: <YMyNpLwqttl4IGSH@thinks.paulus.ozlabs.org>
References: <YMwWPcsaWzMlDPqQ@thinks.paulus.ozlabs.org>
 <YMwXGCTzedpQje7r@thinks.paulus.ozlabs.org>
 <1624001539.de8wj3qkjv.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624001539.de8wj3qkjv.astroid@bobo.none>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 18, 2021 at 05:40:40PM +1000, Nicholas Piggin wrote:
> Excerpts from Paul Mackerras's message of June 18, 2021 1:46 pm:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > This adds support to the Microwatt platform to use the standard
> > 16550-style UART which available in the standalone Microwatt FPGA.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
...
> > +#ifdef CONFIG_PPC_EARLY_DEBUG_MICROWATT
> > +
> > +#define UDBG_UART_MW_ADDR	((void __iomem *)0xc0002000)
> > +
> > +static u8 udbg_uart_in_isa300_rm(unsigned int reg)
> > +{
> > +	uint64_t msr = mfmsr();
> > +	uint8_t  c;
> > +
> > +	mtmsr(msr & ~(MSR_EE|MSR_DR));
> > +	isync();
> > +	eieio();
> > +	c = __raw_rm_readb(UDBG_UART_MW_ADDR + (reg << 2));
> > +	mtmsr(msr);
> > +	isync();
> > +	return c;
> > +}
> 
> Why is realmode required? No cache inhibited mappings yet?

Because it's EARLY debug, for use in the very early stages of boot
when the kernel's radix tree may or may not have been initialized.
The easiest way to make a function that works correctly whether or not
the radix tree has been initialized and the MMU turned on is to
temporarily turn off the MMU for data accesses and use lbzcix/stbcix
(which Microwatt has, even though it doesn't implement hypervisor
mode).

(I don't know which "yet" you meant - "yet" in the process of booting a
kernel, or "yet" in the process of Microwatt's development?  Microwatt
certainly does have cache-inhibited mappings and has done since the
MMU was first introduced.)

In fact the defconfig I add later in the series doesn't enable
CONFIG_PPC_EARLY_DEBUG_MICROWATT, but it's there if it's needed for
debugging.

> mtmsrd with L=0 is defined to be context synchronizing in isa 3, so I 
> don't think the isync would be required. There is a bit of code around 
> arch/powerpc that does this, maybe it used to be needed or some other
> implementations needed it?
> 
> That's just for my curiosity, it doesn't really hurt to have them
> there.

Right, and in fact mtmsrd is marked as a single-issue instruction in
Microwatt, so it should work with no isyncs or eieios.  Presumably Ben
copied the isync/eieio pattern from somewhere else.

Paul.
