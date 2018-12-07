Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6766C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:43:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D7D208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dD/A+y/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D7D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439wGm2kgRzDqdj
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 12:43:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dD/A+y/O";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="dD/A+y/O"; dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439wD1138nzDrT8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 12:41:01 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id c73so1071511pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 17:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rdQMAag42WIh6sWwSVc114NUpg7aB2gq0mS9tdQMK5M=;
 b=dD/A+y/OaWqgJYJoRW8nOyV6X4wOp9QU8xZVE6zrZKhtHmxgfO02gM/zkhJRLTtxjc
 8fdpr1hTRhdTyee9lRr+I3x3tDDUcxWM33/6gkUytGDjHj7L7J3VueV6LHH+bCeMB/CH
 hU0tpx5INr0qKH8YupsfKx1K041YdxaXoa0OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rdQMAag42WIh6sWwSVc114NUpg7aB2gq0mS9tdQMK5M=;
 b=bG+8bS4bWQU82TgKiRg86elcJJ0LPGGaYnBlE5JbuUHr49F9lM25pK7ba4XiqSj1aD
 JSSy/9MCqQGRYqgjKFDQ5M9+HcCIQZiBKgNDK0LqIuRZWlZb99tKKHYJNZgxavkmfO6u
 HIWkpIJgRIo2L5E/QphYN+F6gSMWmdDd0169KbU+bl/whSilXEvy/HGxrywMQqqfznpy
 fn729p8dfc4F3+w87tESHSJ0oysogMoNdeILfsN55QtCAhklsz9bI+wNVXQt2KQ/388p
 ZEaeFhcVDseDvulSGRzlPmnt3hWy5NVlYMX6BLn8U4Mmlx94cW5Xulc6u3iD6uo9aN9a
 30Mg==
X-Gm-Message-State: AA+aEWZDYdd9rGrB4B8GIdE718Dg8j+JCdsVuO+q7ePXMdmFc6EHCCyb
 9qb7mZagRdJaxellvwGtG2B3NQ==
X-Google-Smtp-Source: AFSGD/U2dL8RZDcQsBinURn3VPAoo/B4dU/fXSeO2fsL+wbHy6pOaFMkRxB5VW5FnGwwvPLRfJIkYg==
X-Received: by 2002:a62:1709:: with SMTP id 9mr272611pfx.249.1544146858813;
 Thu, 06 Dec 2018 17:40:58 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id x7sm1777232pga.68.2018.12.06.17.40.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 17:40:57 -0800 (PST)
Date: Thu, 6 Dec 2018 17:40:57 -0800
From: Joel Fernandes <joel@joelfernandes.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 powerpc tree
Message-ID: <20181207014057.GA214249@google.com>
References: <20181206174417.45fe3e7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206174417.45fe3e7a@canb.auug.org.au>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 06, 2018 at 05:44:17PM +1100, Stephen Rothwell wrote:
> Hi Andrew,
> 
> Today's linux-next merge of the akpm-current tree got conflicts in:
> 
>   arch/powerpc/include/asm/book3s/32/pgalloc.h
>   arch/powerpc/include/asm/nohash/32/pgalloc.h
>   arch/powerpc/mm/pgtable-book3s64.c
> 
> between commits:
> 
>   a95d133c8643 ("powerpc/mm: Move pte_fragment_alloc() to a common location")
>   32ea4c149990 ("powerpc/mm: Extend pte_fragment functionality to PPC32")
> 
> from the powerpc tree and commit:
> 
>   913c2d755b39 ("mm: treewide: remove unused address argument from pte_alloc functions")
> 
> from the akpm-current tree.
> 
> I fixed it up (see below, plus the extra merge fix patch) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

The conflict resolution looks good to me.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
