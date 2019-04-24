Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D3C282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:46:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E634206A3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ue6fgFca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E634206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q5nD4XDtzDqWG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 02:46:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ue6fgFca"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q5l11fyhzDqSB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 02:44:45 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id k19so9659670pgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rdi04PqMLBm5A89mHKxVJWAwKBP+chl4VgE6VxuYN/4=;
 b=ue6fgFcaWXCtvUQ4AZgjZXUar9PSH9NaBb+ZtE3nLwcNM1D3F61CleZEaILj/pVWrS
 Wi5LyzBMSL0hGJ35gzr1K8Lz/EyAdXGV9PDB8C1rFSpAbUSWJdUrF4Gfusto3y+lky13
 cYWFqtJOFSHQqWmGV+qpAUi1HwEf2kh6E9K5iaOuU0oQq7vyZXMKDrY8sFAv/9lSE5ko
 M0DZeKP2agxmPhcShJxuXE3HNBNNY8p3mxNOD5utr4RQpZ1ZH2UTpwA2cqsbZYqFtylr
 rcaKSqV32GkRjet1n95hQon6YQ8n9O6ntPgulAPwMh8t/07kiNQL0rQonHCeiTGPOmlW
 uKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rdi04PqMLBm5A89mHKxVJWAwKBP+chl4VgE6VxuYN/4=;
 b=G1fgRdriq533u2oQjW4dHhPkjtCkFSakEHWujlUfPKFQNKn4kHVkKhbrdLDHp1qb80
 apVPOigPiKnxs2XhkNezMQqiEuE1xvSeham2Ut5ya2yZ/0uTjyBtu94YLlqR2rPaqucP
 sTI1iQsiWsOJzanJXB9WBf/rHvMBNRluMXl3n4ywyntUfPEPq40tq6tVpJCjoDs3g+IO
 DUGxaCjpGG47G7D6ApWEUA+WNYK+7iWrz9oBSfIhiteDuXlskrXJ5cS/81umKHn88KBK
 n4B7qkncQ98ej+1un/CtquwPorF90PBqVEjUw5stq5a//MX/31yNKLijK7JfG0YySRKY
 4oXg==
X-Gm-Message-State: APjAAAXPjppGTpUwq0wESlbrcVs0B61AelDBaLv5kU4/zffGnnZoOttf
 TL6pOAnhbGNhbdkpmIPeO+w=
X-Google-Smtp-Source: APXvYqwc1gd/8vmyhdxwaHK4g48HxCZu4kGxfp15JgXVeLS0PwSazeDkfGTmmyc21Il7yIo1S1LbOw==
X-Received: by 2002:a63:1058:: with SMTP id 24mr27113008pgq.297.1556124279798; 
 Wed, 24 Apr 2019 09:44:39 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c22sm27913390pfn.136.2019.04.24.09.44.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Apr 2019 09:44:39 -0700 (PDT)
Date: Thu, 25 Apr 2019 00:44:30 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 15/63] Documentation: ACPI: move
 dsd/data-node-references.txt to firmware-guide/acpi and convert to reST
Message-ID: <20190424164428.r4wgyeexeuaoujuw@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-16-changbin.du@gmail.com>
 <20190423181748.24f8aed2@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423181748.24f8aed2@coco.lan>
User-Agent: NeoMutt/20180716
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
Cc: fenghua.yu@intel.com, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 23, 2019 at 06:17:48PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:44 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  .../acpi/dsd/data-node-references.rst}        | 28 +++++++++++--------
> >  Documentation/firmware-guide/acpi/index.rst   |  1 +
> >  2 files changed, 17 insertions(+), 12 deletions(-)
> >  rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (79%)
> > 
> > diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> > similarity index 79%
> > rename from Documentation/acpi/dsd/data-node-references.txt
> > rename to Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> > index c3871565c8cf..79c5368eaecf 100644
> > --- a/Documentation/acpi/dsd/data-node-references.txt
> > +++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> > @@ -1,9 +1,12 @@
> > -Copyright (C) 2018 Intel Corporation
> > -Author: Sakari Ailus <sakari.ailus@linux.intel.com>
> > -
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> >  
> > +===================================
> >  Referencing hierarchical data nodes
> > ------------------------------------
> > +===================================
> > +
> > +:Copyright: |copy| 2018 Intel Corporation
> > +:Author: Sakari Ailus <sakari.ailus@linux.intel.com>
> >  
> >  ACPI in general allows referring to device objects in the tree only.
> >  Hierarchical data extension nodes may not be referred to directly, hence this
> > @@ -28,13 +31,14 @@ extension key.
> >  
> >  
> >  Example
> > --------
> > +=======
> >  
> > -	In the ASL snippet below, the "reference" _DSD property [2] contains a
> > -	device object reference to DEV0 and under that device object, a
> > -	hierarchical data extension key "node@1" referring to the NOD1 object
> > -	and lastly, a hierarchical data extension key "anothernode" referring to
> > -	the ANOD object which is also the final target node of the reference.
> > +In the ASL snippet below, the "reference" _DSD property [2] contains a
> > +device object reference to DEV0 and under that device object, a
> > +hierarchical data extension key "node@1" referring to the NOD1 object
> > +and lastly, a hierarchical data extension key "anothernode" referring to
> > +the ANOD object which is also the final target node of the reference.
> > +::
> >  
> >  	Device (DEV0)
> >  	{
> > @@ -75,10 +79,10 @@ Example
> >  	    })
> >  	}
> >  
> > -Please also see a graph example in graph.txt .
> > +Please also see a graph example in :doc:`graph`.
> >  
> >  References
> > -----------
> > +==========
> >  
> >  [1] Hierarchical Data Extension UUID For _DSD.
> >      <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
> 
> Hmm... on the previous patch, you replaced <URL:some_url> by some_url,
> with makes sense. Please do the same here and on other patches on
> this series with a similar way to describe URLs.
>
Done, thanks.

> > diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> > index f81cfbcb6878..6d4e0df4f063 100644
> > --- a/Documentation/firmware-guide/acpi/index.rst
> > +++ b/Documentation/firmware-guide/acpi/index.rst
> > @@ -9,6 +9,7 @@ ACPI Support
> >  
> >     namespace
> >     dsd/graph
> > +   dsd/data-node-references
> >     enumeration
> >     osi
> >     method-customizing
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
