Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C6C00319
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 14:51:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BB22084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 14:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BB22084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444y8h0wfzzDqRq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 01:51:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 444y5N5l9czDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 01:48:24 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BF0CA78;
 Thu, 21 Feb 2019 06:48:23 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B13BB3F690;
 Thu, 21 Feb 2019 06:48:21 -0800 (PST)
Date: Thu, 21 Feb 2019 14:48:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 3/7] powerpc/mm: Add a framework for Kernel Userspace
 Access Protection
Message-ID: <20190221144818.GI33673@lakrids.cambridge.arm.com>
References: <20190221093601.27920-1-ruscur@russell.cc>
 <20190221093601.27920-4-ruscur@russell.cc>
 <adb2b7c9-3472-2b9c-37e1-6150697d0940@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adb2b7c9-3472-2b9c-37e1-6150697d0940@c-s.fr>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
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
Cc: kernel-hardening@lists.openwall.com, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 21, 2019 at 11:46:06AM +0100, Christophe Leroy wrote:
> 
> 
> Le 21/02/2019 à 10:35, Russell Currey a écrit :
> > From: Christophe Leroy <christophe.leroy@c-s.fr>
> > 
> > This patch implements a framework for Kernel Userspace Access
> > Protection.
> > 
> > Then subarches will have to possibility to provide their own
> > implementation by providing setup_kuap() and lock/unlock_user_access()
> > 
> > Some platform will need to know the area accessed and whether it is
> > accessed from read, write or both. Therefore source, destination and
> > size and handed over to the two functions.
> 
> Should we also consider adding user_access_begin() and the 3 other
> associated macros ?
> 
> See x86 for details.

As a heads-up, there are some potential issues with
user_access_{begin,end}() that may affect PPC. There's a long thread
starting at:

https://lkml.kernel.org/r/1547560709-56207-4-git-send-email-julien.thierry@arm.com/

Thanks,
Mark.
