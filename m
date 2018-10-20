Return-Path: <SRS0=IXoQ=NA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA9DC67863
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 23:23:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BF32172F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 23:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BF32172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42czNr6Pd6zDrVM
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 10:23:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42czLm4J5bzDrTf
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2018 10:21:36 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gE0Wg-0007Zr-3x; Sat, 20 Oct 2018 18:19:22 -0500
Message-ID: <2313a6cbedec8e742240c0f9f710f26f343158f7.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org,
 Christian Zigotzky <chzigotzky@xenosoft.de>, Julian Margetson
 <runaway@candw.ms>
Date: Sat, 20 Oct 2018 18:19:21 -0500
In-Reply-To: <4c7f98c86ad.343ea8c1@auth.smtp.1and1.co.uk>
References: <4c7f98c86ad.343ea8c1@auth.smtp.1and1.co.uk>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: darren@stevens-zone.net, linuxppc-dev@lists.ozlabs.org,
 chzigotzky@xenosoft.de, runaway@candw.ms
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH RFC] powerpc/kernel: Don't check for dev->dma_mask in
 fsl_set_dma_mask
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2018-09-02 at 12:30 +0100, Darren Stevens wrote:
> To enable use of dma to all ram on a corenet generic system, we add the
> function fsl_pci_dma_set_mask, and link it into the ppc.md structure.
> 
> But this function checks for the presence of dev->dma_mask and dma_ops
> at entry, and fails if one or other are missing. Powerpc's dma_set_mask 
> (which it is called from) doesn't check this until after it has set the 
> dma_mask for pci devs,

It's checking whether the dma_mask pointer is valid before storing into that
pointer.  The generic ppc dma_set_mask does check this before storing into it.
   All it does before that check is to look for an alternative dma_set_mask
implementation.

Is the test failing on dma_mask or dma_supported?  If the latter, what are the
dma ops set to?

Can you check whether the problem still exists after commit
ff69279a44e9ba876466 ("powerpc: disable support for relative ksymtab
references")?

-Scott

