Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AA9C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 01:38:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE36520868
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 01:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="t/bdXm4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE36520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X6lq3Vf0zF3Sp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 12:37:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="t/bdXm4a";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="t/bdXm4a"; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42X6jF1LCdzF3Kk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 12:35:45 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id 30-v6so6668387plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 18:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WNSmz6gPUWl0psy6VYdrKZKj8jjeGLoBOEaYk7PTF5E=;
 b=t/bdXm4ahfHUsC1W/kmIGtZM4IaaXFvhptMHyl/MsEl85wogOLcBRPLXwHtXoa2xTR
 d2M48uB6euL4d5IaKV5t6nT5ABUr0y0qRBKJlUNuiclAcNB1bktYaPSMWAk89SYK1P2v
 +doypv+PPbaJGW2yXU+EaPjAWnWnd1ZXLhamE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WNSmz6gPUWl0psy6VYdrKZKj8jjeGLoBOEaYk7PTF5E=;
 b=Dm2yPRSvuM3okatCZWBBo4SLfYRvVf6XrdBbZTPCthrBDF3v6MhEWklRRpuF9W8MSg
 YCry5P5OWHNzH1vAHOqLzrxoghKXMOEb0UC1hWlDxpSeZ2OYorGdx4TJq4akUFbSYVNe
 K/V/XMiTz0TI3qPzU4bZ3IjtWBKsDuJ99tTCcOPslJz61M7pcQbN6VxEFefW53h+gGuU
 Z1xvjTyOEdgafYrybz8DKWUEuxlS89qQXTAnzGFkA42EgdePLPbAAdqRn7rvGBTvOTjU
 dMZrMhu2/CrZ3PJ1sk96ZuFuFfRxQunisxu6ZuAyp4WIF1GU4cqTGdxAr+KVkZ3zX4EA
 qFPw==
X-Gm-Message-State: ABuFfoi7D2vPC1dEPmwL0wy9dCgPeE2B5xkQNJcvckFmDTdCbJX2nQAz
 QizutkjRcD0oLjYFdvSnfKkWPQ==
X-Google-Smtp-Source: ACcGV63YcGHLeWFH+zMcDfPGfwOAvPK81iWmstN1Bsc/dCjm29V/T1DgWrxlTjwp6QBDN3hA/VReOg==
X-Received: by 2002:a17:902:d20a:: with SMTP id
 t10-v6mr8118444ply.256.1539394543039; 
 Fri, 12 Oct 2018 18:35:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id 20-v6sm3688934pge.77.2018.10.12.18.35.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Oct 2018 18:35:41 -0700 (PDT)
Date: Fri, 12 Oct 2018 18:35:40 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181013013540.GA207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012.111836.1569129998592378186.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, mhocko@kernel.org, linux-mm@kvack.org,
 lokeshgidra@google.com, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, jonas@southpole.se, linux-s390@vger.kernel.org,
 dancol@google.com, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, deller@gmx.de, hughd@google.com,
 jejb@parisc-linux.org, kasan-dev@googlegroups.com,
 kvmarm@lists.cs.columbia.edu, mingo@redhat.com, geert@linux-m68k.org,
 aryabinin@virtuozzo.com, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, fenghua.yu@intel.com, jdike@addtoit.com,
 linux-um@lists.infradead.org, Julia.Lawall@lip6.fr,
 linux-m68k@lists.linux-m68k.org, bp@alien8.de, luto@kernel.org,
 nios2-dev@lists.rocketboards.org, kirill@shutemov.name, gxt@pku.edu.cn,
 chris@zankel.net, richard@nod.at, linux-parisc@vger.kernel.org,
 pantin@google.com, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org,
 minchan@kernel.org, linux-alpha@vger.kernel.org, lftan@altera.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 11:18:36AM -0700, David Miller wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
[...]
> > Also, do we not flush the caches from any path when we munmap
> > address space?  We do call do_munmap on the old mapping from mremap
> > after moving to the new one.
> 
> Sparc makes sure that shared mapping have consistent colors.  Therefore
> all that's left are private mappings and those will be initialized by
> block stores to clear the page out or similar.
> 
> Also, when creating new mappings, we flush the D-cache when necessary
> in update_mmu_cache().
> 
> We also maintain a bit in the page struct to track when a page which
> was potentially written to on one cpu ends up mapped into another
> address space and flush as necessary.
> 
> The cache is write-through, which simplifies the preconditions we have
> to maintain.

Makes sense, thanks. For the moment I sent patches to enable this on arm64
and x86. We can enable it on sparc as well at a later time as it sounds it
could be a safe optimization to apply to that architecture as well.

thanks,

 - Joel

