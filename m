Return-Path: <SRS0=vDV2=4M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6863EC35679
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 10:32:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2305820828
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 10:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2305820828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Qz0K5g5FzDqV9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 21:32:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=76.164.61.194; helo=kernel.crashing.org;
 envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
X-Greylist: delayed 771 seconds by postgrey-1.36 at bilbo;
 Mon, 24 Feb 2020 21:30:28 AEDT
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Qyxw0L3hzDqPl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2020 21:30:27 +1100 (AEDT)
Received: from localhost (gate.crashing.org [63.228.1.57])
 (authenticated bits=0)
 by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01OAHKrN026076
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 24 Feb 2020 04:17:27 -0600
Message-ID: <587a0a1765ba1264b92044f7b1f9937eb40731f1.camel@kernel.crashing.org>
Subject: Re: vdso function descriptors (VDS64_HAS_DESCRIPTORS)?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>, Joe Lawrence
 <joe.lawrence@redhat.com>
Date: Mon, 24 Feb 2020 21:17:19 +1100
In-Reply-To: <20200223000715.GW22482@gate.crashing.org>
References: <20200217160852.GA9557@redhat.com>
 <20200223000715.GW22482@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2020-02-22 at 18:07 -0600, Segher Boessenkool wrote:
> > 
> > so I don't believe they are ever used by default -- in this case
> > V_FUNCTION_BEGIN doesn't add to the .opd section with .name, .TOC base,
> > etc.
> > 
> > Manually setting VDS64_HAS_DESCRIPTORS results in a vdso64.so in which
> > binutils tools like readelf properly report functions with symbol type
> > FUNC instead of NOTYPE.
> > 
> > Are there pieces of the build/etc toolchain unprepared for function
> > descriptors?  I'm just trying to figure out why the code defaults to
> > unsetting them.
> 
> Because direct calls are faster than indirect calls?  Ben might have a
> fuller explanation, cc:ing him.

I don't remember why :-) I think I didn't want to mess with the OPD
fixup in glibc back then.

Ben.


