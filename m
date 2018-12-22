Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AF5C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 08:02:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046E921939
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 08:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046E921939
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MHyb3r6gzDqQd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 19:01:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=osadl.at
 (client-ip=178.115.242.59; helo=mail.osadl.at; envelope-from=hofrat@osadl.at;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=hofr.at
Received: from mail.osadl.at (178.115.242.59.static.drei.at [178.115.242.59])
 by lists.ozlabs.org (Postfix) with ESMTP id 43MHwH6N6QzDqQJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 18:59:56 +1100 (AEDT)
Received: by mail.osadl.at (Postfix, from userid 1001)
 id C59C15C0864; Sat, 22 Dec 2018 08:59:44 +0100 (CET)
Date: Sat, 22 Dec 2018 08:59:44 +0100
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
Message-ID: <20181222075944.GA26155@osadl.at>
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
 <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
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
Cc: Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Nicholas Mc Guire <hofrat@osadl.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 21, 2018 at 08:29:56PM -0600, Scott Wood wrote:
> On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> > devm_kstrdup() may return NULL if internal allocation failed, but
> > as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
> > can be used here, which will only copy the reference.
> 
> Is it really going to only copy the reference?  That would require that
> is_kernel_rodata(machine) be true, which it shouldn't be since it's not part
> of the kernel image.
>
I had tried to figure out what is RO and what not but was not 
able to determine that - from the discussion it seemed that the
assumption of RO is correct though I did not ask if it would
satisfy is_kernel_rodata() so that explains the incorrect assertion.
see https://lkml.org/lkml/2018/12/6/42
So then the only option is to check the return and cleanup
on allocation failure as the orriginal patch proposed.

thanks for clearifying this !
hofrat
