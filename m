Return-Path: <SRS0=8l9v=3G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF36AC33CB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 11:37:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B2A2072B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 11:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B2A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47zfD76g2bzDqnV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 22:36:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.128.67; helo=mail-wm1-f67.google.com;
 envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47zf8l1zDtzDqlW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 22:33:58 +1100 (AEDT)
Received: by mail-wm1-f67.google.com with SMTP id p17so7275945wmb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 03:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pS6tGirNA5l2St8BRcYo+tvzqyq6o10cg8yYZAWBJ5A=;
 b=hQEnoMD24tlRLh2bH9j4etE7d+vB90Zox2nDymJNUvESUhHgafUQRZmgkpmVOXtdwQ
 hl++HIbxKjQKai0ooduR2WI3U5VQyBWmLVqwer9LWrAk5xzZSDApB2z3fNG/sxVkzNc8
 sPrDB8tadHXozNNZGWwPLb4bD/cfutq5aiUcLHjHXE/Z6qeY3RgJWODA+jRPI0ktOXWC
 ecCB3hpwGkD9WUqOmI7D4LOtauTaSVFGykRsglKjJ/P/XJonjPJL8fM+x9pVJ/PhJZSn
 +c6dpdI+FJ0/yHpkNodwOf0QQSiNcgzB0uzSP56Usej931ncKrj/d9cEpDyFlDYdaqWs
 cnLQ==
X-Gm-Message-State: APjAAAVD4pD308XQve9EXNerc2/XRDMPSVi5dX+a4+fbKp6RkOJVrhWJ
 +FXp9F2TiG0xTBzotZoct1o=
X-Google-Smtp-Source: APXvYqxYYwk3Ieuhh1JlXLR3/Y6vU+ft9LXH9FfnZA5oIVuyDDQ22H4//+d0cssKHwtPEfLC9wp91g==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr4294224wmf.56.1579260834716; 
 Fri, 17 Jan 2020 03:33:54 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
 by smtp.gmail.com with ESMTPSA id t12sm33450532wrs.96.2020.01.17.03.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 03:33:54 -0800 (PST)
Date: Fri, 17 Jan 2020 12:33:53 +0100
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
Message-ID: <20200117113353.GT19428@dhcp22.suse.cz>
References: <20200117105759.27905-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117105759.27905-1-david@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Allison Randal <allison@lohutok.net>, lantianyu1986@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri 17-01-20 11:57:59, David Hildenbrand wrote:
> Let's refactor that code. We want to check if we can offline memory
> blocks. Add a new function is_mem_section_offlineable() for that and
> make it call is_mem_section_offlineable() for each contained section.
> Within is_mem_section_offlineable(), add some more sanity checks and
> directly bail out if the section contains holes or if it spans multiple
> zones.

I didn't read the patch (yet) but I am wondering. If we want to touch
this code, can we simply always return true there? I mean whoever
depends on this check is racy and the failure can happen even after
the sysfs says good to go, right? The check is essentially as expensive
as calling the offlining code itself. So the only usecase I can think of
is a dumb driver to crawl over blocks and check which is removable and
try to hotremove it. But just trying to offline one block after another
is essentially going to achieve the same.

Or does anybody see any reasonable usecase that would break if we did
that unconditional behavior?
-- 
Michal Hocko
SUSE Labs
