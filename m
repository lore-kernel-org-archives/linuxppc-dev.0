Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE924ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 19:11:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62052054F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 19:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mSq0g4py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62052054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hYW64xfFzF3J9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 06:11:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="mSq0g4py";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="mSq0g4py"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hYSW0SY9zF3Hg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 06:08:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SabYTyncpD8UPUQFeRelrBxoXbfzyxS099TcIq9mJaQ=; b=mSq0g4pyoUK8es7/BgD+bw/HkX
 4h9DhC3UyLv2sLE7EP+VrPgMLu77T1avjQg1yS8fEM7KPvo2WjteyXPTDIb1ULoCbSeRgyVai0+fp
 0P38CmcrZ5RReUZkclxFn+5qIDTNbBOLCq3btUzvuhJFwbzAVWxKQqhBFtwnNJxNjB3ARhM5snZVM
 ATTaWTdvjFkJ0svThOWZ6Q5R4YafTHAaF84FxO6S6xxpCmmyMG5FAT3xmjj4Ohmg4VO0zta7HZm5G
 0Dk9FUMFs83NKCEWmUUfzYkk428soI7hkE8pB+km/mVBUbgEAGSLBdyv5QcEU/tWWyN/nY0Q4WhK5
 NSSWKoGA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gG71m-0008Sa-1Y; Fri, 26 Oct 2018 18:40:10 +0000
Date: Fri, 26 Oct 2018 11:40:09 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
Message-ID: <20181026184009.GV25444@bombadil.infradead.org>
References: <20181026172549.3628-1-colin.king@canonical.com>
 <CANiq72nFZS=3KGaQpGjRbprh8HTBiTcSpxScE2uacDmg-xqDGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nFZS=3KGaQpGjRbprh8HTBiTcSpxScE2uacDmg-xqDGA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: kernel-janitors@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Dave Airlie <airlied@linux.ie>, linuxppc-dev@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 maarten.lankhorst@linux.intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
 maxime.ripard@bootlin.com, jk@ozlabs.org, colin.king@canonical.com,
 sean@poorly.run
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 26, 2018 at 08:20:12PM +0200, Miguel Ojeda wrote:
> On Fri, Oct 26, 2018 at 7:27 PM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Trivial fix to a spelling mistake of the error access name EACCESS,
> > rename to EACCES
> 
> ? It is not a typo, it is the name of the error (POSIX). Same thing
> for the rest of the patches.

Are you sure?  From open(2):

       EACCES The  requested access to the file is not allowed, or search per‐
              mission is denied for one of the directories in the path  prefix
              of  pathname,  or the file did not exist yet and write access to
              the parent directory is not  allowed.   (See  also  path_resolu‐
              tion(7).)

include/uapi/asm-generic/errno-base.h:#define   EACCES          13      /* Permission denied */

