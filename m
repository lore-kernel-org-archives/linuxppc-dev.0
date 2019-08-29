Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33155C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 06:26:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89F52189D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 06:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O9yzkvqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89F52189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Jt134NGhzDr6l
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 16:26:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+c7f673d4bdabd04d2ac5+5849+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="O9yzkvqP"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Jsyg2QX6zDqnD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 16:24:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3JI7QotK2O20Md1eCkQSEHO4eOFyIfeK4uIFkYS8zQI=; b=O9yzkvqP60gDvRWGFRg1iYPukL
 DTswgHAsoTTZs2abhMX4SVtYr5V06YCD343I+LjhwegBYsWC4iVvh7ge3kMySB4w+A2ewqZUXiF9p
 +TaW+scgxAa5FgCPV966HbQ35APontkN4YwUN2EURzO/b9p7iGSwnnq3c6SCY4wNQ9dyFoNB12wHo
 Pjm2/Rcj16CLyuxOj5iM0Tisd9jGabkJTTv/fH7eRyrjrdkCsERr799lY5yoztovwNxNFWAK4aLxq
 UGqkACxUkTTp/w/6SL1AOZpncM/xnUVNP5VW5JZjTBxPCHbava+C3BdaLHIrBj1RIfDxkQRecRD8n
 MLKb2Vqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i3Dom-0002AM-IS; Thu, 29 Aug 2019 06:22:00 +0000
Date: Wed, 28 Aug 2019 23:22:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH 1/4] fs: always build llseek.
Message-ID: <20190829062200.GA3047@infradead.org>
References: <cover.1566936688.git.msuchanek@suse.de>
 <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
 <20190828151552.GA16855@infradead.org>
 <20190828181540.21fa33a4@naga>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828181540.21fa33a4@naga>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: David Hildenbrand <david@redhat.com>, "Dmitry V. Levin" <ldv@altlinux.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Breno Leitao <leitao@debian.org>, Michael Neuling <mikey@neuling.org>,
 Christoph Hellwig <hch@infradead.org>, Firoz Khan <firoz.khan@linaro.org>,
 Allison Randal <allison@lohutok.net>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Aug 28, 2019 at 06:15:40PM +0200, Michal Suchánek wrote:
> On Wed, 28 Aug 2019 08:15:52 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Tue, Aug 27, 2019 at 10:21:06PM +0200, Michal Suchanek wrote:
> > > 64bit !COMPAT does not build because the llseek syscall is in the tables.  
> > 
> > Well, this will bloat thinkgs like 64-bit RISC-V for no good reason.
> > Please introduce a WANT_LSEEK like symbol that ppc64 can select instead.
> 
> It also builds when llseek is marked as 32bit only in syscall.tbl
> 
> It seems it was handled specially in some way before syscall.tbl was
> added, though (removed in ab66dcc76d6ab8fae9d69d149ae38c42605e7fc5)

Independ of if you need it on a purely 64-bit build on powerpc (which
I'll let the experts figure out) it is not needed on a purely 64-bit
build on other platforms.  So please make sure it is still built
conditional, just possibly with an opt-in for powerpc.
