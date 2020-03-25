Return-Path: <SRS0=ePRe=5K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324D6C54FD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 11:05:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CC620714
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 11:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CC620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nQJ03XXTzDqBc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 22:05:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rjwysocki.net (client-ip=79.96.170.134;
 helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rjwysocki.net
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nPfw4ySwzDqXq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 21:36:23 +1100 (AEDT)
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id a27912dfd0cb6c9e; Wed, 25 Mar 2020 11:36:18 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: powernv: Fix frame-size-overflow in
 powernv_cpufreq_work_fn
Date: Wed, 25 Mar 2020 11:36:18 +0100
Message-ID: <7394005.IE404Cl4Vv@kreacher>
In-Reply-To: <87h7yexnu7.fsf@mpe.ellerman.id.au>
References: <20200316135743.57735-1-psampat@linux.ibm.com>
 <1921198.IfoiWgUDIW@kreacher> <87h7yexnu7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: ego@linux.vnet.ibm.com, pratik.r.sampat@gmail.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pratik Rajesh Sampat <psampat@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tuesday, March 24, 2020 7:34:56 AM CET Michael Ellerman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> > On Monday, March 16, 2020 2:57:43 PM CET Pratik Rajesh Sampat wrote:
> >> The patch avoids allocating cpufreq_policy on stack hence fixing frame
> >> size overflow in 'powernv_cpufreq_work_fn'
> >> 
> >> Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
> >> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> >
> > Any objections or concerns here?
> >
> > If not, I'll queue it up.
> 
> I have it in my testing branch,

Great!

> but if you pick it up I can drop it.

Let it go in through your tree.

Cheers!



