Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6CBC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 16:59:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DAB206B8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 16:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="a3xXG8/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DAB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CmV24yPgzDqGP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 03:59:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.74; helo=rcdn-iport-3.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="a3xXG8/N"; 
 dkim-atps=neutral
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CmSH6jJ8zDqDP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 03:58:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=2007; q=dns/txt; s=iport;
 t=1551718704; x=1552928304;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=c50ZIywUpsMCMU1oUj0oxf5EyRgZtC9XPfp4h0vLbl8=;
 b=a3xXG8/N9HnFhDSrilaCt8jJ7skhjJx2uTX/k1tWM0WgnrazYzt3qdyT
 SgVy2rfhMCwP/cle+Bp1jcqDklxOS/WS2aVGCtYxi861LXk8bq846sonw
 RpcRbn4tJZu52d1982JnwX6txjd6Qv07Ge4Kx/Lq5Q155Dgec30qxMTO/ 8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AEAADzWH1c/5tdJa1lGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGCD2iBAyeMIotKgg2ONYlsgXsLAQEjhEQDAgK?=
 =?us-ascii?q?EJSI0CQ0BAQMBAQMBAwJtHAyFSwEFMgFGEAsYCSUPLRsGgzaBdQ+qN4oiBRQ?=
 =?us-ascii?q?OgQ0BhFmGTheBQD+EI4EoGQGBXAKHQgKKARIghziSGQmCQIUDiyUlDIFohWK?=
 =?us-ascii?q?LTJA/jEgCBAYFAhRvWDiBVjMaCBsVgyeCIoNWinQeAzCRFQEB?=
X-IronPort-AV: E=Sophos;i="5.58,440,1544486400"; d="scan'208";a="518229051"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
 by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Mar 2019 16:58:00 +0000
Received: from zorba ([10.156.154.19])
 by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id x24GvwjZ019533
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 4 Mar 2019 16:58:00 GMT
Date: Mon, 4 Mar 2019 08:57:58 -0800
From: Daniel Walker <danielwa@cisco.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PULL REQUEST] powerpc generic command line
Message-ID: <20190304165758.suqyact3tiueslqx@zorba>
References: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
 <e80b18e3-92fe-3726-a7d7-72f98cdd0b86@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e80b18e3-92fe-3726-a7d7-72f98cdd0b86@c-s.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.19, [10.156.154.19]
X-Outbound-Node: rcdn-core-4.cisco.com
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

On Mon, Mar 04, 2019 at 02:55:08PM +0100, Christophe Leroy wrote:
> 
> 
> Le 01/03/2019 à 20:44, Daniel Walker a écrit :
> > Here are the generic command line changes for powerpc.
> > 
> > These changes have been in linux-next for two cycles, with few problems reported.
> > It's also been used at Cisco Systems, Inc. in production products for many many
> > years with no problems.
> > 
> > Please pull these changes.
> > 
> > 
> > The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:
> > 
> >    Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)
> > 
> > are available in the git repository at:
> > 
> >    https://github.com/daniel-walker/cisco-linux.git for-powerpc
> > 
> > for you to fetch changes up to 5d4514a9c291ecf19b0626695161673d35e5d549:
> > 
> >    powerpc: convert config files to generic cmdline (2018-11-16 07:32:26 -0800)
> > 
> > ----------------------------------------------------------------
> > Daniel Walker (3):
> >        add generic builtin command line
> >        powerpc: convert to generic builtin command line
> >        powerpc: convert config files to generic cmdline
> 
> Hello,
> 
> This series is in total contradiction with the work being done to add KASAN
> support to powerpc.
> 
> It also modifies the behaviour for powerpc.
> 
> Please do not apply this series as is, see my comments on the individual
> patchs for details.
> 

Not trying to offend you, but you comments seems overly alarmist. KASAN is a
debug feature, generally we don't write code around debug features (especially
ones which aren't merged yet). It would not be hard to correct our use of string
functions when your KASAN enablement is merged, I'm sure you could do it, but I would be happy
to do it also. The other comments you had I don't think rise to the level of
stopping a pull request. Our code is stabilized, so I'm not going to
re-design it at a late date like this.

I think the pull request is still valid.

Daniel
