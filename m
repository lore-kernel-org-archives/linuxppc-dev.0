Return-Path: <SRS0=9qWD=TP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DF6C04E53
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 14:18:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413942084E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 14:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN0knMRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413942084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 453xVy6N9SzDqWl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 00:18:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="WN0knMRv"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 453xRs3vhlzDqM4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2019 00:16:09 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE5462084E;
 Wed, 15 May 2019 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1557929767;
 bh=nBsn7/9SkqhQaLs4aJMbNED/PvzJuaH0Nvbb1xhB1ds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WN0knMRvCCL1HFnQ8nQFtCpu4hbzkZzP0UtfAlnjItM1hQW429xwlxGPIuFUPBrD8
 BTqh9i+pGG9kqYAVI3zEBcpAZ6FxAxalF2be+eBc2h6MGk1lr00rjglbQAKN+mj19e
 K8loKcIQ3jwFdqT6d3iCtSycnkYwWlCjgbY21BZI=
Date: Wed, 15 May 2019 16:16:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH stable 4.4] powerpc/lib: fix book3s/32 boot failure due
 to code patching
Message-ID: <20190515141604.GB8999@kroah.com>
References: <71dbc8bdad5da9f6cb0446535fb2a29c68fccf80.1557926850.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71dbc8bdad5da9f6cb0446535fb2a29c68fccf80.1557926850.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: erhard_f@mailbox.org, Michael Neuling <mikey@neuling.org>,
 linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 15, 2019 at 01:30:42PM +0000, Christophe Leroy wrote:
> [Backport of upstream commit b45ba4a51cde29b2939365ef0c07ad34c8321789]
> 
> On powerpc32, patch_instruction() is called by apply_feature_fixups()
> which is called from early_init()
> 
> There is the following note in front of early_init():
>  * Note that the kernel may be running at an address which is different
>  * from the address that it was linked at, so we must use RELOC/PTRRELOC
>  * to access static data (including strings).  -- paulus
> 
> Therefore init_mem_is_free must be accessed with PTRRELOC()
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203597
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> Can't apply the upstream commit as such due to several other unrelated stuff
> like for instance STRICT_KERNEL_RWX which are missing.
> So instead, using same approach as for commit 252eb55816a6f69ef9464cad303cdb3326cdc61d
> 
> Removed the Fixes: tag as I don't know yet the commit Id of the fixed commit on 4.4 branch.
> ---
>  arch/powerpc/lib/code-patching.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now added, thanks.

greg k-h
