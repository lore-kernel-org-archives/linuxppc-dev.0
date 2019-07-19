Return-Path: <SRS0=ugCm=VQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C735C7618F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 16:07:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF0B2186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 16:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmoQqm+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF0B2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qwqs3j9NzDqtl
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jul 2019 02:07:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qmoQqm+c"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qwnZ3lVpzDqtR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2019 02:05:04 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id p17so32741709wrf.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dFBxfHIIkZj/vVsiAN1B0GaZv4SmAdgmjXZzJQqEU9A=;
 b=qmoQqm+cm8JfhVK79rrK6WKEFVwdHw5UMzQlgGas2DvO+CQh+qaY1lTjbUZU1NdNQ4
 FCpmcyM9xNz1HPnLZ4+xP7ohF8nB2LYRg7FTY2XRs9EbNsZ0An77ewLdygagKZ3wUVPc
 RiIj6qSNa7xXNiwu9sqea7JakIQpg6BrpR95hI4Mj3hnogY6a0TjHASmZ/L5hT25CYT2
 lVfXRK1f/iqX1s6ca9/Xo3lWb8Ju3N3evwKoHm+CybJS1oKxl7NqO/XaaA3An5B9CyKI
 xCZwUKkUojZRzqKwlA/KnihZMio2IO9lZWWbZvzalJvAwIvXSi2XQtA/6GynByXLk19G
 hmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dFBxfHIIkZj/vVsiAN1B0GaZv4SmAdgmjXZzJQqEU9A=;
 b=X7PoskbuBwCJFRw/OKoq7CZ26ZmJTAqDja6EJu76egLO4WHGeZRPfrCrC/L8+8NFuJ
 O+zKXjF+Tp9pbDmqUNXYUH+QkcyV4h7JJgrboMTNLs9HrigD9wjhn6aRFyL1ooPYkMfH
 QDbqGl0T0nEOOTi6GSz5cEeWiWH8kxqiwrQbOt6+QjL42QQP70VsITFZXVk25yavVWDF
 Id0/+ExtHmg1Nt/Z8rjWND49H7hL8tdq6ybF2ykGn1w8V5LHk7mnrRJ8AkTjFdyGU+cK
 lnIQD+dbSCoglx/G8lWWR5Jb1kak83n4S+PUaJGE1bhv4+HQ3NWfAT9CC7syoT1ntRu+
 e0Lg==
X-Gm-Message-State: APjAAAWPFSdhWXOa6bgfBqF35v8mH/7hDPxpMt9D5RvXDt5QOV5hkB4A
 1F36kIarQZe3L2t2EfD2Aao=
X-Google-Smtp-Source: APXvYqxu5WOesyzz5zUnwrOhjaRHG/mzN5sPCvIO9i605E3qpYbn5r5l0Q6NmAQCIxHKCne2lg4wTA==
X-Received: by 2002:adf:f005:: with SMTP id j5mr12593107wro.251.1563552297446; 
 Fri, 19 Jul 2019 09:04:57 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
 by smtp.gmail.com with ESMTPSA id y24sm22398788wmi.10.2019.07.19.09.04.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 09:04:56 -0700 (PDT)
Date: Fri, 19 Jul 2019 09:04:55 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190719160455.GA12420@archlinux-threadripper>
References: <c6ff2faba7fbb56a7f5b5f08cd3453f89fc0aaf4.1557480165.git.christophe.leroy@c-s.fr>
 <45hnfp6SlLz9sP0@ozlabs.org>
 <20190708191416.GA21442@archlinux-threadripper>
 <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
 <20190709064952.GA40851@archlinux-threadripper>
 <20190719032456.GA14108@archlinux-threadripper>
 <20190719152303.GA20882@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719152303.GA20882@gate.crashing.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jul 19, 2019 at 10:23:03AM -0500, Segher Boessenkool wrote:
> On Thu, Jul 18, 2019 at 08:24:56PM -0700, Nathan Chancellor wrote:
> > On Mon, Jul 08, 2019 at 11:49:52PM -0700, Nathan Chancellor wrote:
> > > On Tue, Jul 09, 2019 at 07:04:43AM +0200, Christophe Leroy wrote:
> > > > Is that a Clang bug ?
> > > 
> > > No idea, it happens with clang-8 and clang-9 though (pretty sure there
> > > were fixes for PowerPC in clang-8 so something before it probably won't
> > > work but I haven't tried).
> > > 
> > > > 
> > > > Do you have a disassembly of the code both with and without this patch in
> > > > order to compare ?
> > > 
> > > I can give you whatever disassembly you want (or I can upload the raw
> > > files if that is easier).
> > 
> > What disassembly/files did you need to start taking a look at this? I
> > can upload/send whatever you need.
> 
> A before and after of *only this patch*.  And then look at what changed;
> it maybe be obvious what is the problem to you, as well, so look at it
> yourself first?
> 
> 
> Segher

Thanks, I will go ahead and disassemble the full kernel given that those
helpers are everywhere and see what I can find. I'll reach out again if
I can't come up with anything.

Thanks for the advice!
Nathan
