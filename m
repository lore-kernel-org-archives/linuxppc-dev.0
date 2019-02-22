Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:45:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E942077B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ibT1uChB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E942077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445RJx6QQvzDqTf
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 20:45:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RGt4NjNzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:43:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ibT1uChB"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 445RGs6GnZz9sB3; Fri, 22 Feb 2019 20:43:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550828597; bh=OfjPq093CyPjo4AMfPwtO+t7qcDZ1z8IDHIL3UcTjeo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ibT1uChB9g62FXgRBUJ0O7DoiaN2uYPltnYrY4yqJjIKunD7FHHSGT8BzUU0uN3+z
 IxkC9gELEiFcPEd0Saebr7m4FcI+17r+djQfDVYwDfgv9cXHqLFjYp53Iz8B/j0UJO
 GqHwJyXMNgmF8sllQzLExYAQgEvVyzYiaQyfFqIMuMoGYHYMd6gU6zEc1yOhA44Myz
 dnnlsgd+5Fw+7943PDwcxigK0hUIcaNZ1jTkarVCG584KqwzO6Jxs46fDNtle4dOMN
 zCoiuLhP4b6iv1tIuZsc7pyJUYaZfTrHBljm+A5YSSbxmauExeNg4dvxlHU+hMifGh
 pEAw+qnt8pDyA==
Date: Fri, 22 Feb 2019 20:40:10 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH v2] KVM: PPC: Book3S: Add KVM stat largepages_[2M/1G]
Message-ID: <20190222094010.GD6006@blackberry>
References: <20190219035345.26239-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219035345.26239-1-sjitindarsingh@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 19, 2019 at 02:53:45PM +1100, Suraj Jitindar Singh wrote:
> This adds an entry to the kvm_stats_debugfs directory which provides the
> number of large (2M or 1G) pages which have been used to setup the guest
> mappings.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Thanks, applied to my kvm-ppc-next tree.

Paul.
