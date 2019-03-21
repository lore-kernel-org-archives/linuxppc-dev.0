Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5A1C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 15:15:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A90B21874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 15:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="UxQKNFkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A90B21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Q9Mq3NwKzDqTj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 02:15:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.75; helo=rcdn-iport-4.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="UxQKNFkF"; 
 dkim-atps=neutral
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Q9KM2hJLzDqSy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 02:13:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=1517; q=dns/txt; s=iport;
 t=1553181207; x=1554390807;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2fo2JfVAue8n2M/QLCHSelH9JT7PNUxt9i6vmQgKBw4=;
 b=UxQKNFkF63iqj/ncJj6kJVy2nhMHrVjY1VKzDsiaUsCwpgdbfcChiAk/
 xb3L0Nz27ZomcykJICYK7Tu10NO92w8ALRdw9gYXtyaVH6oXlAG9T22JJ
 eVSMpcL9EoyJvVoQLFTGOOLdORWaPxqXbQ92aYwpHNKD+cCCclaNJ2XBA M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AHAADBqZNc/4sNJK1kGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUwIBAQEBAQsBghCBayeXS4INiTWFDIl2gXsNAQEYhFQ?=
 =?us-ascii?q?ChHQiNgcNAQEDAQEJAQMCbSiFSgEBAQQBOTQLEAsOBwIBCSUPEgcUEwgGE4U?=
 =?us-ascii?q?AAxWsIogCDYIfFA6BDQGLMReBQD+EIz6CGogLA5IskgobNgmCS4wzeoMzJQy?=
 =?us-ascii?q?TZ5JQi2YCBAYFAhWBVAEwgVYzGggbFTuCbJBrHwMwjggBAQ?=
X-IronPort-AV: E=Sophos;i="5.60,253,1549929600"; d="scan'208";a="537957179"
Received: from alln-core-6.cisco.com ([173.36.13.139])
 by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 21 Mar 2019 15:13:10 +0000
Received: from zorba ([10.24.63.212])
 by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id x2LFD8CL015099
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 21 Mar 2019 15:13:10 GMT
Date: Thu, 21 Mar 2019 08:13:08 -0700
From: Daniel Walker <danielwa@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] add generic builtin command line
Message-ID: <20190321151308.yt6uc3mxgppm5zko@zorba>
References: <20190319232448.45964-2-danielwa@cisco.com>
 <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
 <20190320232328.3bijcxek2yg43a25@zorba>
 <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.63.212, [10.24.63.212]
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
Cc: Maksym Kokhan <maksym.kokhan@globallogic.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 xe-linux-external@cisco.com, Daniel Walker <dwalker@fifo99.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 20, 2019 at 08:14:33PM -0700, Andrew Morton wrote:
> On Wed, 20 Mar 2019 16:23:28 -0700 Daniel Walker <danielwa@cisco.com> wrote:
> 
> > On Wed, Mar 20, 2019 at 03:53:19PM -0700, Andrew Morton wrote:
> > > On Tue, 19 Mar 2019 16:24:45 -0700 Daniel Walker <danielwa@cisco.com> wrote:
> > > 
> > > > This code allows architectures to use a generic builtin command line.
> > > 
> > > I wasn't cc'ed on [2/4].  No mailing lists were cc'ed on [0/4] but it
> > > didn't say anything useful anyway ;)
> > > 
> > > I'll queue them up for testing and shall await feedback from the
> > > powerpc developers.
> > > 
> > 
> > You weren't CC'd , but it was To: you,
> > 
> >  35 From: Daniel Walker <danielwa@cisco.com>
> >  36 To: Andrew Morton <akpm@linux-foundation.org>,
> >  37         Christophe Leroy <christophe.leroy@c-s.fr>,
> >  38         Michael Ellerman <mpe@ellerman.id.au>,
> >  39         Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
> >  40         linuxppc-dev@lists.ozlabs.org, Frank Rowand <frowand.list@gmail.com>
> >  41 Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> >  42 Subject: [PATCH 2/4] drivers: of: generic command line support
> 
> hm.
> 
> > Thanks for picking it up.
> 
> The patches (or some version of them) are already in linux-next,
> which messes me up.  I'll disable them for now.
 
Those are from my tree, but I remove them when you picked up the series. The
next linux-next should not have them.

Daniel
