Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD22AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F262147A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="DdLdMg7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F262147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Cp6Y6NHSzDqHp
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 05:13:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.77; helo=rcdn-iport-6.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="DdLdMg7T"; 
 dkim-atps=neutral
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Cp4k2sQSzDqFs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 05:11:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=5463; q=dns/txt; s=iport;
 t=1551723094; x=1552932694;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bl94wOTSWCQc149FMPOAsjnN1MEcYFqDIyzOncGLb0c=;
 b=DdLdMg7T/paiLa8UyNBwDR7nSg9pc0oxqDIcF8cEuhXCcA3YZQ574umt
 vEN4QIM+NK0+hF+5vOwy0u/G0MgPPp6PBO95jQxBzHifOVDdn5GtfRVAU
 1yf+Yi2SS9kB9j1tdv198kghY5jVxoZP3tdGtEiV59JcjqPtWRAba/LX9 w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AJAACkaX1c/4sNJK1kGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUgQBAQEBCwGCD2hQMyeXbYINjjWJbIF7CwEBI4REAwIChCU?=
 =?us-ascii?q?iNQgNAQEDAQEDAQMCbRwMhUoBAQEBAgEyAUYQCxgJJQ8tGwaDNoFtCA+qR4Q?=
 =?us-ascii?q?vAQsBhWkFFA6BDQGEWYZOF4FAP4ERgxKBKBkBgVwCAhiHKAKKARIghziRPF0?=
 =?us-ascii?q?JgkCFA4slJQyBaIVii0yQP4xIAgQGBQIUb1kBNoFWMxoIGxU7gjgBM4Iig1a?=
 =?us-ascii?q?FFIVgHgMwkRUBAQ?=
X-IronPort-AV: E=Sophos;i="5.58,440,1544486400"; d="scan'208";a="528745959"
Received: from alln-core-6.cisco.com ([173.36.13.139])
 by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Mar 2019 18:11:26 +0000
Received: from zorba ([10.156.154.19])
 by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id x24IBPA3014038
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 4 Mar 2019 18:11:26 GMT
Date: Mon, 4 Mar 2019 10:11:24 -0800
From: Daniel Walker <danielwa@cisco.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PULL REQUEST] powerpc generic command line
Message-ID: <20190304181124.ecdblrqt2an6xlvt@zorba>
References: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
 <e80b18e3-92fe-3726-a7d7-72f98cdd0b86@c-s.fr>
 <20190304165758.suqyact3tiueslqx@zorba>
 <b804556b-9a2d-96a3-3e16-8ffbbd6006d4@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b804556b-9a2d-96a3-3e16-8ffbbd6006d4@c-s.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.19, [10.156.154.19]
X-Outbound-Node: alln-core-6.cisco.com
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
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, xe-linux-external@cisco.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 04, 2019 at 06:29:12PM +0100, Christophe Leroy wrote:
> 
> 
> Le 04/03/2019 à 17:57, Daniel Walker a écrit :
> > On Mon, Mar 04, 2019 at 02:55:08PM +0100, Christophe Leroy wrote:
> > > 
> > > 
> > > Le 01/03/2019 à 20:44, Daniel Walker a écrit :
> > > > Here are the generic command line changes for powerpc.
> > > > 
> > > > These changes have been in linux-next for two cycles, with few problems reported.
> > > > It's also been used at Cisco Systems, Inc. in production products for many many
> > > > years with no problems.
> > > > 
> > > > Please pull these changes.
> > > > 
> > > > 
> > > > The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:
> > > > 
> > > >     Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > >     https://github.com/daniel-walker/cisco-linux.git for-powerpc
> > > > 
> > > > for you to fetch changes up to 5d4514a9c291ecf19b0626695161673d35e5d549:
> > > > 
> > > >     powerpc: convert config files to generic cmdline (2018-11-16 07:32:26 -0800)
> > > > 
> > > > ----------------------------------------------------------------
> > > > Daniel Walker (3):
> > > >         add generic builtin command line
> > > >         powerpc: convert to generic builtin command line
> > > >         powerpc: convert config files to generic cmdline
> > > 
> > > Hello,
> > > 
> > > This series is in total contradiction with the work being done to add KASAN
> > > support to powerpc.
> > > 
> > > It also modifies the behaviour for powerpc.
> > > 
> > > Please do not apply this series as is, see my comments on the individual
> > > patchs for details.
> > > 
> > 
> > Not trying to offend you, but you comments seems overly alarmist. KASAN is a
> > debug feature, generally we don't write code around debug features (especially
> > ones which aren't merged yet). It would not be hard to correct our use of string
> > functions when your KASAN enablement is merged, I'm sure you could do it, but I would be happy
> > to do it also. The other comments you had I don't think rise to the level of
> > stopping a pull request. Our code is stabilized, so I'm not going to
> > re-design it at a late date like this.
> > 
> > I think the pull request is still valid.
> > 
> 
> Ok, lets the KASAN stuff aside. And I agree I misread the patch when I felt
> that it was changing the behaviour in prom_init.c
> 
> I don't want to criticise your work either, but your series seems overkill.
> Anyway, could you explain your approach and what is the benefit of your
> series compared to what is already existing ?

Current behavior varies across different architectures. Some platforms prepend
the command line with the boot loader arguments some platforms append it. Cisco
uses all these platforms. We desire a method to either append or prepend on a
number of architectures. It reduces code duplication across multiple
architectures. It allows a number of other command line related features to be
added in a single location instead of across all architectures. For example MIPS
has some additional features added related to the command line arguments, this
could be made generic and available to all architectures.

> 
> Can you also explain how your changes fit with the what is done is the
> function early_init_dt_scan_chosen_ppc() in drivers/of/fdt.c as your series
> doesn't modify it ? (extract below)
> 
> 
> 
> 	/*
> 	 * CONFIG_CMDLINE is meant to be a default in case nothing else
> 	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
> 	 * is set in which case we override whatever was found earlier.
> 	 */
> #ifdef CONFIG_CMDLINE
> #if defined(CONFIG_CMDLINE_EXTEND)
> 	strlcat(data, " ", COMMAND_LINE_SIZE);
> 	strlcat(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> #elif defined(CONFIG_CMDLINE_FORCE)
> 	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> #else
> 	/* No arguments from boot loader, use kernel's  cmdl*/
> 	if (!((char *)data)[0])
> 		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> #endif
> #endif /* CONFIG_CMDLINE */
 
Our code supersedes this code, and you can see the code is doing similar things.
Eventually this block will be replaced with a call into generic functions. We've
submitted changes to this code in the past,

https://lore.kernel.org/patchwork/patch/604997/

However, this code doesn't lend itself to piecemeal conversion to a generic
system. It's a generic system itself, but only for architectures/platforms with specific
characteristics. This is why we're doing it one at a time with PowerPC first.

> 
> 
> 
> What I like in your series is that you make the CMDLINE config common to all
> arches. But my feeling is that the 40 or so lines of code in your cmdline.h
> is way complex compared to what it aims to do, ie replacing a few lines on
> code in two places. But I might not have the complete picture so feel free
> to tell all the details behind it. I see you already submitted part of your
> series to the ppc list in Novembre
> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=75078)
> unfortunatly the first patch of the series was not there, and it seems at
> that time your series has not generated any further discussion.

Our code has been out there for years. I don't recall our first submission but
it was prior to last year.

Daniel
